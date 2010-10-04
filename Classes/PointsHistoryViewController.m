//
//  PointsHistoryViewController.m
//  Reward
//
//  Created by Netmobo on 8/31/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "PointsHistoryViewController.h"
#import "PointsHistory.h"
#import "PointsHistoryTableCell.h"
#import "Model.h"
#import "RewardAppDelegate.h"

@implementation PointsHistoryViewController

@synthesize pointsHistoryCell;
@synthesize pointsHistoryArray;
@synthesize pointsLabel;
@synthesize activity;

-(void) loadTestData {
	RewardAppDelegate *mainDelegate = (RewardAppDelegate *)[[UIApplication sharedApplication] delegate];
	[pointsHistoryArray addObjectsFromArray:[mainDelegate getPointHistory]];
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
			// already at points history
		} else if (buttonIndex == 1) {
			RewardAppDelegate *mainDelegate = (RewardAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"History" to:@"EarnPoints"];
		} else if (buttonIndex == 2) {
			RewardAppDelegate *mainDelegate = (RewardAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"History" to:@"Rewards"];
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
	pointsHistoryArray = [[NSMutableArray alloc] init];
	
	[self loadTestData];
	
	Model *model = [Model sharedModel];
	
	RewardAppDelegate *mainDelegate = (RewardAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *currentPoints = [mainDelegate getCurrentPoints];
	[model setCurrentPoints:currentPoints];
	[[self pointsLabel] setText:currentPoints];
	
	[pointsHistoryTableView reloadData];
	
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[activity release];
	[pointsLabel release];
	[pointsHistoryArray release];
	[pointsHistoryCell release];
	
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [pointsHistoryArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"ProductCellId";
    
    PointsHistoryTableCell *cell = 
	(PointsHistoryTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PointsHistoryCell" owner:self options:nil];
        cell = self.pointsHistoryCell;
    }    
    
    PointsHistory *pointsHistory = [pointsHistoryArray objectAtIndex:indexPath.row];
	[cell configureForPointsHistory:pointsHistory];
	
	return cell;
	
}

@end
