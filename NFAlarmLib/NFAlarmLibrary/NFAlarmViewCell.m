//
//  NFAlarmViewCell.m
//  NFAlarmLib
//
//  Created by Pedro Paulo Oliveira Junior on 24/08/15.
//  Copyright (c) 2015 Netfilter. All rights reserved.
//

#import "NFAlarmViewCell.h"

@implementation NFAlarmViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.alarmOn = [[UISwitch alloc] init];
		[self.alarmOn setEnabled:YES];
		self.alarmOn.translatesAutoresizingMaskIntoConstraints = NO;


		self.hour =   [[UILabel alloc] init];
		[self.hour setFont:[UIFont systemFontOfSize:24.0]];
		self.hour.translatesAutoresizingMaskIntoConstraints = NO;

		
		self.name =   [[UILabel alloc] init];
		[self.name setFont:[UIFont systemFontOfSize:13.0]];
		[self.name setTextAlignment:NSTextAlignmentLeft];
		self.name.translatesAutoresizingMaskIntoConstraints = NO;

		
		self.repeat = [[UILabel alloc] init];
		[self.repeat setFont:[UIFont systemFontOfSize:13.0]];
		[self.repeat setTextAlignment:NSTextAlignmentRight];
		self.repeat.translatesAutoresizingMaskIntoConstraints = NO;

		
		[self addSubview:self.alarmOn];
		[self addSubview:self.hour];
		[self addSubview:self.repeat];
		[self addSubview:self.name];
		
		NSDictionary *views = @{@"name"    : self.name,
								@"hour"    : self.hour,
								@"repeat"  : self.repeat,
								@"alarmOn" : self.alarmOn};
		
		NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[hour]-[alarmOn]-10-|"
																	   options:0
																	   metrics:nil
																		 views:views];
		[self addConstraints:constraints];
		
		constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[name]-[repeat]-10-|"
															  options: 0
															  metrics:nil
																views:views];
		[self addConstraints:constraints];
		
		constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[hour(==alarmOn)]-[name(>=20)]-10-|"
															  options: 0
															  metrics:nil
																views:views];
		[self addConstraints:constraints];
		
		constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[alarmOn]-[repeat(>=20)]-10-|"
															  options: 0
															  metrics:nil
																views:views];
		[self addConstraints:constraints];
		


	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
