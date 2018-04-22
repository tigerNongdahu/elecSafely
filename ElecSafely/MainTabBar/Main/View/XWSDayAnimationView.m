//
//  XWSLineView.m
//  amm
//
//  Created by TigerNong on 2018/4/20.
//  Copyright © 2018年 TigerNong. All rights reserved.
//

#import "XWSDayAnimationView.h"


@interface XWSDayAnimationView()
/*是否进行动画*/
@property (nonatomic, assign) BOOL isAnimate;
@property (nonatomic, assign) CGFloat aTime;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, strong) UIView *superView;
@end

@implementation XWSDayAnimationView

- (instancetype)initWithFrame:(CGRect)frame withSupuerView:(UIView *)superView afterTime:(CGFloat)aTime animateDuration:(CGFloat)duration{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _superView = superView;
        [superView addSubview:self];
        _aTime = aTime;
        _duration = duration;
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
    layer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    [self.layer addSublayer:layer];
    
    //设置圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(self.frame.size.height * 0.5, self.frame.size.height * 0.5)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)startAnimation{
    _isAnimate = YES;
    [self setAnimateWithView:self withAfter:_aTime];
}

- (void)setAnimateWithView:(UIView *)line withAfter:(CGFloat)time{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:_duration animations:^{
            CGRect frame = line.frame;
            frame.origin.x = self.superView.frame.size.width + self.frame.size.width + 100;
            line.frame = frame;
        }completion:^(BOOL finished) {
            CGRect newframe = line.frame;
            //随机的x
            newframe.origin.x = -(self.frame.size.width + arc4random() % 100);
            //随机的y
            int yHeight = (int)_superView.frame.size.height * 0.5;
            newframe.origin.y = arc4random() % yHeight + 30;
            line.frame = newframe;
            //获取随机的动画时间
            _duration = arc4random() % 3 + 2 + 100 / self.frame.size.width;
            if (self.isAnimate) {
                [self setAnimateWithView:self withAfter:time];
            }
        }];
    });
}

- (void)stopAnimation{
    _isAnimate = NO;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
