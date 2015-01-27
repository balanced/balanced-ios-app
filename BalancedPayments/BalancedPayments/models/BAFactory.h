//
//  BAFactory.h
//  BalancedPayments
//
//  Created by Victor Lin on 2015/1/27.
//  Copyright (c) 2015年 Balanced Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAAPI.h"

@class BAResource;

@interface BAFactory : NSObject

// balanced API
@property (readonly, nonatomic, weak) BAAPI *api;
// map resources name to classes
@property (readonly, nonatomic) NSMutableDictionary *nameToClass;

- (id) initWithAPI:(BAAPI *)api;
// register a class for a given name
- (void) registerResource:(Class)resClass;
// create a resource for given name, data and links
- (BAResource *) createResourceForName:(NSString *)name data:(NSDictionary *)data links:(NSDictionary *)links;

// return resource name from a given dict
+ (NSString *) resourceNameFromDict:(NSDictionary *)dict;
+ (BAFactory *) factoryWithAPI:(BAAPI *)api;
    
@end
