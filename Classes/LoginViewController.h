//
//  LoginViewController.h
//  Reward
//
//  Created by Netmobo on 8/20/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController <UITextFieldDelegate> {
	UITextField *username;
	UITextField *pw;
}

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *pw;

- (IBAction) processLogin:(id) sender;

@end
