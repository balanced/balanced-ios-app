//
//  BAModel.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAModel.h"

@implementation BAModel

- (id) init {
    self = [super init];
    if (self) {
        _api = [[BAAPI alloc] initWithBaseURL:@"https://api.balancedpayments.com"];
        _marketplaceUpdatedEvent = [BASubject subject];
    }
    return self;
}

- (void) load {
    __typeof(self) __weak weakSelf = self;
    [self.api myMarketplace].then(^(BAMarketplace *marketplace) {
        weakSelf.currentMarketplace = marketplace;
    });
}

- (void) setCurrentMarketplace:(BAMarketplace *)currentMarketplace {
    _currentMarketplace = currentMarketplace;
    [self.marketplaceUpdatedEvent notifyObserversWithObj:currentMarketplace];
}

@end
