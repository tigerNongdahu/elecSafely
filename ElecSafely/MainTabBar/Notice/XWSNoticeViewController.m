//
//  XWSNoticeViewController.m
//  ElecSafely
//
//  Created by TigerNong on 2018/4/4.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSNoticeViewController.h"
#import "NSString+XWSManager.h"

@interface XWSNoticeViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentlabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation XWSNoticeViewController
#pragma mark - 懒加载
- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavibarHeight)];
        [self.view addSubview:_contentScrollView];

        _contentScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, ScreenWidth - 34, 60)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = RGBA(221, 221, 221, 1);
        _titleLabel.font = PingFangRegular(25);
        [_contentScrollView addSubview:_titleLabel];
       
    }
    return _titleLabel;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"公告";
    
    /*加载数据*/
    [self loadData];
    
    /*设置导航*/
    [self setUpNavi];
    
    /*设置一些固定View*/
    [self initView];
    
    /*设置标题标签*/
    [self setTitleContent];
    /*设置时间标签*/
    [self setUpTimeContent];
    /*设置内容标签*/
    [self setContentLabelAndScrollView];
    
}



#pragma mark - 导航栏设置
- (void)setUpNavi{
    
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
    [self contentScrollView];
    [self titleLabel];
    [self contentlabel];
}

-(void)setTitleContent{
    self.titleLabel.text = self.titleStr;
    CGSize maxSize = CGSizeMake(ScreenWidth - 34,MAXFLOAT);
    CGSize sizeFileName = [self.titleLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:PingFangRegular(25)} context:nil].size;
    
    CGRect frame = self.titleLabel.frame;
    frame.size.height = sizeFileName.height + 20;
    self.titleLabel.frame = frame;
}

- (void)setUpTimeContent{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, CGRectGetMaxY(_titleLabel.frame), ScreenWidth - 34, 30)];
        [self.view addSubview:_timeLabel];
        _timeLabel.font = PingFangMedium(13);
        _timeLabel.textColor = RGBA(102, 102, 102, 1);
    }
}

#pragma mark - 设置显示
- (void)setContentLabelAndScrollView{
    
    if (!_contentlabel) {
        _contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(17, CGRectGetMaxY(_timeLabel.frame) + 10, ScreenWidth - 34, ScreenHeight - NavibarHeight - CGRectGetMaxY(_timeLabel.frame) - 10)];
        _contentlabel.textAlignment = NSTextAlignmentLeft;
        
        _contentlabel.textColor = RGBA(153, 153, 153, 1);
        _contentlabel.numberOfLines = 0;
        _contentlabel.font = PingFangRegular(15);
        [_contentScrollView addSubview:_contentlabel];
    }
    
    NSString *attrStr = @"";
    [self setUpContentWithStr:attrStr];
}

- (void)setUpContentWithStr:(NSString *)str{
    
    _contentlabel.text = str;
    
    CGSize maxSize = CGSizeMake(ScreenWidth - 34,MAXFLOAT);
    CGSize sizeFileName = [_contentlabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:PingFangRegular(15)} context:nil].size;
    
    CGRect frame = _contentlabel.frame;
    
    frame.size.height = sizeFileName.height;
    _contentlabel.frame = frame;
    
    _contentScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(_contentlabel.frame) + 60);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y > 60) {
        self.title = self.titleStr;
    }else{
        self.title = @"公告";
    }
}

#pragma mark - 加载数据
- (void)loadData{
    ElecHTTPManager *manager = [ElecHTTPManager manager];
    
    __weak typeof(self) weakVC = self;
    [manager POST:FrigateAPI_noticeContent(self.noticeId) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        
        NSString *time = dic[@"UpdataDate"];
        NSString *admin = dic[@"CreateName"];
        NSString *Contents = dic[@"Contents"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [XWSTipsView dismissTipViewWithSuperView:weakVC.view];
            weakVC.timeLabel.text = [NSString stringWithFormat:@"%@  %@",time,admin];
            [weakVC setUpContentWithStr:Contents];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
