//
//  ESDeviceLoopTypeValueView.h
//  ElecSafely
//
//  Created by lhb on 2018/3/6.
//  Copyright © 2018年 Tianfu. All rights reserved.
//  回路类型值列表

#import <UIKit/UIKit.h>

@class XWSDeviceLoopData;

@interface ESDeviceLoopTypeValueView : UIView

- (void)loadLoopDatas:(NSArray<XWSDeviceLoopData *> *)loopDatas clickQuery:(void(^)(void))queryBlock clickReset:(void(^)(void))resetBlock;

@end


/*
 * cell
 */
@interface ESDeviceValueCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

@end
