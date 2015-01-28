//
//  BAResource.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import <DDLog.h>
#import "BAUtils.h"
#import "BAPage.h"
#import "BAResource.h"

static const int ddLogLevel = LOG_LEVEL_INFO;

@implementation BAResource

- (id) initWithData:(NSDictionary *)data links:(NSDictionary *)links factory:(BAFactory *)factory {
    self = [super init];
    if (self) {
        _factory = factory;
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
            BAPage *page = [BAPage pageWithPath:initialPath factory:self.factory];
            [self.resources setValue:page forKey:linkName];
        }];
    }
    return self;
}

+ (NSString *)resourceName {
    return nil;
}

+ (NSString *)resolveLink:(NSString *)link data:(NSDictionary *)data {
    NSError  *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\{([a-zA-Z0-9._-]+)\\}" options:0 error:&error];
    NSMutableArray *resultParts = [NSMutableArray array];
    __block BOOL succeeded = YES;
    __block NSUInteger lastPos = 0;
    NSArray *matches = [regex matchesInString:link options:0 range:NSMakeRange(0, link.length)];
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *match, NSUInteger idx, BOOL *stop) {
        NSString *path = [link substringWithRange:[match rangeAtIndex:1]];
        NSArray *parts = [path componentsSeparatedByString:@"."];
        if (parts.count != 2) {
            DDLogError(@"We expected to see the link path looks like 'resource_name.attribute' , but we got %@ instead", path);
            // TODO: raise error
            succeeded = NO;
            (*stop) = YES;
            return;
        }
        NSString *resName = parts[0];
        if (![resName isEqualToString:[self resourceName]]) {
            DDLogError(@"Unknown resource name %@, expected %@, cannot resolve", resName, [self resourceName]);
            // TODO: raise error
            succeeded = NO;
            (*stop) = YES;
            return;
        }
        NSString *suffixKey = parts[1];
        id value = data[suffixKey];
        if (!value || [value isEqual:[NSNull null]]) {
            NSDictionary *links = data[@"links"];
            if (links) {
                value = links[suffixKey];
            }
        }
        // TODO: if value is not available
        DDLogDebug(@"Resolved value %@ to %@", path, value);
        NSRange wholeRange = [match rangeAtIndex:0];
        NSString *previousPart = [link substringWithRange:NSMakeRange(lastPos, (wholeRange.location - lastPos))];
        NSString *replacedPart = [NSString stringWithFormat:@"%@", value];
        [resultParts addObject:previousPart];
        [resultParts addObject:replacedPart];
        lastPos = wholeRange.location + wholeRange.length;
    }];
    
    NSString *tailPart = [link substringWithRange:NSMakeRange(lastPos, link.length - lastPos)];
    [resultParts addObject:tailPart];
    return [resultParts componentsJoinedByString:@""];
}

@end
