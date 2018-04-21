//
//  UIView+Layout.h
//  Study_Runtime
//
//  Created by lhb on 2017/12/16.
//  Copyright © 2017年 lhb. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface UIView (Layout)

@property (assign, nonatomic) CGFloat   top_ES;
@property (assign, nonatomic) CGFloat   bottom_ES;
@property (assign, nonatomic) CGFloat   left_ES;
@property (assign, nonatomic) CGFloat   right_ES;

@property (assign, nonatomic) CGFloat   x_ES;
@property (assign, nonatomic) CGFloat   y_ES;
@property (assign, nonatomic) CGPoint   origin_ES;

@property (assign, nonatomic) CGFloat   centerX_ES;
@property (assign, nonatomic) CGFloat   centerY_ES;

@property (assign, nonatomic) CGFloat   width_ES;
@property (assign, nonatomic) CGFloat   height_ES;
@property (assign, nonatomic) CGSize    size_ES;

//作者：sunljz
//链接：http://www.jianshu.com/p/0a1a9b13b104
//來源：简书
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
@end
