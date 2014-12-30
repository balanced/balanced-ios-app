//
//  BAModel.h
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAAPI.h"
#import "BASubject.h"
#import "BAMarketplace.h"

@interface BAModel : NSObject

@property (readonly, nonatomic) BAAPI *api;
// current marketplace
@property (nonatomic) BAMarketplace *currentMarketplace;

// called when marketplace is updated
@property (readonly, nonatomic) BASubject *marketplaceUpdatedEvent;

// load model
- (void) load;

@end
