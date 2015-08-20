//
//  NFAlarm.h
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 18/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
	kMon = 0x0000001,
	kTue = 0x0000010,
	kWed = 0x0000100,
	kThu = 0x0001000,
	kFri = 0x0010000,
	kSat = 0x0100000,
	kSun = 0x1000000
} NFWeekDayBinaryPicker;

@interface NFAlarm : NSObject
@property (copy, nonatomic)   NSString *alarmName;
@property (assign, nonatomic) NSInteger hour;
@property (assign, nonatomic) NSInteger minute;
@property (readonly, nonatomic) NSString *AMPM;
@property (readonly, nonatomic) NSString *time;
@property (assign, nonatomic) NSInteger weekdays;
@property (assign, nonatomic) BOOL enabled;

+ (instancetype) initWithName:(NSString *)name hour:(NSInteger)hour minute:(NSInteger)minute weekdays:(NSInteger)weekdays enabled:(BOOL)enabled;
+ (instancetype) initWithDict:(NSDictionary *) dict;
- (NSString *) weekdaysText;
- (NSDictionary *) toDict;
@end
