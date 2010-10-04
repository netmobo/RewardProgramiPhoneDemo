//
//  EarnPointsViewController.h
//  Reward
//
//  Created by Netmobo on 8/25/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClaimRewardsTableCell;

@interface EarnPointsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate> {
	ClaimRewardsTableCell *claimRewardsTableCell;
	NSMutableArray *claimRewardProductsArray;
	IBOutlet UITableView *claimRewardTableView;
	
	UILabel *pointsLabel;
	
	UIActivityIndicatorView *activity;
}

@property (nonatomic, retain) IBOutlet ClaimRewardsTableCell *claimRewardsTableCell;
@property (nonatomic, retain) NSMutableArray *claimRewardProductsArray;

@property (nonatomic, retain) IBOutlet UILabel *pointsLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

- (IBAction)menu_btn_clicked;

@end
