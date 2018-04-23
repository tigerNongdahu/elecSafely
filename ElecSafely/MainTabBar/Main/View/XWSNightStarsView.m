//
//  XWSNightStarsView.m
//  ElecSafely
//
//  Created by lhb on 2018/4/23.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSNightStarsView.h"
#import "XWSPrismaticView.h"

@implementation XWSNightStarsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createStars];
    }
    return self;
}


- (void)createStars{
    
    CGFloat gapWidth = (CGRectGetWidth(self.bounds)/2)/3;
    CGFloat gapHeight = CGRectGetHeight(self.bounds)/2;
    
    for (int i = 0; i < 6; i++) {
        
        int time = arc4random()%12;

        CGFloat x_add = arc4random()%((int)gapWidth);
        CGFloat y_add = arc4random()%((int)gapHeight);

        CGFloat x = self.width_ES/2 + x_add + (i%3) * gapWidth;
        CGFloat y = (i%2)*gapHeight + y_add;
        
        if ((x+StarWidth) > CGRectGetWidth(self.bounds)) {
            x -= 2*StarWidth;
        }
        
        if ((y+StarHeight)> CGRectGetHeight(self.bounds)) {
            y -= 2*StarHeight;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            XWSPrismaticView *star = [[XWSPrismaticView alloc] initWithFrame:CGRectMake(x, y, StarWidth, StarHeight)];
            [self addSubview:star];
        });
    }
    
}



@end
