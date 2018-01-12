//
//  NSData+Base64.h
//  CheckSDKAPI_IMSS
//
//  Created by jiaozhiyu on 15-1-27.
//  Copyright (c) 2015年 Huawei Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+ (NSString *)encode:(NSData *)data;
+ (NSData *)decode:(NSString *)data;

@end
