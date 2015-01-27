//
//  TestBAFactory.m
//  BalancedPayments
//
//  Created by Victor Lin on 2015/1/27.
//  Copyright (c) 2015年 Balanced Payments. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BAFactory.h"
#import "BAMarketplace.h"

@interface TestBAFactory : XCTestCase

@end

@implementation TestBAFactory

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNameFromDict {
    NSDictionary *dict = @{};
    XCTAssertEqualObjects([BAFactory resourceNameFromDict:dict], nil);
    
    dict = @{
        @"meta": @{},
        @"links": @{}
    };
    XCTAssertEqualObjects([BAFactory resourceNameFromDict:dict], nil);

    dict = @{
        @"meta": @{},
        @"links": @{},
        @"foobar": @{}
    };
    XCTAssertEqualObjects([BAFactory resourceNameFromDict:dict], @"foobar");
}

- (void)testRegisterResources {
    BAFactory *factory = [BAFactory factory];
    [factory registerResource:[BAMarketplace class]];
    XCTAssertEqualObjects(factory.nameToClass, @{[BAMarketplace resourceName]: [BAMarketplace class]});
}

@end
