//
//  ClaimRewardsTableCell.m
//  Reward
//
//  Created by Netmobo on 8/25/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "ClaimRewardsTableCell.h"
#import "ClaimRewards.h"
#import "Label2.h"

@implementation ClaimRewardsTableCell

@synthesize itemLabel;
@synthesize pointsLabel;

- (void)configureForClaimRewards:(ClaimRewards *)aClaimRewards {
    self.itemLabel.text = [aClaimRewards item];
	self.pointsLabel.text = [NSString stringWithFormat:@"%.1f", [[aClaimRewards points] floatValue] ];
}

- (void)dealloc {
    [itemLabel release];
    [pointsLabel release];
    [super dealloc];
}

@end
