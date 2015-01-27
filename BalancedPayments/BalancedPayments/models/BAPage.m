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

- (id) initWithPath:(NSString *)path factory:(BAFactory *)factory {
    self = [super init];
    if (self) {
        _initialPath = path;
        _nextPath = path;
        _factory = factory;
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
    PMKPromise *promise = [self.factory.api loadResourcesFromPath:self.nextPath].then(^(NSDictionary *response) {
        NSLog(@"xxx %@", response);
        id nextPage = response[@"next"];
        if ([nextPage isEqual:[NSNull null]]) {
            [weakSelf _updateNextPath:nil];
        } else {
            [weakSelf _updateNextPath:nextPage];
        }
        NSMutableArray *newObjects = [NSMutableArray array];
        NSString *resourceName = [BAFactory resourceNameFromDict:response];
        NSArray *pageObjects = response[resourceName];
        NSDictionary *links = response[@"links"];
        [pageObjects enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger idx, BOOL *stop) {
            BAResource *object = [weakSelf.factory createResourceForName:resourceName data:data links:links];
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

+ (BAPage *) pageWithPath:(NSString *)path factory:(BAFactory *)factory {
    return [[BAPage alloc] initWithPath:path factory:factory];
}

@end
