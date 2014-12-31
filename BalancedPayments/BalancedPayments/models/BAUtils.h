//
//  BAUtils.h
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAUtils : NSObject

// parse ISO 8610 and return date object
+ (NSDate *) dateFromISOString:(NSString *)iso8610;

@end
