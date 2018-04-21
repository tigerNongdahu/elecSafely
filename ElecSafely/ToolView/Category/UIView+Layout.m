//
//  UIView+Layout.m
//  Study_Runtime
//
//  Created by lhb on 2017/12/16.
//  Copyright © 2017年 lhb. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (CGFloat)top_ES
{
    return self.frame.origin.y;
}

- (void)setTop_ES:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left_ES
{
    return self.frame.origin.x;
}

- (void)setLeft_ES:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)bottom_ES
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setBottom_ES:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)right_ES
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setRight_ES:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)x_ES
{
    return self.frame.origin.x;
}

- (void)setX_ES:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}

- (CGFloat)y_ES
{
    return self.frame.origin.y;
}

- (void)setY_ES:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}

- (CGPoint)origin_ES
{
    return self.frame.origin;
}

- (void)setOrigin_ES:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX_ES
{
    return self.center.x;
}

- (void)setCenterX_ES:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY_ES
{
    return self.center.y;
}

- (void)setCenterY_ES:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)width_ES
{
    return self.frame.size.width;
}

- (void)setWidth_ES:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height_ES
{
    return self.frame.size.height;
}

- (void)setHeight_ES:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size_ES
{
    return self.frame.size;
}

- (void)setSize_ES:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

//作者：sunljz
//链接：http://www.jianshu.com/p/0a1a9b13b104
//來源：简书
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

@end
