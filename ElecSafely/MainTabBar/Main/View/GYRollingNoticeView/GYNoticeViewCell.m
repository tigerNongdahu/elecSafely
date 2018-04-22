//
//  GYNoticeViewCell.m
//  RollingNotice
//
//  Created by qm on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GYNoticeViewCell.h"

@implementation GYNoticeViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        if (GYRollingDebugLog) {
            NSLog(@"init a cell from code: %p", self);
        }
        _reuseIdentifier = reuseIdentifier;
        [self setupInitialUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        if (GYRollingDebugLog) {
            NSLog(@"init a cell from xib");
        }
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithReuseIdentifier:@""];
}

- (void)setupInitialUI
{
    self.backgroundColor = BackColor;
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    
    _textLabel = [[UILabel alloc]init];
    [_contentView addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.trailing.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
    }];
    _textLabel.textAlignment = NSTextAlignmentLeft;
    _textLabel.numberOfLines = 2;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentView.frame = self.bounds;
//    _textLabel.frame = CGRectMake(10, 0, self.frame.size.width - 20, 0);
//    _textLabel.textAlignment = NSTextAlignmentLeft;
//    _textLabel.numberOfLines = 2;
}

- (void)dealloc
{
    if (GYRollingDebugLog) {
        NSLog(@"%p, %s", self, __func__);
    }
    
}


@end
