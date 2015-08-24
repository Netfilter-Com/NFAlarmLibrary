//
//  NFAlarmLib.h
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 24/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFAlarmEditViewController.h"
#import "NFAlarm.h"
#import "NFWeekDaySelectViewController.h"
#import "NFAlarmViewCell.h"
#import "NFAlarmViewController.h"

@interface NFAlarmLib : NSObject
+ (NFAlarmViewController *) createNFAlarmViewController;
+ (void) setLocalNotifications;
@end
