//
//  BAFactory.m
//  BalancedPayments
//
//  Created by Victor Lin on 2015/1/27.
//  Copyright (c) 2015年 Balanced Payments. All rights reserved.
//

#import "BAFactory.h"

@implementation BAFactory

- (id) init {
    self = [super init];
    if (self) {
        _nameToClass = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) registerResource:(Class)resClass {
    [self.nameToClass setObject:resClass forKey:[resClass resourceName]];
}

- (BAResource *) createResourceForName:(NSString *)name data:(NSDictionary *)data links:(NSDictionary *)links api:(BAAPI *)api {
    BAResource *resource = nil;
    Class resClass = [self.nameToClass objectForKey:name];
    if (!resClass) {
        return resource;
    }
    resource = [(BAResource *)[resClass alloc] initWithData:data links:links api:api];
    return resource;
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

+ (BAFactory *) factory {
    return [[BAFactory alloc] init];
}

@end
