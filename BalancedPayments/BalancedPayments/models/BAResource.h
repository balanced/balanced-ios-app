//
//  BAResource.h
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAResource : NSObject

@property (readonly, nonatomic) NSString *guid;
@property (readonly, nonatomic) NSString *href;
@property (readonly, nonatomic) NSDate *createdAt;
@property (readonly, nonatomic) NSDate *updatedAt;

- (id) initWithData:(NSDictionary *)data;

@end
