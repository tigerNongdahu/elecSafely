//
//  ESStatisticView.m
//  ElecSafely
//
//  Created by lhb on 2018/3/22.
//  Copyright © 2018年 Tianfu. All rights reserved.
//  统计

#import "ESStatisticView.h"
#import "ESStatisticGridView.h"
#import "ESStatisticCircleView.h"
#import "CurveChartView.h"

@interface ESStatisticView ()
{
    ESStatisticGridView *_gridView;
    ESStatisticCircleView *_circleView;
}
@end

@implementation ESStatisticView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)loadCurveChartData:(NSArray *)chartDatas{
    
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    [self showGridView];
    
    /*回路曲线*/
    __block UIView *lastView = _gridView;
    [chartDatas enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat gap = GapWidth;
        if (idx == 0) {
            gap = 0.0;
        }
        CurveChartView *curveView = [[CurveChartView alloc]
                                     initWithFrame:CGRectMake(0, lastView.bottom_ES + gap, self.width_ES, CurveChartTotalH)
                                     withCurveChartData:obj];
        [self addSubview:curveView];
        
        lastView = curveView;
    }];
    
    [self showCircleView:lastView];
    
    self.contentSize = CGSizeMake(self.width_ES, _circleView.bottom_ES + GapWidth);
}


//四个方格
- (void)showGridView{
    _gridView = [[ESStatisticGridView alloc] initWithFrame:CGRectMake(0, 0, self.width_ES, self.width_ES * HeightScale)];
    [self addSubview:_gridView];
}


//环形图
- (void)showCircleView:(UIView *)topView{
    
    _circleView= [[ESStatisticCircleView alloc] initWithFrame:CGRectMake(0, topView.bottom_ES + GapWidth, self.width_ES, CircleHeight)];
    [self addSubview:_circleView];
}



@end
