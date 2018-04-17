//
//  MXNCircleCharts.h
//  环形图
//
//  Created by 孟宪楠 on 2018/1/8.
//  Copyright © 2018年 孟宪楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXNCircleCharts : UIView
///初始化方法
- (instancetype)initWithFrame:(CGRect)frame withMaxValue:(CGFloat)maxValue value:(CGFloat)value;
///值相关
@property (nonatomic, copy) NSString *valueTitle;
@property (nonatomic, weak) UIColor *valueColor;
@property (nonatomic, weak) UIFont *valueFont;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, weak) UIColor *titleColor;
@property (nonatomic, weak) UIFont *titleFont;
///渐变色数组
@property (nonatomic, strong) NSArray *colorArray;
///渐变色数组所占位置
@property (nonatomic, strong) NSArray *locations;
///底圆颜色
@property (nonatomic, strong) UIColor *insideCircleColor;
///单色
@property (nonatomic, strong) UIColor *singleColor;
@end
