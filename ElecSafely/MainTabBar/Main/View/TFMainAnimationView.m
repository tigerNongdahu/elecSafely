//
//  TFMainAnimationView.m
//  ElecSafely
//
//  Created by Tianfu on 20/04/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#import "TFMainAnimationView.h"
#import "XWSDayAnimationView.h"

@interface TFMainAnimationView ()
@property (nonatomic, strong) XWSDayAnimationView *dayFisrtAnimView;
@property (nonatomic, strong) XWSDayAnimationView *daySecondAnimView;
@end

@implementation TFMainAnimationView

- (XWSDayAnimationView *)dayFisrtAnimView{
    if (!_dayFisrtAnimView) {
        CGFloat x = arc4random() % 100 + 150;
        int yHeight = 80;
        CGFloat y = arc4random() % yHeight;
        CGFloat duration = arc4random() % 3 + 2;
        _dayFisrtAnimView = [[XWSDayAnimationView alloc] initWithFrame:CGRectMake(-x, y, 150, 1) withSupuerView:self afterTime:2 animateDuration:duration];
        _dayFisrtAnimView.hidden = YES;
    }
    return _dayFisrtAnimView;
}

- (XWSDayAnimationView *)daySecondAnimView{
    if (!_daySecondAnimView) {
        CGFloat duration = arc4random() % 3 + 3;
        int yHeight = 80;
        CGFloat y = arc4random() % yHeight;
        _daySecondAnimView = [[XWSDayAnimationView alloc] initWithFrame:CGRectMake( - _dayFisrtAnimView.frame.size.width * 0.4, y, _dayFisrtAnimView.frame.size.width * 0.4, 1) withSupuerView:self afterTime:3 animateDuration:duration];
        _daySecondAnimView.hidden = YES;
    }
    return _daySecondAnimView;
}

- (instancetype)initWithFrame:(CGRect)frame withAnimation:(TFAnimationType)animationType {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self drawAnimation:animationType];
    }
    return self;
}

- (void)drawAnimation:(TFAnimationType)animationType {
    // 横线动画
    if (animationType == TFAnimationTypeOfDayTime) {
        [self startDayAnimation];
    }
    // 闪亮动画
    else if (animationType == TFAnimationTypeOfDayNight) {
        [self stopDayAnimation];
    }
}

//开始白天动画
- (void)startDayAnimation{
    self.dayFisrtAnimView.hidden = NO;
    self.daySecondAnimView.hidden = NO;
    [self.dayFisrtAnimView startAnimation];
    [self.daySecondAnimView startAnimation];
}

//停止白天动画
- (void)stopDayAnimation{
    self.dayFisrtAnimView.hidden = YES;
    self.daySecondAnimView.hidden = YES;
    [self.dayFisrtAnimView stopAnimation];
    [self.daySecondAnimView stopAnimation];
}


@end
