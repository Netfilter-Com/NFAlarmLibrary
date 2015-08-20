//
//  NFAlarmLibTests.m
//  NFAlarmLibTests
//
//  Created by Pedro Paulo Oliveira Junior on 17/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NFAlarm.h"

@interface NFAlarmLibTests : XCTestCase

@end

@implementation NFAlarmLibTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
	NFAlarm * alarm = [[NFAlarm alloc] init];
	alarm.hour = 15;
	alarm.minute = 10;
    XCTAssert([alarm.time isEqualToString:@"3:10 PM"], @"Time US Format");
}

- (void) testMonday
{
	NFAlarm * alarm = [[NFAlarm alloc] init];
	alarm.weekdays = 1;
	XCTAssert([alarm.weekdaysText isEqualToString:@"Mon"]);
}

- (void) testTuesday
{
	NFAlarm * alarm = [[NFAlarm alloc] init];
	alarm.weekdays = 2;
	XCTAssert([alarm.weekdaysText isEqualToString:@"Tue"]);
}

- (void) testTuesdayMonday
{
	NFAlarm * alarm = [[NFAlarm alloc] init];
	alarm.weekdays = 3;
	XCTAssert([alarm.weekdaysText isEqualToString:@"Mon, Tue"]);
}

- (void) testNFDay1
{
	NFAlarm * alarm = [[NFAlarm alloc] init];
	alarm.weekdays = (1 << 1) | (1 << 3);
	XCTAssert([alarm.weekdaysText isEqualToString:@"Tue, Thu"]);
}

- (void) testNFDay2
{
	NFAlarm * alarm = [[NFAlarm alloc] init];
	alarm.weekdays = (1 << 1) | (1 << 4);
	XCTAssert([alarm.weekdaysText isEqualToString:@"Tue, Fri"]);
}

- (void) testAllDays
{
	NFAlarm * alarm = [[NFAlarm alloc] init];
	for (int i = 0; i < 7; i++) {
		alarm.weekdays |= (1 << i);
	}
	XCTAssert([alarm.weekdaysText isEqualToString:@"Everyday"]);
}

- (void) testWorkdays
{
	NFAlarm * alarm = [[NFAlarm alloc] init];
	for (int i = 0; i < 5; i++) {
		alarm.weekdays |= (1 << i);
	}
	XCTAssert([alarm.weekdaysText isEqualToString:@"Weekdays"]);
}

- (void) testWeekends
{
	NFAlarm * alarm = [[NFAlarm alloc] init];
	for (int i = 5; i < 7; i++) {
		alarm.weekdays |= (1 << i);
	}
	XCTAssert([alarm.weekdaysText isEqualToString:@"Weekend"]);
}


@end
