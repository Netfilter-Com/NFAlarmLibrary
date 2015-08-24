//
//  NFAlarmViewCell.h
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 24/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFAlarmViewCell : UITableViewCell
@property (strong, nonatomic) UISwitch *alarmOn;
@property (strong, nonatomic) UILabel *hour;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *repeat;
@end
