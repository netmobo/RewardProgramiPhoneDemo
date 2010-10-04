//
//  ClaimRewards.h
//  Reward
//
//  Created by Netmobo on 8/25/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ClaimRewards : NSObject {
	NSString *item;
	NSString *points;
	NSString *productCode;
	NSString *serviceName;
}

@property (nonatomic, retain) NSString *item;
@property (nonatomic, retain) NSString *points;
@property (nonatomic, retain) NSString *productCode;
@property (nonatomic, retain) NSString *serviceName;

- (id)initWithPointsItem:(NSString *)aItem
				  points:(NSString *)aPoint 
			 productCode:(NSString *)aProductCode 
			 serviceName:(NSString *)aServiceName;

@end
