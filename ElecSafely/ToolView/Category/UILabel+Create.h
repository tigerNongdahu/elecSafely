//
//  UILabel+Create.h
//  ElecSafely
//
//  Created by lhb on 2018/3/11.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Create)

+ (UILabel *)createWithFrame:(CGRect)frame
                        text:(NSString *)text
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment
                  fontNumber:(CGFloat)number;

@end
