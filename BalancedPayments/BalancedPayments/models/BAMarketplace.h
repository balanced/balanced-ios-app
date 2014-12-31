//
//  BAMarketplace.h
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAResource.h"
#import <Foundation/Foundation.h>

@interface BAMarketplace : BAResource

@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *domainURL;
@property (readonly, nonatomic) NSInteger balance;
@property (readonly, nonatomic) NSInteger unsettledFees;
@property (readonly, nonatomic) BOOL production;

- (id) initWithData:(NSDictionary *)data;

@end
