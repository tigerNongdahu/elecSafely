//
//  XWSNoticeViewController.m
//  ElecSafely
//
//  Created by TigerNong on 2018/4/4.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSNoticeViewController.h"
#import "NSString+XWSManager.h"
#define yMargin 10.0f
#define xMargin 17.0f
#define ScrollViewBottomInsert 60.0f

@interface XWSNoticeViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentlabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) ElecProgressHUD *progressHUD;
@property (nonatomic, copy) NSString *titleStr;
/*标题标签的高度，用于当滚动超过这个高度的时候切换title*/
@property (nonatomic, assign) CGFloat titleHeight;
@end

@implementation XWSNoticeViewController
#pragma mark - 懒加载

- (ElecProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[ElecProgressHUD alloc] init];
    }
    return _progressHUD;
}

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavibarHeight)];
        [self.view addSubview:_contentScrollView];

        _contentScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    /*设置一些固定View*/
    [self initView];
    
    /*加载数据*/
    [self loadData];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.progressHUD dismiss];
}


#pragma mark - 导航栏设置
- (void)setUpNavi{
    self.title = @"公告";
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [sendBtn setTitle:@"取消" forState:UIControlStateNormal];
    [sendBtn setTitleColor:RGBA(255, 255, 255, 1) forState:UIControlStateNormal];
    sendBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    sendBtn.titleLabel.font = PingFangMedium(15);
    [sendBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 设置View
- (void)initView{
    /*设置导航*/
    [self setUpNavi];
    
    [self contentScrollView];
    
    /*设置标题标签*/
    [self setTitleContent];
    /*设置时间标签*/
    [self setUpTimeContent];
    /*设置内容标签*/
    [self setContentLabelAndScrollView];
}

#pragma mark - 设置标题标签
- (void)setTitleContent{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xMargin, 0, ScreenWidth - 2 * xMargin, 60)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = RGBA(221, 221, 221, 1);
        _titleLabel.font = PingFangRegular(25);
        [_contentScrollView addSubview:_titleLabel];
        _titleLabel.hidden = YES;
    }
}

-(void)updateTitleLabelFrameWithTitle:(NSString *)title{
    self.titleLabel.text = title;
    self.titleStr = title;
    CGSize maxSize = CGSizeMake(ScreenWidth - 2 * xMargin,MAXFLOAT);
    CGSize sizeFileName = [self.titleLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:PingFangRegular(25)} context:nil].size;
    
    CGRect frame = self.titleLabel.frame;
    frame.size.height = sizeFileName.height + yMargin * 2;
    self.titleLabel.frame = frame;
    self.titleLabel.hidden = NO;
    self.titleHeight = self.titleLabel.frame.size.height;
}

#pragma mark - 设置时间标签
- (void)setUpTimeContent{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(xMargin, CGRectGetMaxY(_titleLabel.frame), ScreenWidth - 2 * xMargin, 30)];
        [_contentScrollView addSubview:_timeLabel];
        _timeLabel.font = PingFangMedium(13);
        _timeLabel.textColor = RGBA(102, 102, 102, 1);
        _timeLabel.hidden = YES;
    }
}

- (void)updateTimeLabelFrameWithString:(NSString *)time{
    _timeLabel.text = time;
    CGRect frame = _timeLabel.frame;
    frame.origin.y = CGRectGetMaxY(_titleLabel.frame);
    _timeLabel.frame = frame;
    _timeLabel.hidden = NO;
}

#pragma mark - 设置内容标签
- (void)setContentLabelAndScrollView{
    
    if (!_contentlabel) {
        _contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(xMargin, CGRectGetMaxY(_timeLabel.frame) + yMargin, ScreenWidth - 2 * xMargin, ScreenHeight - NavibarHeight - CGRectGetMaxY(_timeLabel.frame) - yMargin)];
        _contentlabel.textAlignment = NSTextAlignmentLeft;
        
        _contentlabel.textColor = RGBA(153, 153, 153, 1);
        _contentlabel.numberOfLines = 0;
        _contentlabel.font = PingFangRegular(15);
        [_contentScrollView addSubview:_contentlabel];
        _contentlabel.hidden = YES;
    }
}

- (void)updateContentLabelFrameWithStr:(NSString *)str{
    
    _contentlabel.text = str;
    
    CGSize maxSize = CGSizeMake(ScreenWidth - 2 * xMargin,MAXFLOAT);
    CGSize sizeFileName = [_contentlabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:PingFangRegular(15)} context:nil].size;
    
    CGRect frame = _contentlabel.frame;
    frame.origin.y = CGRectGetMaxY(_timeLabel.frame) + yMargin;
    frame.size.height = sizeFileName.height;
    _contentlabel.frame = frame;
    
    _contentScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(_contentlabel.frame) + ScrollViewBottomInsert);
    _contentlabel.hidden = NO;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y > self.titleHeight) {
        self.title = self.titleStr;
    }else{
        self.title = @"公告";
    }
}

#pragma mark - 加载数据
- (void)loadData{
    
    [self.progressHUD showHUD:self.view Offset:-NavibarHeight animation:18];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    ElecHTTPManager *manager = [ElecHTTPManager manager];
    
    __weak typeof(self) weakVC = self;
    [manager POST:FrigateAPI_noticeContent(self.noticeId) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakVC.progressHUD dismiss];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [XWSTipsView dismissTipViewWithSuperView:weakVC.view];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        
        NSString *title = dic[@"Title"];
        NSString *time = dic[@"UpdataDate"];
        NSString *admin = dic[@"CreateName"];
        NSString *Contents = dic[@"Contents"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakVC updateTitleLabelFrameWithTitle:title];
            [weakVC updateTimeLabelFrameWithString:[NSString stringWithFormat:@"%@  %@",time,admin]];
            [weakVC updateContentLabelFrameWithStr:Contents];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakVC.progressHUD dismiss];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [ElecTipsView showTips:@"网络错误，请检查网络连接情况" during:2.0];
        [XWSTipsView showTipViewWithType:XWSShowViewTypeError inSuperView:weakVC.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
