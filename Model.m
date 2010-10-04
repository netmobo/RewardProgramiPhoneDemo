//
//  Model.m
//  MVC
//
//  Created by Netmobo on 2/19/09.
//  Copyright 2009 Aurisoft. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize isLoggedIn;
@synthesize currentPoints;
@synthesize brandID;
@synthesize serviceID;
@synthesize serialNumber;
@synthesize userID;
@synthesize userName;
@synthesize passWord;
@synthesize accountID;

- (id) init
{
	self = [super init];
	if (self != nil) {
		isLoggedIn = @"N";
		currentPoints = @"0";
		brandID = @"200001";
		serviceID = @"491172";
		serialNumber = @"0";
		userID = @"0";
		userName = @"";
		passWord = @"";
		accountID = @"";
	}
	return self;
}


- (void) dealloc
{
	[accountID release];
	[userName release];
	[passWord release];
	[userID release];
	[serialNumber release];
	[serviceID release];
	[brandID release];
	[currentPoints release];
	[isLoggedIn release];
	
	[super dealloc];
}

static Model *sharedMyModel = nil; 

+ (id) sharedModel { 
	@synchronized(self) { 
		if (sharedMyModel == nil) { 
			[[self alloc] init]; 
		} 
	} 
	
	return sharedMyModel; 
} 

+ (id) allocWithZone:(NSZone *)zone { 
	@synchronized(self) { 
		if (sharedMyModel == nil) { 
			sharedMyModel = [super allocWithZone:zone]; 
			return sharedMyModel; 
		} 
	} 
	
	return nil; 
} 

- (id) copyWithZone:(NSZone *)zone { 
	return self; 
} 

- (id) retain { 
	return self; 
} 

- (unsigned) retainCount { 
	return UINT_MAX; 
} 

- (void) release { 
} 

- (id) autorelease { 
	return self; 
}

@end
