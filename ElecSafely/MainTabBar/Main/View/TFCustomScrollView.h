//
//  TFCustomScrollView.h
//  ElecSafely
//
//  Created by Tianfu on 20/04/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWSHelpModel.h"

#define kTopADHeight      (228.0/720.0)*SCREENWIDTH

@class TFCustomScrollView;

#pragma mark - TFCustomScrollViewDelegate
@protocol TFCustomScrollViewDelegate <NSObject>
@optional
- (void)foucusImageFrame:(TFCustomScrollView *)imageFrame didSelectItem:(XWSHelpModel *)item;
- (void)foucusImageFrame:(TFCustomScrollView *)imageFrame currentItem:(NSInteger)index;

@end

@interface TFCustomScrollView : UIView<UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    BOOL _isAutoPlay;
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<TFCustomScrollViewDelegate>)delegate DataItems:(NSArray *)items isAuto:(BOOL)isAuto;

- (void)scrollToIndex:(int)aIndex;

@property (nonatomic, weak) id<TFCustomScrollViewDelegate> delegate;
@property (nonatomic, weak) XWSHelpModel *item;
@end
