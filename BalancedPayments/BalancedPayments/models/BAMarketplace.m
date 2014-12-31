//
//  BAMarketplace.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAMarketplace.h"

@implementation BAMarketplace

- (id) initWithData:(NSDictionary *)data links:(NSDictionary *)links api:(BAAPI *)api {
    self = [super initWithData:data links:links api:api];
    if (self) {
        _name = data[@"name"];
        _domainURL = data[@"domain_url"];
        _balance = [data[@"in_escrow"] integerValue];
        _unsettledFees = [data[@"unsettled_fees"] integerValue];
        _production = [data[@"production"] boolValue];
    }
    return self;
}

+ (NSString *)resourceName {
    return @"marketplaces";
}

@end
