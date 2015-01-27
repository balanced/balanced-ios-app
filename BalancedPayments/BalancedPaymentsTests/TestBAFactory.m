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

- (void)testCreateResource {
    BAFactory *factory = [BAFactory factory];
    BAAPI *api = [BAAPI api];
    [factory registerResource:[BAMarketplace class]];
    
    NSDictionary *data = @{
        @"name": @"test mp",
        @"domain_url": @"http://foobar.com",
        @"in_escrow": @1234,
        @"unsettled_fees": @5678,
        @"production": [NSNumber numberWithBool:YES],
    };
    NSDictionary *links = @{};
    BAMarketplace *marketplace = (BAMarketplace *)[factory createResourceForName:@"marketplaces" data:data links:links api:api];
    XCTAssertTrue([marketplace isKindOfClass:[BAMarketplace class]]);
    XCTAssertEqualObjects(marketplace.name, @"test mp");
    XCTAssertEqualObjects(marketplace.domainURL, @"http://foobar.com");
    XCTAssertEqual(marketplace.balance, 1234);
    XCTAssertEqual(marketplace.unsettledFees, 5678);
    XCTAssertTrue(marketplace.production);
}

@end
