//
//  PointsHistory.m
//  Reward
//
//  Created by Netmobo on 8/20/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//

#import "PointsHistory.h"


@implementation PointsHistory

@synthesize pointsDate;
@synthesize item;
@synthesize points;

- (id)initWithPointsDate:(NSString *)aPointsDate 
					item:(NSString *)aItem
				  points:(NSString *)aPoint {
	self = [super init];
	if(nil != self) {
		self.pointsDate = aPointsDate;
		self.item = aItem;
		self.points = aPoint;
	}
	return self;
}

- (void)dealloc {
	[pointsDate release];
	[item release];
	[points release];
	
    [super dealloc];
}

@end
