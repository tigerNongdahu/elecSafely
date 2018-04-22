//
//  XWSSingleListRightView.m
//  ElecSafely
//
//  Created by TigerNong on 2018/4/4.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSSingleListRightView.h"
#import "XWSNoticeModel.h"
#define rightBackColor NavColor

#define leftMarginWidth 100.0
#define SureBtnTag 100
#define CloseBtnTag 101
#define RightTableViewRowHeight 74.0

@interface XWSSingleListRightView ()<UITableViewDelegate,UITableViewDataSource>
/*左侧的数据表*/
@property (nonatomic, strong) UITableView *rightTableView;
/*自定义的导航栏*/
@property (nonatomic, strong) UIView *navView;
/*导航栏关闭按钮*/
//@property (nonatomic, strong) UIButton *closeBtn;
/*导航栏确定按钮*/
//@property (nonatomic, strong) UIButton *sureBtn;
/*导航栏标题*/
@property (nonatomic, strong) UILabel *titleLabel;
/*左侧显示数据数组*/
@property (nonatomic, strong) NSMutableArray *datas;
/*没有功能View*/
@property (nonatomic, strong) UIView *NoDataView;
@end
@implementation XWSSingleListRightView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.datas = [NSMutableArray array];
        [self setUpUI];
    }
    return self;
}

#pragma mark - 懒加载

- (UIView *)NoDataView{
    if (!_NoDataView) {
        _NoDataView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_NoDataView];
        _NoDataView.backgroundColor = NavColor;
        [_NoDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.navView.mas_bottom);
            make.width.mas_equalTo(ScreenWidth - leftMarginWidth);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
        //添加标题
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_NoDataView addSubview:tipLabel];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = PingFangRegular(16);
        tipLabel.textColor = RGBA(170, 170, 170, 1);
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_NoDataView.mas_centerX);
            make.top.mas_equalTo(297);
            
        }];
        tipLabel.text = @"暂无公告";
    }
    return _NoDataView;
}

- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_coverView];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0;
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(leftMarginWidth + ScreenWidth);
        }];
        
        _coverView.userInteractionEnabled = YES;
        
        //蒙版添加手势事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCover:)];
        [_coverView addGestureRecognizer:tap];
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCover:)];
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
        [_coverView addGestureRecognizer:swipe];
        
    }
    return _coverView;
}

- (UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.backgroundColor = rightBackColor;
        _rightTableView.tableFooterView = [[UIView alloc] init];
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.showsHorizontalScrollIndicator = NO;
        
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.rowHeight = RightTableViewRowHeight;
        [self addSubview:_rightTableView];
        
        [_rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.navView.mas_bottom);
            make.width.mas_equalTo(ScreenWidth - leftMarginWidth);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }
    return _rightTableView;
}

#pragma Mark- 标题
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"公告";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = PingFangMedium(17);
    }
    return _titleLabel;
}


#pragma mark - 自定义的导航View
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_navView];
        _navView.backgroundColor = rightBackColor;
        
        CGFloat h = NavibarHeight;
        CGFloat t = 0;
        CGFloat t1 = 27;
        //适配iPhoneX
        if (IS_IPHINE_X) {
            t = 44;
            h = 44;
            t1 = 7;
        }
        [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(t);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(h);
            make.width.mas_equalTo(ScreenWidth - leftMarginWidth);
        }];

        [_navView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(t1);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(0);
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:line];
        line.backgroundColor = DarkBack;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.3);
            make.top.mas_equalTo(_navView.mas_bottom).mas_equalTo(-0.3);
            make.width.mas_equalTo(_navView.mas_width);
        }];
    }
    return _navView;
}

#pragma mark - 设置界面
- (void)setUpUI{
    [self navView];
    [self coverView];
    [self NoDataView];
//    [self rightTableView];
}

#pragma mark - 点击以及手势事件
- (void)clickCloseBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(clickListView:withObj:)]) {
        [self.delegate clickListView:self withObj:nil];
    }
}
- (void)swipeCover:(UISwipeGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(clickListView:withObj:)]) {
        [self.delegate clickListView:self withObj:nil];
    }
}
- (void)clickCover:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(clickListView:withObj:)]) {
        [self.delegate clickListView:self withObj:nil];
    }
}

#pragma mark - 动画
- (void)startCoverViewOpacityWithAlpha:(CGFloat)alpha withDuration:(CGFloat)duration{
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:alpha];
    opacityAnimation.duration = duration;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    [_coverView.layer addAnimation:opacityAnimation forKey:@"opacity"];
    _coverView.alpha = alpha;
}

- (void)cancelCoverViewOpacity{
    [_coverView.layer removeAllAnimations];
    _coverView.alpha = 0;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XWSSingleRightCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"XWSSingleRightCell"];
        if (tableView == _rightTableView) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
            line.backgroundColor = DarkBack;
            [cell addSubview:line];

            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.left.mas_equalTo(17);
                make.bottom.mas_equalTo(-0.3);
                make.height.mas_equalTo(0.3);
            }];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = PingFangRegular(17);
    cell.backgroundColor = rightBackColor;
    cell.textLabel.textColor = RGBA(221, 221, 221, 1);
    cell.detailTextLabel.font = PingFangRegular(14);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    XWSNoticeModel *model = self.datas[indexPath.row];
    
    cell.textLabel.text = model.Title;
    cell.detailTextLabel.textColor = RGBA(153, 153, 153, 1);
    cell.detailTextLabel.text = model.UpdataDate;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XWSNoticeModel *model = self.datas[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(clickListView:withObj:)]) {
        [self.delegate clickListView:self withObj:model];
    }
}

- (void)setDataAtts:(NSMutableArray *)dataAtts{
    _dataAtts = dataAtts;
    
    [self.datas removeAllObjects];
    
    [self.datas addObjectsFromArray:_dataAtts];

    if (self.datas.count == 0) {
        self.rightTableView.hidden = YES;
        self.NoDataView.hidden = NO;
        [self NoDataView];
    }else{
        self.NoDataView.hidden = YES;
        self.rightTableView.hidden = NO;
        [self rightTableView];
        [self.rightTableView reloadData];
    }
}


@end
