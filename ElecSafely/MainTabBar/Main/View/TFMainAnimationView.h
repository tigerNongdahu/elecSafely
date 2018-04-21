//
//  TFMainAnimationView.h
//  ElecSafely
//
//  Created by Tianfu on 20/04/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TFAnimationType){
    TFAnimationTypeOfDayTime,
    TFAnimationTypeOfDayNight
};

@interface TFMainAnimationView : UIView

- (instancetype)initWithFrame:(CGRect)frame withAnimation:(TFAnimationType)animationType;

- (void)stopAnimation;
@end
