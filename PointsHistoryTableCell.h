//
//  PointsHistoryTableCell.h
//  Reward
//
//  Created by Netmobo on 8/23/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PointsHistory;
@class Label2;

@interface PointsHistoryTableCell : UITableViewCell {
	IBOutlet Label2 *pointsDateLabel;
    IBOutlet Label2 *itemLabel;
    IBOutlet UILabel *pointsLabel;
}

@property (nonatomic, retain) Label2 *pointsDateLabel;
@property (nonatomic, retain) Label2 *itemLabel;
@property (nonatomic, retain) UILabel *pointsLabel;

- (void)configureForPointsHistory:(PointsHistory *)aPointsHistory;

@end
