//
//  XWSScanView.m
//  ElecSafely
//
//  Created by TigerNong on 2018/3/23.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSScanView.h"
#define BoldLineWidth 4.0
#define ThreadLineWidth 1.0
#define BoldLineLenght 22.0

@implementation XWSScanView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    [UIColorRGB(0x2061f6) set];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, 0)];
    [path1 addLineToPoint:CGPointMake(BoldLineLenght, 0)];
    
    path1.lineWidth = BoldLineWidth;
    [path1 stroke];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(BoldLineLenght, 0)];
    [path2 addLineToPoint:CGPointMake(self.frame.size.width - BoldLineLenght, 0)];
    path2.lineWidth = ThreadLineWidth;
    [path2 stroke];
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(self.frame.size.width - BoldLineLenght, 0)];
    [path3 addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    path3.lineWidth = BoldLineWidth;
    [path3 stroke];
    
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(self.frame.size.width, 0)];
    [path4 addLineToPoint:CGPointMake(self.frame.size.width, BoldLineLenght)];
    path4.lineWidth = BoldLineWidth;
    [path4 stroke];
    
    UIBezierPath *path5 = [UIBezierPath bezierPath];
    [path5 moveToPoint:CGPointMake(self.frame.size.width, BoldLineLenght)];
    [path5 addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - BoldLineLenght)];
    path5.lineWidth = ThreadLineWidth;
    [path5 stroke];
    
    UIBezierPath *path6 = [UIBezierPath bezierPath];
    [path6 moveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - BoldLineLenght)];
    [path6 addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    path6.lineWidth = BoldLineWidth;
    [path6 stroke];
    
    UIBezierPath *path7 = [UIBezierPath bezierPath];
    [path7 moveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path7 addLineToPoint:CGPointMake(self.frame.size.width - BoldLineLenght, self.frame.size.height)];
    path7.lineWidth = BoldLineWidth;
    [path7 stroke];
    
    UIBezierPath *path8 = [UIBezierPath bezierPath];
    [path8 moveToPoint:CGPointMake(self.frame.size.width - BoldLineLenght, self.frame.size.height)];
    [path8 addLineToPoint:CGPointMake(BoldLineLenght, self.frame.size.height)];
    path8.lineWidth = ThreadLineWidth;
    [path8 stroke];
    
    UIBezierPath *path9 = [UIBezierPath bezierPath];
    [path9 moveToPoint:CGPointMake(BoldLineLenght, self.frame.size.height)];
    [path9 addLineToPoint:CGPointMake(0, self.frame.size.height)];
    path9.lineWidth = BoldLineWidth;
    [path9 stroke];
    
    UIBezierPath *path10 = [UIBezierPath bezierPath];
    [path10 moveToPoint:CGPointMake(0, self.frame.size.height)];
    [path10 addLineToPoint:CGPointMake(0, self.frame.size.height - BoldLineLenght)];
    path10.lineWidth = BoldLineWidth;
    [path10 stroke];
    
    UIBezierPath *path11 = [UIBezierPath bezierPath];
    [path11 moveToPoint:CGPointMake(0, self.frame.size.height - BoldLineLenght)];
    [path11 addLineToPoint:CGPointMake(0, BoldLineLenght)];
    path11.lineWidth = ThreadLineWidth;
    [path11 stroke];
    
    UIBezierPath *path12 = [UIBezierPath bezierPath];
    [path12 moveToPoint:CGPointMake(0, BoldLineLenght)];
    [path12 addLineToPoint:CGPointMake(0, 0)];
    path12.lineWidth = BoldLineWidth;
    [path12 stroke];
    
}

@end
