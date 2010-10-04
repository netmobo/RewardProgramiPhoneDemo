//
//  PointsHistory.h
//  Reward
//
//  Created by Netmobo on 8/20/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PointsHistory : NSObject {
	NSString *pointsDate;
	NSString *item;
	NSString *points;
}

@property (nonatomic, retain) NSString *pointsDate;
@property (nonatomic, retain) NSString *item;
@property (nonatomic, retain) NSString *points;

- (id)initWithPointsDate:(NSString *)aPointsDate 
					item:(NSString *)aItem
				  points:(NSString *)aPoint;

@end
