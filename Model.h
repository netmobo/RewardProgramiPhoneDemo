//
//  Model.h
//  MVC
//
//  Created by Netmobo on 5/27/10.
//  Copyright Aurisoft 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject {
	// session
	NSString *isLoggedIn;
	NSString *currentPoints;
	
	// FeeFactor
	NSString *brandID;
	NSString *serviceID;
	NSString *serialNumber;
	NSString *userID;
	NSString *userName;
	NSString *passWord;
	NSString *accountID;
}

// always use NSString for vars to avoid hassles
@property (nonatomic, retain) NSString *isLoggedIn;
@property (nonatomic, retain) NSString *currentPoints;

@property (nonatomic, retain) NSString *brandID;
@property (nonatomic, retain) NSString *serviceID;
@property (nonatomic, retain) NSString *serialNumber;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *passWord;
@property (nonatomic, retain) NSString *accountID;

+ (id)sharedModel;

@end
