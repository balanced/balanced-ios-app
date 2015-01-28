//
//  BADebit.m
//  BalancedPayments
//
//  Created by Victor Lin on 2015/1/27.
//  Copyright (c) 2015年 Balanced Payments. All rights reserved.
//

#import "BADebit.h"

@implementation BADebit

- (id) initWithData:(NSDictionary *)data links:(NSDictionary *)links factory:(BAFactory *)factory {
    self = [super initWithData:data links:links factory:factory];
    if (self) {
        _amount = [data[@"amount"] integerValue];
        _currency = data[@"currency"];
        // FIXME:
    }
    return self;
}

+ (NSString *)resourceName {
    return @"debits";
}

@end
