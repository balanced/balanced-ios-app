//
//  BAFactory.h
//  BalancedPayments
//
//  Created by Victor Lin on 2015/1/27.
//  Copyright (c) 2015年 Balanced Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAResource.h"

@interface BAFactory : NSObject

// map resources name to classes
@property (readonly, nonatomic) NSMutableDictionary *nameToClass;

// register a class for a given name
- (void) registerResource:(Class)resClass;
// create a resource for given name, data and links
- (BAResource *) createResourceForName:(NSString *)name data:(NSDictionary *)data links:(NSDictionary *)links api:(BAAPI *)api;

// return resource name from a given dict
+ (NSString *) resourceNameFromDict:(NSDictionary *)dict;
+ (BAFactory *) factory;
    
@end
