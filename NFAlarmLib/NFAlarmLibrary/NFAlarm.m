//
//  NFAlarm.m
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 18/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import "NFAlarm.h"

@interface NSString (helper)
- (NSString *)stringByAppendingCommaString:(NSString *)str;
@end

@implementation NSString (helper)
- (NSString *)stringByAppendingCommaString:(NSString *)str {
	if ([self length] > 0) {
		return [self stringByAppendingFormat:@", %@",str];
	}
	return [self stringByAppendingString:str];
}
@end


@implementation NFAlarm
+ (instancetype) initWithName:(NSString *)name hour:(NSInteger)hour minute:(NSInteger)minute weekdays:(NSInteger)weekdays enabled:(BOOL)enabled;
{
	NFAlarm * alarm = [NFAlarm new];
	alarm.hour = hour;
	alarm.minute = minute;
	alarm.enabled = enabled;
	alarm.weekdays = weekdays;
	alarm.alarmName = name;
	return alarm;
}

+ (instancetype) initWithDict:(NSDictionary *) dict
{
	NFAlarm * alarm = [NFAlarm new];
	alarm.hour = [dict[@"hour"] integerValue];
	alarm.minute = [dict[@"minute"] integerValue];
	alarm.enabled = [dict[@"enabled"] boolValue];
	alarm.weekdays = [dict[@"weekdays"] integerValue];
	alarm.alarmName = dict[@"name"];
	return alarm;
}

- (NSDictionary *) toDict
{
	NSMutableDictionary *m = [NSMutableDictionary dictionary];
	m[@"hour"] = [NSNumber numberWithInteger:self.hour];
	m[@"minute"] = [NSNumber numberWithInteger:self.minute];
	m[@"enabled"] = [NSNumber numberWithBool:self.enabled];
	m[@"name"] = self.alarmName;
	m[@"weekdays"] = [NSNumber numberWithInteger:self.weekdays];
	return m;
}

-(NSString *) AMPM
{
	if (self.hour > 11) {
		return @"PM";
	}
	else {
		return @"AM";
	}
}

- (NSString *) time
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.timeStyle = NSDateFormatterShortStyle;
	dateFormatter.dateStyle = NSDateFormatterNoStyle;
	NSDate * dt = [[NSCalendar autoupdatingCurrentCalendar]
				   dateWithEra:1
				   year:2015
				   month:12
				   day:01
				   hour:self.hour
				   minute:self.minute
				   second:0
				   nanosecond:0];
	return [dateFormatter stringFromDate:dt];
}

- (NSString *) weekdaysText
{
	NSString * ret = @"";
	unsigned short weekdays_s = (unsigned short) self.weekdays;
	if (weekdays_s == 127) {
		return NSLocalizedString(@"Everyday", nil);
	}
	if (weekdays_s == 96) {
		return NSLocalizedString(@"Weekend", nil);
	}
	if (weekdays_s == 31) {
		return NSLocalizedString(@"Weekdays", nil);
	}
	// Code to return each day
	if ((weekdays_s & (1 << 6)) > 0) {
		ret = [ret stringByAppendingCommaString:NSLocalizedString(@"Sun", @"Sunday")];
	}
	if ((weekdays_s & (1 << 0)) > 0) {
		ret = [ret stringByAppendingCommaString:NSLocalizedString(@"Mon", @"Monday")];
	}
	if ((weekdays_s & (1 << 1)) > 0) {
		ret = [ret stringByAppendingCommaString:NSLocalizedString(@"Tue", @"Tuesday")];
	}
	if ((weekdays_s & (1 << 2)) > 0) {
		ret = [ret stringByAppendingCommaString:NSLocalizedString(@"Wed", @"Wednesday")];
	}
	if ((weekdays_s & (1 << 3)) > 0) {
		ret = [ret stringByAppendingCommaString:NSLocalizedString(@"Thu", @"Thursday")];
	}
	if ((weekdays_s & (1 << 4)) > 0) {
		ret = [ret stringByAppendingCommaString:NSLocalizedString(@"Fri", @"Friday")];
	}
	if ((weekdays_s & (1 << 5)) > 0) {
		ret = [ret stringByAppendingCommaString:NSLocalizedString(@"Sat", @"Saturday")];
	}
	return ret;
}


@end
