//
//  XWSSingleListRightView.h
//  ElecSafely
//
//  Created by TigerNong on 2018/4/4.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XWSSingleListRightView;

@protocol XWSSingleListRightViewDelegate <NSObject>
- (void)clickListView:(XWSSingleListRightView *)rightView withObj:(id)obj;
@end

@interface XWSSingleListRightView : UIView
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, weak) id<XWSSingleListRightViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *dataAtts;

- (void)startCoverViewOpacityWithAlpha:(CGFloat)alpha withDuration:(CGFloat)duration;
- (void)cancelCoverViewOpacity;
@end
