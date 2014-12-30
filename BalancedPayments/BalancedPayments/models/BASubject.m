//
//  BASubject.m
//  BalancedPayments
//
//  Created by Victor Lin on 2014/12/29.
//  Copyright (c) 2014年 Balanced Payments. All rights reserved.
//

#import "BASubject.h"

@implementation BASubject

- (id) init {
    self = [super init];
    if (self) {
        _serialNumber = 0;
        _observers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSUInteger) subscribeObserver:(ObserverBlock)block {
    NSUInteger observerID = self.serialNumber;
    [_observers setObject:block forKey: [NSNumber numberWithInteger:self.serialNumber]];
    ++_serialNumber;
    return observerID;
}

- (void) notifyObserversWithObj:(id) obj {
    [self.observers enumerateKeysAndObjectsUsingBlock:^(id key, id block_obj, BOOL *stop) {
        ObserverBlock block = block_obj;
        block(obj);
    }];
}

- (void) unsubscribeObserver:(NSUInteger)observerID {
    [self.observers removeObjectForKey:[NSNumber numberWithInteger:observerID]];
}

+ (id) subject {
    return [[BASubject alloc] init];
}

@end
