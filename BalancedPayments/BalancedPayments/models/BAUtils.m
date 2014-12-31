//
//  BAUtils.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BAUtils.h"

@implementation BAUtils

+ (NSDate *) dateFromISOString:(NSString *)iso8610 {
    // reference to http://stackoverflow.com/questions/17558859/convert-iso-8601-to-nsdate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    // Always use this locale when parsing fixed format date strings
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    return [formatter dateFromString:iso8610];
}

@end
