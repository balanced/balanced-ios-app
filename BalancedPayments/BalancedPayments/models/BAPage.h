//
//  BAPage.h
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/31.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAAPI.h"
#import "BASubject.h"
#import "BAFactory.h"

// the object for loading resources over pages
@interface BAPage : NSObject

@property (readonly, nonatomic, weak) BAFactory *factory;
@property (readonly, nonatomic) NSString *initialPath;
@property (readonly, nonatomic) NSString *nextPath;
@property (readonly, nonatomic) NSMutableArray *objects;

// called when a new page is loaded
@property (readonly, nonatomic) BASubject *pageLoadedEvent;

- (id) initWithPath:(NSString *)path factory:(BAFactory *)factory;
- (PMKPromise *) loadNextPage;

+ (BAPage *) pageWithPath:(NSString *)path factory:(BAFactory *)factory;

@end
