//
//  NFAlarmLibrary.m
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 17/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import "NFAlarmViewController.h"
#import "NFAlarm.h"
#import "NFAlarmEditViewController.h"
#import "NFAlarmViewCell.h"

#define NFALARMLIBSTR @"nf_alarm_library_string"
#define NFALARMLIBCELLID @"f_alarm_library_cell_id"

@interface NFAlarmViewController ()
@end

@implementation NFAlarmViewController

/**
 *  Singleton usage of NFAlarmViewContoller
 *
 *  @return shared Instance of the Class
 */
+ (instancetype)sharedInstance {
	static NFAlarmViewController *_sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedInstance = [[NFAlarmViewController alloc] init];
	});
	
	return _sharedInstance;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.alarms = nil;
	}
	return self;
}

- (instancetype) initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		self.alarms = nil;
	}
	return self;
}

- (void) viewDidLoad
{
	UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithTitle:@"+"
																  style:UIBarButtonItemStylePlain
																 target:self
																  action:@selector(addAlarm:)];
	self.navigationItem.leftBarButtonItem = addButton;
	[super viewDidLoad];

}

- (NSMutableArray *) alarms
{
	if (_alarms) {
		return _alarms;
	}
	NSMutableArray *m = [NSMutableArray array];
	for (NSDictionary * dic in [[NSUserDefaults standardUserDefaults] objectForKey:NFALARMLIBSTR]) {
		[m addObject:[NFAlarm initWithDict:dic]];
	}
	_alarms = m;
	return m;
}

/**
 *  Save the alarms to NSUserDefaults
 */
- (void) save
{
	NSMutableArray *m = [NSMutableArray array];
	for (NFAlarm * alarm in self.alarms) {
		[m addObject:[alarm toDict]];
	}
	[[NSUserDefaults standardUserDefaults] setObject:m forKey:NFALARMLIBSTR];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Table Datasource

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = NFALARMLIBCELLID;
	NFAlarmViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[NFAlarmViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	NFAlarm * alarm = [self alarms][indexPath.row];
	cell.hour.text    = alarm.time;
	cell.repeat.text  = alarm.weekdaysText;
	cell.name.text    = alarm.alarmName;
	[cell.alarmOn setOn:alarm.enabled];
	return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[self alarms] count] > 0 ? 1 : 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[self alarms] count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 74.0;
}

#pragma mark - Table Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NFAlarmEditViewController * nfaevc = [[NFAlarmEditViewController alloc] init];
	nfaevc.alarm = [self alarms][indexPath.row];
	nfaevc.delegate = self;
	[self.navigationController pushViewController:nfaevc animated:YES];
}

#pragma mark - Actions
-(void) addAlarm:(id) sender
{
	NFAlarmEditViewController * nfaevc = [[NFAlarmEditViewController alloc] init];
	nfaevc.alarm = [NFAlarm new];
	nfaevc.delegate = self;
	[self.navigationController pushViewController:nfaevc animated:YES];
}

#pragma mark - NFAlarmEditViewControllerDelegate
- (void) alarmFinishEditing:(NFAlarm *)alarm
{
	NSUInteger idx = [self.alarms indexOfObject:alarm];
	if (idx != NSNotFound) {
		self.alarms[idx] = alarm;
	} else {
		[self.alarms addObject:alarm];
	}
	[self save];
	[self.tableView reloadData];
}

@end
