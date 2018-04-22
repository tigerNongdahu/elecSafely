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
        _dayFisrtAnimView = [[XWSDayAnimationView alloc] initWithFrame:CGRectMake(- 150, 50, 150, 1) withSupuerView:self afterTime:2.0 animateDuration:3.0];
        _dayFisrtAnimView.hidden = YES;
    }
    return _dayFisrtAnimView;
}

- (XWSDayAnimationView *)daySecondAnimView{
    if (!_daySecondAnimView) {
        _daySecondAnimView = [[XWSDayAnimationView alloc] initWithFrame:CGRectMake( - _dayFisrtAnimView.frame.size.width * 0.4, CGRectGetMaxY(_dayFisrtAnimView.frame) + 30, _dayFisrtAnimView.frame.size.width * 0.4, 1) withSupuerView:self afterTime:3.0 animateDuration:4.0];
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
