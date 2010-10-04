//
//  RewardAppDelegate.h
//  Reward
//
//  Created by Netmobo on 8/20/10.
//  Copyright Aurisoft.com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RewardViewController;
@class PointsHistoryViewController;
@class LoginViewController;
@class ClaimRewardsViewController;
@class EarnPointsViewController;

// FeeFactor
@class RestTransport3;
@class XmlParser;

@interface RewardAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RewardViewController *viewController;
	PointsHistoryViewController *pointsHistoryViewController;
	LoginViewController *loginViewController;
	ClaimRewardsViewController *claimRewardsViewController;
	EarnPointsViewController *earnPointsViewController;
	
	// FeeFactor
	RestTransport3 *transport3;
    XmlParser *xmlParser;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RewardViewController *viewController;
@property (nonatomic, retain) IBOutlet PointsHistoryViewController *pointsHistoryViewController;
@property (nonatomic, retain) IBOutlet LoginViewController *loginViewController;
@property (nonatomic, retain) IBOutlet ClaimRewardsViewController *claimRewardsViewController;
@property (nonatomic, retain) IBOutlet EarnPointsViewController *earnPointsViewController;

// FeeFactor
@property (nonatomic, retain) RestTransport3 *transport3;
@property (nonatomic, retain) XmlParser *xmlParser;

- (void) goPointHistory;
- (void) goLogout;
- (void) goFrom:(NSString *) aFrom to:(NSString *) aTo;
- (NSString *) loginWithUser:(NSString *) aUser andPassword:(NSString *) aPassword;
- (NSMutableArray *) getProducts;
- (NSMutableArray *) getRewards;
- (NSMutableArray *) getPointHistory;
- (void) chargeAccountWithBrandID:(NSNumber *)aBrandID 
						accountID:(NSString *)aAccountID 
					  serviceName:(NSString *)aServiceName 
					  productCode:(NSString *)aProductCode 
							 item:(NSString *)aItem;
- (NSString *) getCurrentPoints;

@end
