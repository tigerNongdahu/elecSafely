//
//  ElecTipsView.h
//  ElecSafely
//
//  Created by Tianfu on 09/01/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElecTipsView : UIView

/**
 * 初始化方法
 * @para tipTexts 提示信息字符串,字符串长度不大于18个汉字 超过则尾部省略号
 */
+ (void)showTips:(NSString *)tipTexts;


/**
 * 初始化方法
 * @para keyboard 是否有键盘的情况
 */
+ (void)showTips:(NSString *)tipTexts keyboard:(BOOL)keyboard;


/**
 * 初始化方法
 * @para tipTexts    提示信息字符串
 * @para duringTime  提示信息持续时间
 */
+ (void)showTips:(NSString *)tipTexts during:(NSTimeInterval)duringTime;

/**
 * 初始化方法
 * @para tipTexts    提示信息字符串
 * @para duringTime  提示信息持续时间
 * @para superView   自定义提示所在父视图
 */
+ (void)showTips:(NSString *)tipTexts during:(NSTimeInterval)duringTime inSuperView:(UIView *)superView;


/**
 * 初始化方法
 * @para tipTexts 提示信息字符串,字符串长度不大于18个汉字 超过则尾部省略号
 */
+ (void)showTips:(NSString *)tipTexts diyInfo:(NSDictionary *)diyInfo;
@end
