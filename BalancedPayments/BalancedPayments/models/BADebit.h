//
//  BADebit.h
//  BalancedPayments
//
//  Created by Victor Lin on 2015/1/27.
//  Copyright (c) 2015年 Balanced Payments. All rights reserved.
//

#import "BAResource.h"

@interface BADebit : BAResource

@property (readonly, nonatomic) NSInteger amount;
@property (readonly, nonatomic) NSString *currency;

@end
