//
//  NSData+Base64.m
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void useNSDataBase64 ();

@class NSString;

@interface NSData (Base64Additions)

+ (NSData *)base64DataFromString:(NSString *)string;

+ (NSData*)stringToByte:(NSString*)string;

@end


@interface NSData (NSData_HexAdditions)

- (NSString*) stringWithHexBytes1;

- (NSString*) stringWithHexBytes2;

+ (NSString*) byteToString:(NSData*)data;

@end
