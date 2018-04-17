//
//  UILabel+Create.m
//  ElecSafely
//
//  Created by lhb on 2018/3/11.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "UILabel+Create.h"

@implementation UILabel (Create)

+ (UILabel *)createWithFrame:(CGRect)frame
                        text:(NSString *)text
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment
                  fontNumber:(CGFloat)number{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = [UIFont systemFontOfSize:number];
    
    return label;
}

@end
