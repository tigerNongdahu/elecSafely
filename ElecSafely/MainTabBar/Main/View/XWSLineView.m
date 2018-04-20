//
//  XWSLineView.m
//  amm
//
//  Created by TigerNong on 2018/4/20.
//  Copyright © 2018年 TigerNong. All rights reserved.
//

#import "XWSLineView.h"

@implementation XWSLineView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

   // 绘制一头大，一头小的白色
    CGPoint startPoint = CGPointMake(0, self.frame.size.height *0.5);

     UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:startPoint];

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:layer];

    //设置圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(self.frame.size.height * 0.5, self.frame.size.height * 0.5)];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


@end
