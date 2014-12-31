//
//  BAResource.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAPage.h"
#import "BAResource.h"

@implementation BAResource

- (id) initWithData:(NSDictionary *)data links:(NSDictionary *)links api:(BAAPI *)api {
    self = [super init];
    if (self) {
        _api = api;
        _guid = data[@"id"];
        _href = data[@"href"];

        // TODO: should move this to utils
        // reference to http://stackoverflow.com/questions/17558859/convert-iso-8601-to-nsdate
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        // Always use this locale when parsing fixed format date strings
        NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [formatter setLocale:posix];
        
        _createdAt = [formatter dateFromString:data[@"created_at"]];
        _updatedAt = [formatter dateFromString:data[@"updated_at"]];
        
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
