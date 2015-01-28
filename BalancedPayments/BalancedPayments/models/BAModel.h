//
//  BAModel.h
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAAPI.h"
#import "BAFactory.h"
#import "BASubject.h"
#import "BAMarketplace.h"

@interface BAModel : NSObject

@property (readonly, nonatomic) BAAPI *api;
@property (readonly, nonatomic) BAFactory *factory;
// current marketplace
@property (nonatomic) BAMarketplace *currentMarketplace;

// called when marketplace is updated
@property (readonly, nonatomic) BASubject *marketplaceUpdatedEvent;

// load model
- (void) load;

+ (BAModel *)model;
    
@end
