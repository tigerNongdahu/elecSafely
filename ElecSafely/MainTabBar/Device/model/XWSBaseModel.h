//
//  XWSBaseModel.h
//  ElecSafely
//
//  Created by lhb on 2018/4/11.
//  Copyright © 2018年 Tianfu. All rights reserved.
//  model父类

#import <Foundation/Foundation.h>

@interface XWSBaseModel : NSObject

/*
 * @param dict 初始化字典
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (BOOL)verifyArray:(id)obj;
- (BOOL)verifyDictionary:(id)obj;
- (BOOL)verifyString:(id)obj;

@end
