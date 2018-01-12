//
//  ElecTipsView.m
//  ElecSafely
//
//  Created by Tianfu on 09/01/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//
const static NSInteger TipsTag  = 10001;

#import "ElecTipsView.h"

@implementation ElecTipsView
+ (void)showTips:(NSString *)tipTexts diyInfo:(NSDictionary *)diyInfo{
    [self shareTips:tipTexts during:nil inSuperView:nil keyboard:NO diyInfo:diyInfo];
    
}

+ (void)showTips:(NSString *)tipTexts{
    [self shareTips:tipTexts during:nil inSuperView:nil keyboard:NO diyInfo:@{}];
}

+ (void)showTips:(NSString *)tipTexts keyboard:(BOOL)keyboard{
    [self shareTips:tipTexts during:nil inSuperView:nil keyboard:keyboard diyInfo:@{}];
}
+ (void)showTips:(NSString *)tipTexts during:(NSTimeInterval)duringTime{
    [self shareTips:tipTexts during:[NSString stringWithFormat:@"%f",duringTime] inSuperView:nil keyboard:NO diyInfo:@{}];
}

+ (void)showTips:(NSString *)tipTexts during:(NSTimeInterval)duringTime inSuperView:(UIView *)superView {
    [self shareTips:tipTexts during:[NSString stringWithFormat:@"%f",duringTime] inSuperView:superView keyboard:NO diyInfo:@{}];
}

+ (void)shareTips:(NSString *)tipTexts during:(NSString *)duringTime inSuperView:(UIView *)superView keyboard:(BOOL)hasKeyboard diyInfo:(NSDictionary *)diyInfo
{
    UIWindow *window = nil;
    if (superView) {
        window = superView;
    } else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    //    NSArray * windows = [[UIApplication sharedApplication]windows];
    //    UIWindow  * lastWidow = (UIWindow *)[windows lastObject];
    //    window.windowLevel = lastWidow.windowLevel + 1;
    //     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    for (UIView *view in window.subviews) {
        if (view.tag == TipsTag) {
            
            return;
        }
    }
    
    CGFloat tipsFontSize = 13.f;
    if ([diyInfo.allKeys containsObject:@"color"]) {
        tipsFontSize = 15.f;
    }else{
        tipsFontSize = 13.f;
    }
    
    CGFloat time = duringTime?[duringTime floatValue]:0.8f;
    
    CGFloat textHeight = 0.0f;
    CGFloat textWidth = 0.0f;
    
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:tipsFontSize]};
    
    //80---灰色块距离屏幕两边的距离和
    //100/3 ---中心文字距离灰色块两边距离和
    CGRect rect = [tipTexts boundingRectWithSize:CGSizeMake(CGRectGetWidth(window.frame) - 80 - (100/3), 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:dic context:nil];
    textHeight =  ceilf(rect.size.height);
    
    rect = [tipTexts boundingRectWithSize:CGSizeMake(10000, tipsFontSize+1) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    textWidth =  ceilf(rect.size.width) > (CGRectGetWidth(window.frame) - 80 - (100/3))?(CGRectGetWidth(window.frame) - 80):(ceilf(rect.size.width)+40);
    
    //    IMSSTipsView *tipsView = [[self alloc] initWithFrame:CGRectMake(0,0, SCREENWIDTH - 80, 38) withText:tipTexts withTime:time keyboard:hasKeyboard];
    CGRect tipsViewRect = CGRectZero;
    if ([diyInfo.allKeys containsObject:@"color"]) {
        tipsViewRect =  CGRectMake(0,0, textWidth, 30);
    }else{
        tipsViewRect =  CGRectMake(0,0, textWidth, textHeight + 24);
    }
    
    ElecTipsView *tipsView = [[self alloc] initWithFrame:tipsViewRect withText:tipTexts withTime:time keyboard:hasKeyboard diyInfo:diyInfo];
    
    
    //    tipsView.center =(hasKeyboard == YES) ? CGPointMake(SCREENWIDTH/2, SCREENHEIGHT-214-NAVBARHEIGHT-TABBARHEIGHT): CGPointMake(SCREENWIDTH/2, SCREENHEIGHT-TABBARHEIGHT-NAVBARHEIGHT);
    tipsView.center =(hasKeyboard == YES) ? CGPointMake(CGRectGetWidth(window.frame)/2, CGRectGetHeight(window.frame)-214-NavibarHeight): CGPointMake(CGRectGetWidth(window.frame)/2, CGRectGetHeight(window.frame)- NavibarHeight);
    
    tipsView.tag = TipsTag;
    tipsView.alpha = 1.f;
    
    [UIView animateWithDuration:0.25f animations:^{
        
        tipsView.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        if (![window.subviews containsObject:tipsView])
        {
            [window addSubview:tipsView];
            
            [UIView animateWithDuration:0.4 delay:time options:nil animations:^{
                tipsView.alpha = 0;
                //                tipsView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
            } completion:^(BOOL finished) {
                [tipsView removeFromSuperview];
            }];
        }
        
    }];
}

- (void)dismiss{
    [self removeFromSuperview];
}

#pragma mark - 视图初始化
-(id)initWithFrame:(CGRect)frame withText:(NSString *)tipsText withTime:(NSTimeInterval)timeInterval keyboard:(BOOL )hasKeyboard diyInfo:(NSDictionary *)diyInfo
{
    
    self =   [super initWithFrame:frame];
    if (self)
    {
        [self addTipsLabel:tipsText keyboard:hasKeyboard diyInfo:diyInfo];
    }
    return self;
}

- (void)addTipsLabel:(NSString *)tipsText keyboard:(BOOL )hasKeyboard diyInfo:(NSDictionary *)diyInfo
{
    self.layer.cornerRadius = 5.f;
    self.clipsToBounds = YES;
    CGFloat tipsFontSize = 13.f;
    if ([diyInfo.allKeys containsObject:@"color"]) {
        self.backgroundColor = UIColorRGB(0xf4645f);
        self.alpha = 0.96;
        tipsFontSize = 15.f;
    }else{
        self.backgroundColor = RGBA(50, 50, 50, 0.8f);
    }
    
    
    
    //label
    UILabel * tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(50/3.f, 12, self.bounds.size.width - 100/3.f,self.frame.size.height - 24.f)];
    tipsLabel.backgroundColor = [UIColor clearColor];
    tipsLabel.text = tipsText;
    tipsLabel.font = [UIFont systemFontOfSize:tipsFontSize];
    tipsLabel.textColor = [UIColor whiteColor];
    tipsLabel.numberOfLines = 0;
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.center =(hasKeyboard == YES) ? CGPointMake(ScreenWidth/2, ScreenHeight-214-NavibarHeight): CGPointMake(ScreenWidth/2, ScreenHeight-NavibarHeight);
    
    tipsLabel.frame = CGRectMake(50/3.f, 12, self.frame.size.width - 100/3.f,self.frame.size.height - 24.f);
    
    if (hasKeyboard == YES) {
        self.frame = CGRectMake(self.frame.origin.x, (ScreenHeight-self.frame.size.height)/2, self.frame.size.width, self.frame.size.height);
    }
    tipsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:tipsLabel];
}


@end
