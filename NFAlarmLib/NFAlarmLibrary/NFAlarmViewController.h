//
//  NFAlarmLibrary.h
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 17/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFAlarmEditViewController.h"

@interface NFAlarmViewController : UITableViewController <NFAlarmEditViewControllerDelegate>
+ (instancetype)sharedInstance;
- (void) save;
@property (copy, nonatomic) NSMutableArray *alarms;
@end
