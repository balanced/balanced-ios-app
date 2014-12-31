//
//  BAResource.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAResource.h"

@implementation BAResource

- (id) initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
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
    }
    return self;
}

@end
