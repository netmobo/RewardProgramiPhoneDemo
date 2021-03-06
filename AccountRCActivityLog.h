//
//  AccountRCActivityLog.h
//  FeeFactor
//
//  Created by Netmobo on 17/05/10.
//  Copyright 2010 Netmobo. All rights reserved.
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

#import <Foundation/Foundation.h>


@interface AccountRCActivityLog : NSObject {
	
@protected
	
	NSString * accountID;
	NSNumber * accountRCActivityLogID;
	NSNumber * accountRCID;
    NSString * activity;
	NSNumber * adminID;
    NSString * adminName;
	NSNumber * amount;
	NSNumber * brandID;
    NSString * ip;
	NSNumber * recAccountRCALID;
    NSString * remarks;
    NSString * schedule;
	NSNumber * serialNumber;
    NSString * timestamp;
    NSString * type;
}


@property (nonatomic, retain) NSString * accountID;
@property (nonatomic, assign) NSNumber * accountRCActivityLogID;
@property (nonatomic, assign) NSNumber * accountRCID;
@property (nonatomic, retain) NSString * activity;
@property (nonatomic, assign) NSNumber * adminID;
@property (nonatomic, retain) NSString * adminName;
@property (nonatomic, assign) NSNumber * amount;
@property (nonatomic, assign) NSNumber * brandID;
@property (nonatomic, retain) NSString * ip;
@property (nonatomic, assign) NSNumber * recAccountRCALID;
@property (nonatomic, retain) NSString * remarks;
@property (nonatomic, retain) NSString * schedule;
@property (nonatomic, assign) NSNumber * serialNumber;
@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSString * type;

@end
