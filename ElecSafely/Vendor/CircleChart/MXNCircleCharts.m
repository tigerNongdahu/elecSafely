//
//  MXNCircleCharts.m
//  环形图
//
//  Created by 孟宪楠 on 2018/1/8.
//  Copyright © 2018年 孟宪楠. All rights reserved.
//

#import "MXNCircleCharts.h"

@interface MXNCircleCharts ()
@property (nonatomic, weak) UILabel *valueLabel;
@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, assign) CGFloat value;

@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, strong) CAGradientLayer *colorLayer;

@property (nonatomic, strong) CAShapeLayer *insideShapelayer;

@property (nonatomic, strong) CAShapeLayer *outerShapelayer;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation MXNCircleCharts

- (instancetype)initWithFrame:(CGRect)frame withMaxValue:(CGFloat)maxValue value:(CGFloat)value{
    
    self =  [super initWithFrame:frame];
    
    if (self) {
        NSLog(@"%f---%f",maxValue,value);
        
        if (maxValue < value) {
            maxValue = value;
        }
        
        _value = value;
        _maxValue = maxValue;
        
        [self drawArc];
    }
    return self;
}


-(void)drawArc
{
    
    ///计算中心点
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    ///底层圆
    CGFloat radius = self.frame.size.width * 0.5 - 15;
    UIBezierPath* arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    _insideShapelayer = shapelayer;
    shapelayer.lineWidth = 8.0;
    shapelayer.strokeColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.44 alpha:1.00].CGColor;
//    shapelayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;

    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.path = arcPath.CGPath;
    
    [self.layer addSublayer:shapelayer];
    
    ///顶层圆
    CGFloat outerRadius = radius;
    
    NSLog(@"value:%f---maxValue:%f",_value,_maxValue);
    
    UIBezierPath *outerArcPath = [UIBezierPath bezierPathWithArcCenter:center radius:outerRadius startAngle:-M_PI_2 endAngle:M_PI * 2 * (_value / _maxValue) - M_PI_2  clockwise:YES];
    
    CAShapeLayer *outerShapelayer = [CAShapeLayer layer];
    _outerShapelayer = outerShapelayer;
    outerShapelayer.lineWidth = 8.0;
    outerShapelayer.strokeColor = [UIColor clearColor].CGColor;
    outerShapelayer.fillColor = [UIColor clearColor].CGColor;
    outerShapelayer.path = outerArcPath.CGPath;
    
    [self.layer addSublayer:outerShapelayer];
    
    ///标注
    UILabel *valueLabel = [[UILabel alloc] init];
    
    [self addSubview:valueLabel];
    self.valueLabel = valueLabel;
    
    valueLabel.frame = CGRectMake(center.x - 50, center.y - 20, 100, 20);
    valueLabel.textColor = [UIColor whiteColor];
    valueLabel.font = [UIFont systemFontOfSize:16];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    
    //大标题
    UILabel *titleLabel = [[UILabel alloc] init];
    
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    titleLabel.frame = CGRectMake(center.x - 100, center.y, 200, 30);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    _gradientLayer = gradientLayer;
    gradientLayer.frame = self.bounds;
    gradientLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:gradientLayer];
    
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    self.colorLayer = colorLayer;
    colorLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    colorLayer.locations = @[@0.1,@1.0];
    colorLayer.startPoint = CGPointMake(0, 0);
    colorLayer.endPoint = CGPointMake(1, 0);
    [gradientLayer addSublayer:colorLayer];
    
    
    CAShapeLayer *gressLayer = [CAShapeLayer layer];
    gressLayer.lineWidth = 8.0;
    gressLayer.strokeColor = [UIColor blueColor].CGColor;
    gressLayer.fillColor = [UIColor clearColor].CGColor;
    gressLayer.lineCap = kCALineCapRound;
    gressLayer.path = outerArcPath.CGPath;
    gradientLayer.mask = gressLayer;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.0;
    [gressLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
}

#pragma mark set
- (void)setValueTitle:(NSString *)valueTitle{
    _valueLabel.text = valueTitle;
}

- (void)setValueFont:(UIFont *)valueFont{
    _valueLabel.font = valueFont;
}

- (void)setValueColor:(UIColor *)valueColor{
    _valueLabel.textColor = valueColor;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleLabel.font = titleFont;
}

-(void)setTitleColor:(UIColor *)titleColor {
    _titleLabel.textColor = titleColor;
}


- (void)setInsideCircleColor:(UIColor *)insideCircleColor{
    _insideShapelayer.strokeColor = insideCircleColor.CGColor;
}

- (void)setColorArray:(NSArray *)colorArray{
    _colorArray = colorArray;
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (UIColor *color in colorArray) {
        [array addObject:(id)color.CGColor];
    }
    
    _colorLayer.colors = array.copy;
}

- (void)setLocations:(NSArray *)locations{
    _colorLayer.locations = locations;
}

- (void)setSingleColor:(UIColor *)singleColor{
    _outerShapelayer.strokeColor = singleColor.CGColor;
    [_gradientLayer removeFromSuperlayer];
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.0;
    [_outerShapelayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
}

@end
