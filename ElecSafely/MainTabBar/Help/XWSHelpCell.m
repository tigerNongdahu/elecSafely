//
//  XWSHelpCell.m
//  ElecSafely
//
//  Created by TigerNong on 2018/4/18.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSHelpCell.h"
#import "XWSHelpModel.h"
@interface XWSHelpCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation XWSHelpCell

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        _titleLabel.font = PingFangMedium(17);
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = DarkBack;
        [self addSubview:_line];
    }
    return _line;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = NavColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self titleLabel];
        [self line];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-38);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo((self.frame.size.height - 30) * 0.5);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(17);
        make.bottom.mas_equalTo(-0.3);
        make.height.mas_equalTo(0.3);
    }];
}

- (void)setModel:(XWSHelpModel *)model{
    _model = model;
    _titleLabel.text = _model.Title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
