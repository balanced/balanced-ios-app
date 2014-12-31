//
//  BAResource.h
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAAPI.h"
#import <Foundation/Foundation.h>

@interface BAResource : NSObject

@property (readonly, nonatomic, weak) BAAPI *api;
@property (readonly, nonatomic) NSString *guid;
@property (readonly, nonatomic) NSString *href;
@property (readonly, nonatomic) NSDate *createdAt;
@property (readonly, nonatomic) NSDate *updatedAt;
@property (readonly, nonatomic) NSDictionary *resources;

- (id) initWithData:(NSDictionary *)data links:(NSDictionary *)links api:(BAAPI *)api;

+ (NSString *)resourceName;

@end
