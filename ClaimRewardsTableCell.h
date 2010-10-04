//
//  ClaimRewardsTableCell.h
//  Reward
//
//  Created by Netmobo on 8/25/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClaimRewards;
@class Label2;

@interface ClaimRewardsTableCell : UITableViewCell {
    IBOutlet Label2 *itemLabel;
    IBOutlet UILabel *pointsLabel;
}

@property (nonatomic, retain) Label2 *itemLabel;
@property (nonatomic, retain) UILabel *pointsLabel;

- (void)configureForClaimRewards:(ClaimRewards *)aClaimRewards;

@end
