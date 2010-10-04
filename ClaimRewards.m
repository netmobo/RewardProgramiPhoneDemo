//
//  ClaimRewards.m
//  Reward
//
//  Created by Netmobo on 8/25/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//

#import "ClaimRewards.h"


@implementation ClaimRewards

@synthesize item;
@synthesize points;
@synthesize productCode;
@synthesize serviceName;

- (id)initWithPointsItem:(NSString *)aItem
				  points:(NSString *)aPoint 
			 productCode:(NSString *)aProductCode 
			 serviceName:(NSString *)aServiceName {
	self = [super init]; 
	if(nil != self) {
		self.item = aItem;
		self.points = aPoint;
		self.productCode = aProductCode;
		self.serviceName = aServiceName;
	}
	return self;
}

- (void)dealloc {
	[serviceName release];
	[productCode release];
	[points release];
	[item release];
	
    [super dealloc];
}

@end
