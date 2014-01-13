//
//  SparkComTest.m
//  Carspark
//
//  Created by Nate on 1/12/14.
//  Copyright (c) 2014 Nate Fanaro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SparkCom.h"

@interface SparkComTest : XCTestCase

@end

@implementation SparkComTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testClassLoad
{
    SparkCom *test = [[SparkCom alloc] init];
    NSLog(@"%@", [test description]);
}

- (void)testGetData {

    SparkCom *sparkcom = [[SparkCom alloc] init];    
    [sparkcom getDataForRequest:@"" requestType:@"GET" withOptons:nil withSelector:nil];
}

- (void)testCall
{
    
}


@end
