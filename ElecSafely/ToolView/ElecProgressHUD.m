//
//  ElecProgressHUD.m
//  ElecSafely
//
//  Created by Tianfu on 01/02/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#import "ElecProgressHUD.h"

@interface ElecProgressHUD ()

@property (nonatomic, weak) UIView *view;

@property (nonatomic, strong) DGActivityIndicatorView *activityIndicatorView;

@end

@implementation ElecProgressHUD



- (instancetype)showHUD:(UIView*)view Offset:(CGFloat)offset animation:(NSInteger)i {
    
    if (self) {
        _view = view;
    }
    
//    if (!_activityIndicatorView) {
//        _activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:i tintColor:[UIColor colorWithRed:15/255.0 green:78/255.0 blue:101/255.0 alpha:1.0] size:50.0f];
//    }
    _activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:1 tintColor:UIColorRGB(0x233351) size:50.0f];

    _activityIndicatorView.userInteractionEnabled = YES;
    _activityIndicatorView.frame = CGRectMake(0.0f, offset,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - offset);
    [view addSubview:_activityIndicatorView];
    [_activityIndicatorView startAnimating];
    
    return self;
}

- (void)dismiss {
    [_activityIndicatorView stopAnimating];
    
    [_activityIndicatorView removeFromSuperview];
}


@end
