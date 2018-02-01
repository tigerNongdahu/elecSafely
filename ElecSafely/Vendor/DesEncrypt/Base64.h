//
//  NSData+Base64.h
//  CheckSDKAPI_IMSS
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+ (NSString *)encode:(NSData *)data;
+ (NSData *)decode:(NSString *)data;

@end
