//
//  BAFactory.m
//  BalancedPayments
//
//  Created by Victor Lin on 2015/1/27.
//  Copyright (c) 2015年 Balanced Payments. All rights reserved.
//

#import <DDLog.h>
#import "BAFactory.h"
#import "BAResource.h"
#import "BAMarketplace.h"

static const int ddLogLevel = LOG_LEVEL_INFO;

@implementation BAFactory

- (id) initWithAPI:(BAAPI *)api {
    self = [super init];
    if (self) {
        _api = api;
        _nameToClass = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) registerResource:(Class)resClass {
    [self.nameToClass setObject:resClass forKey:[resClass resourceName]];
}

// TODO: find a better way to do this instead of importing and adding them manually here?
- (void) registerAllResources {
    [self registerResource:[BAMarketplace class]];
    // TODO: add more resources class here
}

- (BAResource *) createResourceForName:(NSString *)name data:(NSDictionary *)data links:(NSDictionary *)links {
    Class resClass = [self.nameToClass objectForKey:name];
    if (!resClass) {
        DDLogError(@"Failed to create resource for given name %@, no class found", name);
        return nil;
    }
    return [(BAResource *)[resClass alloc] initWithData:data links:links factory:self];
}

+ (NSString *) resourceNameFromDict:(NSDictionary *)dict {
    __block NSString *name = nil;
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([key isEqualToString:@"meta"] || [key isEqualToString:@"links"]) {
            return;
        }
        name = key;
        (*stop) = 1;
    }];
    return name;
}

+ (BAFactory *) factoryWithAPI:(BAAPI *)api {
    return [[BAFactory alloc] initWithAPI:api];
}

@end
