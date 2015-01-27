//
//  BAAPI.h
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PromiseKit.h>
#import <AFNetworking.h>

@interface BAAPI : NSObject

@property (nonatomic) NSString *baseURL;
@property (readonly, nonatomic) AFHTTPRequestOperationManager *httpManager;
@property (nonatomic) NSString *apiKey;

- (id) initWithBaseURL:(NSString *)baseURL;

// get current marketplace
- (PMKPromise *) myMarketplace;

// load resources
- (PMKPromise *) loadResourcesFromPath:(NSString *)path;

+ (BAAPI *) api;
    
@end

