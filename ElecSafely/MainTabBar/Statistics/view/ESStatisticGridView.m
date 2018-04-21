//
//  ESStatisticGridView.m
//  ElecSafely
//
//  Created by lhb on 2018/3/25.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "ESStatisticGridView.h"
#import "UILabel+Create.h"

const CGFloat GapWidth = 10.f;
const CGFloat HeightScale = 0.7;

@implementation ESStatisticGridView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}


- (void)loadView{
    
    NSArray *dataSource = [self dataSource];
    
    CGFloat width = (self.width_ES - 3*GapWidth)/2;
    CGFloat height = (self.height_ES - 3*GapWidth)/2;
    for (int i = 0; i < dataSource.count; i++) {
        
        CGRect rect = CGRectMake(GapWidth + (width + GapWidth)*(i%2), GapWidth + (height + GapWidth)*(i/2), width, height);
        NSDictionary *dic = dataSource[i];
        
        UIView *view = [self viewWithName:dic[@"name"] num:dic[@"num"] frame:rect];
        [self addSubview:view];
    }
}



- (NSArray *)dataSource{
    
    NSDictionary *dic1 = @{@"name":@"漏电次数",@"num":@"N/A"};
    NSDictionary *dic2 = @{@"name":@"过载次数",@"num":@"N/A"};
    NSDictionary *dic3 = @{@"name":@"超温次数",@"num":@"N/A"};
    NSDictionary *dic4 = @{@"name":@"离线次数",@"num":@"N/A"};

    return @[dic1,dic2,dic3,dic4];
}

- (UIView *)viewWithName:(NSString *)name num:(NSString *)num frame:(CGRect)frame{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithRed:0.18 green:0.26 blue:0.39 alpha:1.00];

    UIColor *tipColor = [num intValue] > 0 ? [UIColor redColor] : [UIColor whiteColor];
    
    UILabel *label1 = [UILabel createWithFrame:CGRectMake(2*GapWidth, frame.size.height/2 - 40, frame.size.width - 4*GapWidth, 40) text:num textColor:tipColor textAlignment:0 fontNumber:20];
    label1.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:label1];
    
    UILabel *label2 = [UILabel createWithFrame:CGRectMake(2*GapWidth, frame.size.height/2, frame.size.width - 4*GapWidth, 30) text:name textColor:[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00] textAlignment:0 fontNumber:16];
    [view addSubview:label2];
    
    return view;
}



@end
