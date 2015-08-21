//
//  NFAlarmLibrary.h
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 17/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFAlarmViewController : UITableViewController
+ (instancetype)sharedInstance;
- (void) save;
@property (copy, nonatomic) NSArray *alarms;
@end
