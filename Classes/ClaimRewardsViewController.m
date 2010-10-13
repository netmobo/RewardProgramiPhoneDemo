//
//  ClaimRewardsViewController.m
//  Reward
//
//  Created by Netmobo on 8/25/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//
/*
 Copyright (c) 2010, NETMOBO LLC
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of NETMOBO LLC nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "ClaimRewardsViewController.h"
#import "Model.h"
#import "RewardAppDelegate.h"
#import "ClaimRewards.h"
#import "ClaimRewardsTableCell.h"

@implementation ClaimRewardsViewController

@synthesize claimRewardProductsArray;
@synthesize claimRewardsTableCell;
@synthesize pointsLabel;
@synthesize activity;

-(void) loadData {
	RewardAppDelegate *mainDelegate = (RewardAppDelegate *)[[UIApplication sharedApplication] delegate];
	[claimRewardProductsArray addObjectsFromArray:[mainDelegate getRewards]];
}

- (IBAction)menu_btn_clicked {
	NSString *msg = [NSString stringWithFormat:@"Menu"];
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:msg delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Points History" otherButtonTitles:@"Earn Points", @"Claim Rewards", @"Logout", nil];
	[actionSheet showInView:[self view]];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	UIAlertView *alert;
	if (buttonIndex != [actionSheet cancelButtonIndex]) {
		if (buttonIndex == 0) {
			RewardAppDelegate *mainDelegate = (RewardAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Rewards" to:@"History"];
		} else if (buttonIndex == 1) {
			RewardAppDelegate *mainDelegate = (RewardAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Rewards" to:@"EarnPoints"];
		} else if (buttonIndex == 2) {
			// already at claim rewards
		} else {
			alert = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
			[alert show];
			[alert release];
		}
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // do stuff
		Model *model = [Model sharedModel];
		[model setIsLoggedIn:@"N"];
		
		RewardAppDelegate *mainDelegate = (RewardAppDelegate *)[[UIApplication sharedApplication] delegate];
		[mainDelegate goLogout];
    }
}


/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	self.editing = NO;
	
	
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	
	[activity setHidden:NO];
	[activity startAnimating];
	
	Model *model = [Model sharedModel];
	[[self pointsLabel] setText:[model currentPoints]];
}

- (void)viewDidAppear:(BOOL)animated {
	[self performSelector:@selector(doInitialLoad) withObject:NULL afterDelay:0.0];
	
}

- (void)doInitialLoad {
	claimRewardProductsArray = [[NSMutableArray alloc] init];
	
	[self loadData];
	Model *model = [Model sharedModel];
	[[self pointsLabel] setText:[model currentPoints] ];
	
	[claimRewardTableView reloadData];
	
	[activity stopAnimating];
	[activity setHidden:YES];
}

- (void)doClaimReward:(ClaimRewards *) claimRewards {
	Model *model = [Model sharedModel];
	
	if ([[claimRewards points] floatValue] <= [[model currentPoints] floatValue]) {
	
		NSNumber *aBrandID = [NSNumber numberWithInt:[[model brandID] intValue]];
		NSString *aAccountID = [model accountID];
		NSString *aServiceName = [claimRewards serviceName];
		NSString *aProductCode = [claimRewards productCode];
		// "Claim Rewards: " + bp.getDescription() + " (" + bp.getProductCode() + ")";
		NSString *aItem = [NSString stringWithFormat:@"Claim Rewards: %@ (%@)", [claimRewards item], aProductCode];;
		
		RewardAppDelegate *mainDelegate = (RewardAppDelegate *)[[UIApplication sharedApplication] delegate];
		[mainDelegate chargeAccountWithBrandID:aBrandID accountID:aAccountID serviceName:aServiceName productCode:aProductCode item:aItem];
		
		NSString *currentPoints = [mainDelegate getCurrentPoints];
		[model setCurrentPoints:currentPoints];
		[[self pointsLabel] setText:currentPoints];
		
		
		
		NSString *msg = [NSString stringWithFormat:@"%@ for %.1f points", [claimRewards item], [[claimRewards points] floatValue] ];
		
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Rewards Claimed" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		NSString *msg = @"You do not have enough points";
		
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	[activity stopAnimating];
	[activity setHidden:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[activity release];
	[pointsLabel release];
	[claimRewardsTableCell release];
	[claimRewardProductsArray release];
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [claimRewardProductsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProductCellId";
    
    ClaimRewardsTableCell *cell = 
	(ClaimRewardsTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ClaimRewardsCell" owner:self options:nil];
        cell = self.claimRewardsTableCell;
    }    
    
    ClaimRewards *claimRewards = [claimRewardProductsArray objectAtIndex:indexPath.row];
	[cell configureForClaimRewards:claimRewards];
	
	
	return cell; 
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[activity setHidden:NO];
	[activity startAnimating];
	
	ClaimRewards *rewardClaimed = [claimRewardProductsArray objectAtIndex:indexPath.row];
	
	[self performSelector:@selector(doClaimReward:) withObject:rewardClaimed afterDelay:0.0];
	
}

@end
