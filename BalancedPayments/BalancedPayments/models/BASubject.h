//
//  BASubject.h
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ObserverBlock)(id);

@interface BASubject : NSObject

@property (readonly, nonatomic) NSUInteger serialNumber;
@property (readonly, nonatomic) NSMutableDictionary *observers;

/*
 Subscribe a block to this observer, return the observer id
 */
- (NSUInteger) subscribeObserver:(ObserverBlock)block;

/*
 Notify all observers with given object
 */
- (void) notifyObserversWithObj:(id) obj;

/*
 Stop subscription of an observer from this subject
 */
- (void) unsubscribeObserver:(NSUInteger)observerID;

+ (id) subject;

@end
