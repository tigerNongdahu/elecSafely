//
//  XWSLineView.h
//  amm
//
//  Created by TigerNong on 2018/4/20.
//  Copyright © 2018年 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWSDayAnimationView : UIView
/*
 frame : 动画视图的大小
 superView : 父类控件
 aTime : 延迟多长时间开始动画
 duration : 动画运行时间
 */
- (id)initWithFrame:(CGRect)frame withSupuerView:(UIView *)superView afterTime:(CGFloat)aTime animateDuration:(CGFloat)duration;
/*
 开始动画
 */
- (void)startAnimation;

/*
 停止动画
 */
- (void)stopAnimation;
@end
