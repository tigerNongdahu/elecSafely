//
//  CurveChartView.h
//  SLChartLibDemo
//
//  Created by lhb on 2018/1/22.
//  Copyright © 2018年 Hadlinks. All rights reserved.
//  承载曲线图

#import <UIKit/UIKit.h>

UIKIT_EXTERN const CGFloat CurveChartTotalH;

@interface CurveChartView : UIView

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *unitLabel;

@property (nonatomic, strong)NSDictionary *curveChartData;

- (instancetype)initWithFrame:(CGRect)frame withCurveChartData:(NSDictionary *)curveChartData;

@end
