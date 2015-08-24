//
//  NFAlarmEditViewController.h
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 20/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFAlarm.h"
#import "NFWeekDaySelectViewController.h"

@protocol NFAlarmEditViewControllerDelegate;

@interface NFAlarmEditViewController : UITableViewController <UIPickerViewDelegate, NFWeekDaySelectViewControllerDelegate>
@property (assign, nonatomic) id<NFAlarmEditViewControllerDelegate> delegate;
@property (nonatomic, strong) NFAlarm * alarm;
@property (nonatomic, strong) UIDatePicker * hourPicker;
@property (strong, nonatomic) UITextField * name;
@end

@protocol NFAlarmEditViewControllerDelegate <NSObject>
- (void) alarmFinishEditing:(NFAlarm *) alarm;
@end