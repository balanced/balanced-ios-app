//
//  BAMarketplace.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAMarketplace.h"

@implementation BAMarketplace

- (id) initWithData:(NSDictionary *)data {
    self = [super initWithData:data];
    if (self) {
        _name = data[@"name"];
        _domainURL = data[@"domain_url"];
        _balance = [data[@"in_escrow"] integerValue];
        _unsettledFees = [data[@"unsettled_fees"] integerValue];
        _production = [data[@"production"] boolValue];
    }
    return self;
}

@end
