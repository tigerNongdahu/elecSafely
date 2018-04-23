//
//  XWSPrismaticView.m
//  ElecSafely
//
//  Created by lhb on 2018/4/21.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSPrismaticView.h"

const CGFloat StarWidth = 6.f;
const CGFloat StarHeight = 6.f;

@implementation XWSPrismaticView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        [self setAnimateWithAfter:2];
        self.transform = CGAffineTransformMakeRotation(-M_PI*0.02);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:1];
    [color set]; //设置线条颜色
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 0.5;
    
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    [path moveToPoint:CGPointMake(StarWidth/2, 0.0)];//起点
    [path addLineToPoint:CGPointMake(StarWidth, StarHeight/2)];
    [path addLineToPoint:CGPointMake(StarWidth/2, StarHeight)];
    [path addLineToPoint:CGPointMake(0.0, StarHeight/2)];
    [path closePath];
    [path fill];//颜色填充
}


- (void)setAnimateWithAfter:(CGFloat)time{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.hidden = NO;
        
        self.alpha = 0;
        self.width_ES = 0;
        self.height_ES = 0;
        
        [UIView animateWithDuration:3 animations:^{
            
            self.width_ES = StarWidth;
            self.height_ES = StarHeight;
            self.alpha = 1;
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:3 animations:^{
                self.alpha = 0;
                self.width_ES = 0;
                self.height_ES = 0;
            }completion:^(BOOL finished) {
                [self setAnimateWithAfter:2];
            }];
        }];
    });
}


@end
