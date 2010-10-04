//
//  PointsHistoryTableCell.m
//  Reward
//
//  Created by Netmobo on 8/23/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//

#import "PointsHistoryTableCell.h"
#import "PointsHistory.h"
#import "Label2.h"

@implementation PointsHistoryTableCell

@synthesize pointsDateLabel;
@synthesize itemLabel;
@synthesize pointsLabel;

- (void)configureForPointsHistory:(PointsHistory *)aPointsHistory {
	self.pointsDateLabel.text = [aPointsHistory pointsDate];
    self.itemLabel.text = [aPointsHistory item];
	self.pointsLabel.text = [aPointsHistory points];
}

- (void)dealloc {
    [pointsDateLabel release];
    [itemLabel release];
    [pointsLabel release];
    [super dealloc];
}
@end
