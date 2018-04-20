//
//  TFMainAnimationView.m
//  ElecSafely
//
//  Created by Tianfu on 20/04/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#import "TFMainAnimationView.h"

@implementation TFMainAnimationView

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
        
    }
    // 闪亮动画
    else if (animationType == TFAnimationTypeOfDayNight) {
        
    }
}


@end
