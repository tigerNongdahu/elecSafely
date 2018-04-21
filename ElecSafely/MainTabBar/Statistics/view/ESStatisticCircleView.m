//
//  ESStatisticCircleView.m
//  ElecSafely
//
//  Created by lhb on 2018/3/26.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "ESStatisticCircleView.h"
#import "MXNCircleCharts.h"
#import "UILabel+Create.h"

const CGFloat CircleHeight = 200.f;

@implementation ESStatisticCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.13 green:0.14 blue:0.20 alpha:1.00];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGFloat width = 120.f;
    
    MXNCircleCharts *circle1 = [[MXNCircleCharts alloc] initWithFrame:CGRectMake((self.width_ES/2 - width)/2, 20, width, width) withMaxValue:100 value:85];
    circle1.valueTitle = @"N/A%";
    circle1.valueColor = [UIColor colorWithRed:0.74 green:0.75 blue:0.75 alpha:1.00];
    circle1.title = @"离线率";
    circle1.titleColor = [UIColor colorWithRed:0.74 green:0.75 blue:0.75 alpha:1.00];
    circle1.colorArray = @[[UIColor colorWithRed:0.39 green:0.75 blue:0.33 alpha:1.00],[UIColor colorWithRed:0.39 green:0.75 blue:0.33 alpha:1.00]];
    circle1.locations = @[@0.15,@0.85];
    [self addSubview:circle1];
    
    UILabel *label1 = [UILabel createWithFrame:CGRectMake(0, circle1.bottom_ES + 6, self.width_ES/2, 16) text:@"离线：N/A次" textColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00] textAlignment:1 fontNumber:15];
    [self addSubview:label1];
    UILabel *label2 = [UILabel createWithFrame:CGRectMake(0, label1.bottom_ES + 6, self.width_ES/2, 16) text:@"在线：N/A次" textColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00] textAlignment:1 fontNumber:15];
    [self addSubview:label2];
    
    MXNCircleCharts *circle2 = [[MXNCircleCharts alloc] initWithFrame:CGRectMake(self.width_ES/2 + (self.width_ES/2 - width)/2, 20, width, width) withMaxValue:100 value:85];
    circle2.valueTitle = @"N/A%";
    circle2.valueColor = [UIColor colorWithRed:0.74 green:0.75 blue:0.75 alpha:1.00];
    circle2.title = @"处理率";
    circle2.titleColor = [UIColor colorWithRed:0.74 green:0.75 blue:0.75 alpha:1.00];
    circle2.colorArray = @[[UIColor colorWithRed:0.95 green:0.42 blue:0.23 alpha:1.00],[UIColor colorWithRed:0.95 green:0.42 blue:0.23 alpha:1.00]];
    circle2.locations = @[@0.15,@0.85];
    [self addSubview:circle2];

    UILabel *label3 = [UILabel createWithFrame:CGRectMake(self.width_ES/2, circle1.bottom_ES + 6, self.width_ES/2, 16) text:@"隐患处理：N/A次" textColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00] textAlignment:1 fontNumber:15];
    [self addSubview:label3];
    UILabel *label4 = [UILabel createWithFrame:CGRectMake(self.width_ES/2, label1.bottom_ES + 6, self.width_ES/2, 16) text:@"未处理：N/A次" textColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00] textAlignment:1 fontNumber:15];
    [self addSubview:label4];
}







@end
