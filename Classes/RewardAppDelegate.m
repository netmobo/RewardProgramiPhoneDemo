//
//  RewardAppDelegate.m
//  Reward
//
//  Created by Netmobo on 8/20/10.
//  Copyright Aurisoft.com 2010. All rights reserved.
//

#import "RewardAppDelegate.h"
#import "RewardViewController.h"
#import "Model.h"
#import "PointsHistoryViewController.h"
#import "LoginViewController.h"
#import "ClaimRewardsViewController.h"
#import "EarnPointsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ClaimRewards.h"
#import	"PointsHistory.h"

// FeeFactor
#import "NetmoboFeefactorModel.h"

#import "Account.h"
#import "Accounts.h"
#import "BrandServices.h"
#import "BrandProduct.h"
#import "BrandProductPrice.h"
#import "Transactions.h"

@implementation RewardAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize pointsHistoryViewController;
@synthesize loginViewController;
@synthesize claimRewardsViewController;
@synthesize earnPointsViewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    [window addSubview:viewController.view];
    
	
	Model *model = [Model sharedModel];
	if ([[model isLoggedIn] isEqualToString:@"Y"]) {
//		[window addSubview:viewController.view];
		
		PointsHistoryViewController *pointsHistoryView = [[PointsHistoryViewController alloc] initWithNibName:@"PointsHistoryViewController" bundle:nil];
		self.pointsHistoryViewController = pointsHistoryView;
		[pointsHistoryView release];
		[window addSubview:pointsHistoryViewController.view];
	} else {
		LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
		self.loginViewController = loginView;
		[loginView release];
		[window addSubview:loginViewController.view];
	}
	[window makeKeyAndVisible];
	
    return YES;
}

- (NSString *) loginWithUser:(NSString *) aUser andPassword:(NSString *) aPassword {
	NetmoboFeefactorModel *netmoboFeefactorModel = [NetmoboFeefactorModel sharedModel];
	Model *model = [Model sharedModel];
	
	[netmoboFeefactorModel setSchema:@"http"];
	[netmoboFeefactorModel setHost:@"70.42.72.151"];
	[netmoboFeefactorModel setPort:@"12345"]; 
	[netmoboFeefactorModel setServiceUrl:@"/feefactor/rest"];
	[netmoboFeefactorModel setUserName:[NSString stringWithFormat:@"%@|%@", [model brandID], aUser] ];
	[netmoboFeefactorModel setPassWord:aPassword];
	[netmoboFeefactorModel setEncode:@"UTF-8"];
	[netmoboFeefactorModel setRealm:@"feefactor"];
	
	Accounts *accountsInterface = [[Accounts alloc] init];
	NSArray *accounts = [[accountsInterface getAccounts:@"" andSort:@"" andPageItems:[NSNumber numberWithInt:1] andPageNumber:[NSNumber numberWithInt:1]] accountResults];

	if ([[netmoboFeefactorModel errorCode] isEqualToString:@"none"]) {
		Account *account = [accounts objectAtIndex:0];
		[model setUserID:[account.userID stringValue]];
		[model setSerialNumber:[account.serialNumber stringValue]];	
		[model setAccountID:account.accountID];
	}
	[accountsInterface release];
	return [netmoboFeefactorModel errorCode];
}

- (NSMutableArray *) getPointHistory {
	Model *model = [Model sharedModel];
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	Accounts *accountsInterface = [[Accounts alloc] init];
	
	NSArray *accountHistories = [[accountsInterface getAccountHistories:[NSNumber numberWithInt:[[model serialNumber] intValue]] andCondition:@"" andSort:@"transactionDate DESC" andPageItems:[NSNumber numberWithInt:20] andPageNumber:[NSNumber numberWithInt:1]] accountHistoryResults];
	
	for (int i=0; i < [accountHistories count]; i++) {
		AccountHistory *accountHistory = [accountHistories objectAtIndex:i];
		
		// format pointsHistoryDate: 2010-07-08T16:38:47.235Z -> 2010-07-08
		NSString *tempString = [accountHistory transactionDate];
		NSString *separatorString = @"T";
		NSScanner *aScanner = [NSScanner scannerWithString:tempString];
		NSString *pDate;
		[aScanner scanUpToString:separatorString intoString:&pDate];
		// end format
		
		// format time, 2010-07-08T16:38:47.235Z -> 16:38
		int tempLocation0;
		NSString *tempString0 = [accountHistory transactionDate];
		NSRange range0 = [tempString0 rangeOfString:@"T"];
		tempLocation0 = range0.location + range0.length;
		NSString *pTimeTemp = [tempString0 substringFromIndex:tempLocation0];
		
		NSString *separatorString0 = @".";
		NSScanner *aScanner0 = [NSScanner scannerWithString:pTimeTemp];
		NSString *pTime;
		[aScanner0 scanUpToString:separatorString0 intoString:&pTime];
		// end time
		
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		NSDate *date = [dateFormat dateFromString:[NSString stringWithFormat:@"%@ %@", pDate, pTime]]; 
		[dateFormat setDateFormat:@"dd/MM/yyyy h:mm a"];
		NSString *dateTimeString = [dateFormat stringFromDate:date];
		[dateFormat release];
		
		PointsHistory *aPointsHistory = [[PointsHistory alloc] init];
		aPointsHistory.pointsDate = dateTimeString;
		
		// format item, remove "[1] " (# of sessions)
		NSString *tempString2 = [accountHistory description];
		NSRange range = [tempString2 rangeOfString:@"] "];
		int tempLocation = range.location + range.length;
		NSString *pItem = [tempString2 substringFromIndex:tempLocation];
		// end format
		
		aPointsHistory.item = pItem;
		aPointsHistory.points = [[accountHistory amountChange] stringValue];
		aPointsHistory.points = [NSString stringWithFormat:@"%.1f", [[accountHistory amountChange] floatValue] ];
		
		[tempArray addObject:aPointsHistory];
		[aPointsHistory release];
	}
	[accountsInterface release];
	return [tempArray autorelease];
}

- (void) chargeAccountWithBrandID:(NSNumber *)aBrandID 
						accountID:(NSString *)aAccountID 
					  serviceName:(NSString *)aServiceName 
					  productCode:(NSString *)aProductCode 
							 item:(NSString *)aItem {
	Transactions *transactionInterface = [[[Transactions alloc] init] autorelease];
	[transactionInterface chargeAccount:aBrandID accountID:aAccountID serviceName:aServiceName productCode:aProductCode quantity:[NSNumber numberWithInt:1]  reason:aItem];
}

- (NSString *) getCurrentPoints {
	Accounts *accountsInterface = [[[Accounts alloc] init] autorelease];
	NSArray *accounts = [[accountsInterface getAccounts:@"" andSort:@"" andPageItems:[NSNumber numberWithInt:1] andPageNumber:[NSNumber numberWithInt:1]] accountResults];
	Account *account = [accounts objectAtIndex:0];
	float tempNum = [account.balance floatValue] - [account.creditLimit floatValue];
	
	return [NSString stringWithFormat:@"%.1f", tempNum];
}

- (NSMutableArray *) getProducts {
	Model *model = [Model sharedModel];
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	BrandServices *brandserviceInterface = [[[BrandServices alloc] init] autorelease];
	NSArray *brandProducts = [[brandserviceInterface getBrandProducts:[NSNumber numberWithInt:[[model serviceID] intValue]] andWhere:@"PRODUCTCODE like 'POINTS-%'" andSort:@"" andPageItems:[NSNumber numberWithInt:0] andPageNumber:[NSNumber numberWithInt:0]] brandProducts];
	BrandService *brandService = [brandserviceInterface getBrandService:[NSNumber numberWithInt:[[model serviceID] intValue]]];
	NSString *aServiceName = [brandService serviceName];
	
	for (int i=0; i < [brandProducts count]; i++) {
		ClaimRewards *aClaimRewards = [[ClaimRewards alloc] init];
		
		BrandProduct *brandProduct = [brandProducts objectAtIndex:i];
		aClaimRewards.serviceName = aServiceName;
		aClaimRewards.productCode = [brandProduct productCode]; 
		aClaimRewards.item = [brandProduct description];
		NSArray *brandProductPrices = [[brandserviceInterface getBrandProductPrices:[brandProduct productID] andWhere:@"" andSort:@"" andPageItems:[NSNumber numberWithInt:0] andPageNumber:[NSNumber numberWithInt:0]] results];
		BrandProductPrice *brandProductPrice = [brandProductPrices objectAtIndex:0];
		
		aClaimRewards.points = [[brandProductPrice price] stringValue];
		[tempArray addObject:aClaimRewards];
		[aClaimRewards release];
	}
	
	return [tempArray autorelease];
}

- (NSMutableArray *) getRewards {
	Model *model = [Model sharedModel];
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	BrandServices *brandserviceInterface = [[[BrandServices alloc] init] autorelease];
	NSArray *brandProducts = [[brandserviceInterface getBrandProducts:[NSNumber numberWithInt:[[model serviceID] intValue]] andWhere:@"PRODUCTCODE not like 'POINTS-%'" andSort:@"" andPageItems:[NSNumber numberWithInt:0] andPageNumber:[NSNumber numberWithInt:0]] brandProducts];
	BrandService *brandService = [brandserviceInterface getBrandService:[NSNumber numberWithInt:[[model serviceID] intValue]]];
	NSString *aServiceName = [brandService serviceName];
	
	for (int i=0; i < [brandProducts count]; i++) {
		ClaimRewards *aClaimRewards = [[ClaimRewards alloc] init];
		
		BrandProduct *brandProduct = [brandProducts objectAtIndex:i];
		aClaimRewards.serviceName = aServiceName;
		aClaimRewards.productCode = [brandProduct productCode]; 
		aClaimRewards.item = [brandProduct description];
		NSArray *brandProductPrices = [[brandserviceInterface getBrandProductPrices:[brandProduct productID] andWhere:@"" andSort:@"" andPageItems:[NSNumber numberWithInt:0] andPageNumber:[NSNumber numberWithInt:0]] results];
		BrandProductPrice *brandProductPrice = [brandProductPrices objectAtIndex:0];
		
		aClaimRewards.points = [[brandProductPrice price] stringValue];
		[tempArray addObject:aClaimRewards];
		[aClaimRewards release];
	}
	
	return [tempArray autorelease];
}

- (void) goFrom:(NSString *) aFrom to:(NSString *) aTo {
	if ([aFrom isEqualToString:@"History"]) {
		[pointsHistoryViewController.view removeFromSuperview];
		[pointsHistoryViewController release];
		pointsHistoryViewController = nil;
	} else if ([aFrom isEqualToString:@"Rewards"]) {
		[claimRewardsViewController.view removeFromSuperview];
		[claimRewardsViewController release];
		claimRewardsViewController = nil;
	} else if ([aFrom isEqualToString:@"EarnPoints"]) {
		[earnPointsViewController.view removeFromSuperview];
		[earnPointsViewController release];
		earnPointsViewController = nil;
	}
	
	if ([aTo isEqualToString:@"Rewards"]) {
		ClaimRewardsViewController *tempView = [[ClaimRewardsViewController alloc] initWithNibName:@"ClaimRewardsViewController" bundle:nil];
		self.claimRewardsViewController = tempView;
		[tempView release];
		[self.window addSubview:[claimRewardsViewController view]];
		
	} else if ([aTo isEqualToString:@"EarnPoints"]) {
		EarnPointsViewController *tempView = [[EarnPointsViewController alloc] initWithNibName:@"EarnPointsViewController" bundle:nil];
		self.earnPointsViewController = tempView;
		[tempView release];
		[self.window addSubview:[earnPointsViewController view]];
		
	} else if ([aTo isEqualToString:@"History"]) {
		PointsHistoryViewController *pointsHistoryView = [[PointsHistoryViewController alloc] initWithNibName:@"PointsHistoryViewController" bundle:nil];
		self.pointsHistoryViewController = pointsHistoryView;
		[pointsHistoryView release];
		[window addSubview:pointsHistoryViewController.view];
	}
	
}

- (void) goPointHistory {
	PointsHistoryViewController *pointsHistoryView = [[PointsHistoryViewController alloc] initWithNibName:@"PointsHistoryViewController" bundle:nil];
	self.pointsHistoryViewController = pointsHistoryView;
	[pointsHistoryView release];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:window cache:NO];
	[loginViewController.view removeFromSuperview];
	[window addSubview:pointsHistoryViewController.view];
	[UIView commitAnimations];
	[loginViewController release];
	loginViewController = nil;
}

- (void) goLogout {
	LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
	self.loginViewController = loginView;
	[loginView release];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:window cache:NO];
	[viewController.view removeFromSuperview];
	[self.window addSubview:[loginViewController view]];
	[UIView commitAnimations];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[earnPointsViewController release];
	[claimRewardsViewController release];
	[loginViewController release];
	[pointsHistoryViewController release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
