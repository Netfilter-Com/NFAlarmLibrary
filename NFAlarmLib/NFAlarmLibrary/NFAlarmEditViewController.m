//
//  NFAlarmEditViewController.m
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 20/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import "NFAlarmEditViewController.h"

@interface NFAlarmEditViewController ()

@end

@implementation NFAlarmEditViewController

- (instancetype)init
{
	self = [super initWithStyle:UITableViewStyleGrouped];
	if (self) {
		
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSouce
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch (section) {
		case 0:
			return 1;
		case 1:
			return 2;
		default:
			return 0;
	}
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	switch (indexPath.section) {
		case 0:
		{
			self.hourPicker = [[UIDatePicker alloc] init];
			[self.hourPicker setDatePickerMode:UIDatePickerModeTime];
			[cell addSubview:self.hourPicker];
		}
		break;
		case 1:
		{
			if (indexPath.row == 0) {
				UITextField * tf = [[UITextField alloc] initWithFrame:cell.frame];
				tf.text = self.alarm.alarmName;
				tf.font = [UIFont fontWithName:@"HelveticaNeue" size:24.0f];
				tf.textAlignment = NSTextAlignmentCenter;
				tf.placeholder = NSLocalizedString(@"Reminder Name", nil);
				tf.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
				[cell addSubview:tf];
			} else {
				cell.textLabel.text = NSLocalizedString(@"Repeat", nil);
				cell.detailTextLabel.text = self.alarm.weekdaysText;
			}
		}
		default:
		break;
	}
	return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		return 216.0;
	}
	return 70.0f;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1) {
		if (indexPath.row == 1) {
			NFWeekDaySelectViewController * nfwdsvc = [[NFWeekDaySelectViewController alloc] initWithStyle:UITableViewStylePlain];
			nfwdsvc.delegate = self;
			nfwdsvc.weekdays = self.alarm.weekdays;
			[self.navigationController pushViewController:nfwdsvc animated:YES];
		}
	}
}

#pragma mark - NFWeekDaySelectViewControllerDelegate
- (void) weekdayFinishedWithVeredict:(NSInteger)weekdays
{
	self.alarm.weekdays = weekdays;
	[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
}


@end
