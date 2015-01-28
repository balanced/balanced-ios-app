//
//  TestResource.m
//  BalancedPayments
//
//  Created by Victor Lin on 2015/1/27.
//  Copyright (c) 2015年 Balanced Payments. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BAMarketplace.h"

@interface TestResource : XCTestCase

@end

@implementation TestResource

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResolveLink {
    NSDictionary *dict = @{@"id": @"my_mp"};
    XCTAssertEqualObjects([BAMarketplace resolveLink:@"/foobar" data:dict], @"/foobar");
    XCTAssertEqualObjects([BAMarketplace resolveLink:@"/foo/bar" data:dict], @"/foo/bar");
    XCTAssertEqualObjects([BAMarketplace resolveLink:@"/foobar/{marketplaces.id}" data:dict], @"/foobar/my_mp");
    XCTAssertEqualObjects([BAMarketplace resolveLink:@"/foobar/{marketplaces.id}/yolo" data:dict], @"/foobar/my_mp/yolo");
    
    // ensure bad path will pass through
    XCTAssertEqualObjects([BAMarketplace resolveLink:@"/foobar/{not_exists.id}/yolo" data:dict], @"/foobar/{not_exists.id}/yolo");
    
    // value not available
    XCTAssertEqualObjects([BAMarketplace resolveLink:@"/foobar/{marketplaces.non_exists}/yolo" data:dict], @"/foobar/{marketplaces.non_exists}/yolo");
    
    // ensure key/value in links can also be referenced
    dict = @{@"id": @"my_mp", @"links": @{@"owner_customer": @"super-customer"}};
    XCTAssertEqualObjects([BAMarketplace resolveLink:@"/foobar/{marketplaces.owner_customer}/yolo" data:dict], @"/foobar/super-customer/yolo");
    
    // ensure multiple references work
    XCTAssertEqualObjects([BAMarketplace resolveLink:@"/foobar/{marketplaces.owner_customer}/yolo/{marketplaces.id}/spam" data:dict], @"/foobar/super-customer/yolo/my_mp/spam");
}

@end
