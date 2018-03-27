//
//  XWSFeedImageCell.m
//  ElecSafely
//
//  Created by TigerNong on 2018/3/26.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSFeedImageCell.h"

@interface XWSFeedImageCell()


@end

@implementation XWSFeedImageCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:_imageView];
        [self addSubview:_close];
        _imageView.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}
- (UIButton *)close{
    if (!_close) {
        _close = [UIButton buttonWithType:UIButtonTypeCustom];
        _close.frame = CGRectMake(CGRectGetWidth(self.bounds)-20, 0, 20, 20);
        [_close setBackgroundImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
    }
    return _close;
}



@end
