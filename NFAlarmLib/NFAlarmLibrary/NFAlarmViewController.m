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

#define NFALARMLIBSTR @"nf_alarm_library_string"
#define NFALARMLIBCELLID @"f_alarm_library_cell_id"

@interface NFAlarmViewController ()
@property (copy, nonatomic) NSMutableArray * localAlarms;
@end

@implementation NFAlarmViewController

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
		self.localAlarms = nil;
	}
	return self;
}

- (instancetype) initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		self.localAlarms = nil;
	}
	return self;
}

- (void) viewDidLoad
{
	UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self
																  action:@selector(addAlarm:)];
	self.navigationItem.leftBarButtonItem = addButton;
	[super viewDidLoad];

}

- (NSArray *) alarms
{
	if (self.localAlarms) {
		return self.localAlarms;
	}
	NSMutableArray *m = [NSMutableArray array];
	for (NSDictionary * dic in [[NSUserDefaults standardUserDefaults] objectForKey:NFALARMLIBSTR]) {
		[m addObject:[NFAlarm initWithDict:dic]];
	}
	return m;
}

- (void) save
{
	NSMutableArray *m = [NSMutableArray array];
	for (NFAlarm * alarm in self.alarms) {
		[m addObject:[alarm toDict]];
	}
	[[NSUserDefaults standardUserDefaults] setObject:m forKey:NFALARMLIBSTR];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Datasource

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NFALARMLIBCELLID];
	NFAlarm * alarm = [self alarms][indexPath.row];
	cell.textLabel.text = alarm.time;
	cell.detailTextLabel.text = alarm.weekdaysText;
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

#pragma mark - Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark - Actions
-(void) addAlarm:(id) sender
{
	NFAlarmEditViewController * nfaevc = [[NFAlarmEditViewController alloc] init];
	nfaevc.alarm = [NFAlarm new];
	[self.navigationController pushViewController:nfaevc animated:YES];
}

@end
