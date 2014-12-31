//
//  BAResource.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAUtils.h"
#import "BAPage.h"
#import "BAResource.h"

@implementation BAResource

- (id) initWithData:(NSDictionary *)data links:(NSDictionary *)links api:(BAAPI *)api {
    self = [super init];
    if (self) {
        _api = api;
        _guid = data[@"id"];
        _href = data[@"href"];

        _createdAt = [BAUtils dateFromISOString:data[@"created_at"]];
        _updatedAt = [BAUtils dateFromISOString:data[@"updated_at"]];
        
        _resources = [NSMutableDictionary dictionary];
        [links enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *path, BOOL *stop) {
            NSArray *parts = [key componentsSeparatedByString:@"."];
            NSString *linkName = [[parts subarrayWithRange:NSMakeRange(1, parts.count - 1)] componentsJoinedByString:@"."];
            // TODO: handle pattern path link /customers/{marketplaces.owner_customer}
            NSString *initialPath = [NSString stringWithFormat:@"%@%@", self.href, path];
            BAPage *page = [[BAPage alloc] initWithInitialPath:initialPath api:self.api];
            [self.resources setValue:page forKey:linkName];
        }];
    }
    return self;
}

+ (NSString *)resourceName {
    return nil;
}

@end
