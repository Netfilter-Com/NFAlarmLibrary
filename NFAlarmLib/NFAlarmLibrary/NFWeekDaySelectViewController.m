//
//  NFWeekDaySelectViewController.m
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 20/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import "NFWeekDaySelectViewController.h"

@interface NFWeekDaySelectViewController ()

@end

@implementation NFWeekDaySelectViewController

- (void)viewDidLoad {
	self.tableView.allowsMultipleSelection = YES;
	unsigned short x = (unsigned short)self.weekdays;
	unsigned int count = 0;
	while (x != 0)
	{
		unsigned short bit = x & 1;
		NSIndexPath * ip = [NSIndexPath indexPathForRow:count inSection:0];
		if( bit == 1 )
		{
			[self.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
			[self.tableView cellForRowAtIndexPath:ip].accessoryType = UITableViewCellAccessoryCheckmark;
		}
		else //zero
		{
			[self.tableView deselectRowAtIndexPath:ip animated:NO];
			[self.tableView cellForRowAtIndexPath:ip].accessoryType = UITableViewCellAccessoryNone;
		}
		count ++;
		x >>= 1;
	}
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) didMoveToParentViewController:(UIViewController *)parent
{
	if (parent == nil) {
		if ([self.delegate respondsToSelector:@selector(weekdayFinishedWithVeredict:)]) {
			[self.delegate weekdayFinishedWithVeredict:self.weekdays];
		}
	}
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"CellWeek";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	switch (indexPath.row) {
		case 0:
			cell.textLabel.text = @"Monday";
			break;
		case 1:
			cell.textLabel.text = @"Tuesday";
			break;
		case 2:
			cell.textLabel.text = @"Wednesday";
			break;
		case 3:
			cell.textLabel.text = @"Thursday";
			break;
		case 4:
			cell.textLabel.text = @"Friday";
			break;
		case 5:
			cell.textLabel.text = @"Saturday";
			break;
		case 6:
			cell.textLabel.text = @"Sunday";
			break;
		default:
			break;
	}
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
	short num = (short) self.weekdays;
	short e   = (short) indexPath.row;
	num = num | (1 << e);
	self.weekdays = num;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
	short num = (short) self.weekdays;
	short e   = (short) indexPath.row;
	num &= ~(1 << e);
	self.weekdays = num;
}


@end
