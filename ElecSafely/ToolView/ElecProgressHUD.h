//
//  ElecProgressHUD.h
//  ElecSafely
//
//  Created by Tianfu on 01/02/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "DGActivityIndicatorView.h"

@interface ElecProgressHUD : AFHTTPSessionManager

- (instancetype)showHUD:(UIView*)view Offset:(CGFloat)offset animation:(NSInteger)i;

- (void)dismiss;

@end
