//
//  BAResource.h
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAFactory.h"

@interface BAResource : NSObject

@property (readonly, nonatomic, weak) BAFactory *factory;
@property (readonly, nonatomic) NSString *guid;
@property (readonly, nonatomic) NSString *href;
@property (readonly, nonatomic) NSDate *createdAt;
@property (readonly, nonatomic) NSDate *updatedAt;
@property (readonly, nonatomic) NSDictionary *resources;

- (id) initWithData:(NSDictionary *)data links:(NSDictionary *)links factory:(BAFactory *)factory;

+ (NSString *)resourceName;
+ (NSString *)resolveLink:(NSString *)link data:(NSDictionary *)data;

@end
