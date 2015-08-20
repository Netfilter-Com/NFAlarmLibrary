//
//  NFWeekDaySelectViewController.h
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 20/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NFWeekDaySelectViewControllerDelegate;

@interface NFWeekDaySelectViewController : UITableViewController
@property (assign, nonatomic) id<NFWeekDaySelectViewControllerDelegate> delegate;
@property (assign, nonatomic) NSInteger weekdays;
@end


@protocol NFWeekDaySelectViewControllerDelegate <NSObject>

- (void) weekdayFinishedWithVeredict:(NSInteger)weekdays;

@end