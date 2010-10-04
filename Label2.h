//
//  Label2.h
//
//  Created by Netmobo on 8/25/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//
// based on Label2.h by Ivan Misuno, www.cuberoom.biz

#import <UIKit/UIKit.h>

typedef enum
{
	VerticalAlignmentTop = 0, // default
	VerticalAlignmentMiddle,
	VerticalAlignmentBottom,
} VerticalAlignment;

@interface Label2 : UILabel
{
@private
	VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
