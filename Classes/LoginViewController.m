//
//  LoginViewController.m
//  Reward
//
//  Created by Netmobo on 8/20/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//

#import "LoginViewController.h"
#import "RewardAppDelegate.h"
#import "Model.h"

@implementation LoginViewController

@synthesize username;
@synthesize pw;

/*
 public static String computeMD5Digest(String input){
 MessageDigest md = null;
 try {
 md = MessageDigest.getInstance("MD5");
 } catch (NoSuchAlgorithmException nsae) {
 // ignore this; MD5 is a valid algorithm
 }
 md.reset();
 md.update(input.getBytes());
 byte[] hash = md.digest();
 
 StringBuffer hexString = new StringBuffer();
 for (int i = 0; i < hash.length; i++) {
 if ((0xff & hash[i]) < 0x10) {
 hexString.append("0" + Integer.toHexString((0xFF & hash[i])));
 } else {
 hexString.append(Integer.toHexString(0xFF & hash[i]));
 }
 }
 
 return hexString.toString();
 }
*/

- (IBAction) processLogin:(id) sender {
	[self.pw resignFirstResponder];
	
	NSString *usernameStr = [self.username text];
	NSString *passwordStr = [self.pw text];
	
	RewardAppDelegate *mainDelegate = (RewardAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSString *errorCodeMsg = [mainDelegate loginWithUser:usernameStr andPassword:passwordStr];
	
	Model *model = [Model sharedModel];
	
	if ([errorCodeMsg isEqualToString:@"none"]) {
		[model setIsLoggedIn:@"Y"];
		
		[mainDelegate goPointHistory];
	} else {
		[model setIsLoggedIn:@"N"];
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Wrong username or password" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.pw setDelegate:self];
    [self.pw setReturnKeyType:UIReturnKeyDone];
    [self.pw addTarget:self
					   action:@selector(processLogin:)
			 forControlEvents:UIControlEventEditingDidEndOnExit];
	
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
	[username release];
	[pw release];
    [super dealloc];
}


@end
