//
//  XWSPrismaticView.m
//  ElecSafely
//
//  Created by lhb on 2018/4/21.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSPrismaticView.h"

@implementation XWSPrismaticView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [color set]; //设置线条颜色
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 0.5;
    
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    [path moveToPoint:CGPointMake(4.0, 0.0)];//起点
    [path addLineToPoint:CGPointMake(8.0, 5.0)];
    [path addLineToPoint:CGPointMake(4.0, 10.0)];
    [path addLineToPoint:CGPointMake(0.0, 5.0)];
    [path closePath];
    [path fill];//颜色填充
}


@end
