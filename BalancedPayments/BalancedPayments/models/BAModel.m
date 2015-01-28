//
//  BAModel.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAModel.h"
#import "BAPage.h"

@interface BAModel()

@property (readonly, nonatomic) BAPage *marketplacePage;

@end

@implementation BAModel

- (id) init {
    self = [super init];
    if (self) {
        _api = [BAAPI api];
        _factory = [BAFactory factoryWithAPI:self.api];
        _marketplacePage = [BAPage pageWithPath:@"/marketplaces" factory:self.factory];
        _marketplaceUpdatedEvent = [BASubject subject];
        
        [self.factory registerAllResources];
    }
    return self;
}

- (void) load {
    __typeof(self) __weak weakSelf = self;
    [self.marketplacePage loadNextPage].then(^(NSArray *objects) {
        weakSelf.currentMarketplace = self.marketplacePage.objects[0];
    });
}

- (void) setCurrentMarketplace:(BAMarketplace *)currentMarketplace {
    _currentMarketplace = currentMarketplace;
    [self.marketplaceUpdatedEvent notifyObserversWithObj:currentMarketplace];
}

+ (BAModel *)model {
    return [[BAModel alloc] init];
}

@end
