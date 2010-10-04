//
//  PointsHistoryViewController.h
//  Reward
//
//  Created by Netmobo on 8/31/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PointsHistoryTableCell;

@interface PointsHistoryViewController : UIViewController <UITableViewDataSource, UIActionSheetDelegate, UIAlertViewDelegate> {
	PointsHistoryTableCell *pointsHistoryCell;
	NSMutableArray *pointsHistoryArray;
	IBOutlet UITableView *pointsHistoryTableView;
	
	UILabel *pointsLabel;
	
	UIActivityIndicatorView *activity;
}

@property (nonatomic, retain) IBOutlet PointsHistoryTableCell *pointsHistoryCell;
@property (nonatomic, retain) NSMutableArray *pointsHistoryArray;

@property (nonatomic, retain) IBOutlet UILabel *pointsLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

- (IBAction)menu_btn_clicked;

@end
