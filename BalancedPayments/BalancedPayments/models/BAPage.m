//
//  BAPage.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAMarketplace.h"
#import "BAPage.h"

@implementation BAPage

- (id) initWithInitialPath:(NSString *)path api:(BAAPI *)api {
    self = [super init];
    if (self) {
        _initialPath = path;
        _nextPath = path;
        _api = api;
        _objects = [NSMutableArray array];
        _pageLoadedEvent = [BASubject subject];
    }
    return self;
}

- (PMKPromise *) loadNextPage {
    if (!self.nextPath) {
        // TODO: raise error
    }
    __typeof(self) __weak weakSelf = self;
    PMKPromise *promise = [self.api loadResourcesFromPath:self.nextPath].then(^(NSDictionary *response) {
        NSLog(@"xxx %@", response);
        id nextPage = response[@"next"];
        if ([nextPage isEqual:[NSNull null]]) {
            [weakSelf _updateNextPath:nil];
        } else {
            [weakSelf _updateNextPath:nextPage];
        }
        NSMutableArray *newObjects = [NSMutableArray array];
        NSArray *pageObjects = response[@"marketplaces"];
        [pageObjects enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger idx, BOOL *stop) {
            // TODO: determine what kind of resource it is
            BAResource *object = [[BAMarketplace alloc] initWithData:data links:response[@"links"] api:self.api];
            [newObjects addObject:object];
            
        }];
        [self.objects addObjectsFromArray:newObjects];
        [weakSelf.pageLoadedEvent notifyObserversWithObj:newObjects];
        return ;
    });
    // TODO: handle error
    return promise;
}

- (void) _updateNextPath:(NSString *)nextPath {
    _nextPath = nextPath;
}

@end
