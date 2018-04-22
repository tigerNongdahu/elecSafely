//
//  XWSMainViewController.m
//  ElecSafely
//
//  Created by TigerNong on 2018/3/23.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSMainViewController.h"
#import "ESStatisticViewController.h"
#import "XWSDeviceListViewController.h"
#import "XWSAlarmViewController.h"
#import "XWSSettingViewController.h"
#import "XWSLeftView.h"
#import "XWSScanViewController.h"
#import "XWSHelpViewController.h"
#import "XWSFeedbackViewController.h"
#import "XWSSingleListRightView.h"
#import "XWSNoticeViewController.h"
#import "XWSNavigationController.h"
#import "XWSNoticeModel.h"
#import "XWSHelpModel.h"
#import "XWSDetailHelpViewController.h"
#import "TFMainAnimationView.h"
#import "NSString+XWSManager.h"
#import "GYRollingNoticeView.h"

#define AnimationTime 0.4
#define CoverAlphaValue 0.5


@interface XWSMainViewController ()<XWSLeftViewDelegate,XWSSingleListRightViewDelegate,GYRollingNoticeViewDataSource,GYRollingNoticeViewDelegate>

@property (nonatomic, strong) XWSLeftView *leftView;
@property (nonatomic, strong) XWSSingleListRightView *singleRighView;
/*公告数组*/
@property (nonatomic, strong) NSMutableArray *notices;
/*筛选的数据*/
@property (nonatomic, strong) NSMutableArray *screens;
@property (nonatomic, strong) UIImageView *mainBackImageView;
@property (nonatomic, strong) UILabel *todayLabel;
@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic, strong) NSMutableArray *quetions;

@property (nonatomic, strong) TFMainAnimationView *mainAnimationView;
@property (nonatomic, strong) GYRollingNoticeView *noticeView;
@end

@implementation XWSMainViewController


- (NSMutableArray *)screens{
    if (!_screens) {
        _screens = [NSMutableArray  array];
    }
    return _screens;
}

- (NSMutableArray *)notices{
    if (!_notices) {
        _notices = [NSMutableArray array];
    }
    return _notices;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    [self loadData];
    [self initView];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //加载公告应该放在这里，这样在切换控制器的时候，可以加载到最新的公告数据
    [self loadNoticeData];
    [self checkBackImage];

}

#pragma mark - 加载数据
- (void)loadData{
    [self loadHelpData];
}

#pragma mark - 设置页面
- (void)initView{
    [self setUpNav];
    [self setUpLeftView];
    [self setUpSingleListRightView];
    [self createMainView];
}

- (void)createScrollView {
    
    _noticeView = [[GYRollingNoticeView alloc]initWithFrame:CGRectMake(30, ScreenHeight - NavibarHeight - 100, ScreenWidth - 60, 100)];
    _noticeView.dataSource = self;
    _noticeView.delegate = self;
    [self.view addSubview:_noticeView];
    _noticeView.backgroundColor = [UIColor lightGrayColor];
    [_noticeView registerClass:[GYNoticeViewCell class] forCellReuseIdentifier:@"CustomNoticeCell"];
    
    [_noticeView reloadDataAndStartRoll];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(30,  ScreenHeight - NavibarHeight - 130, ScreenWidth - 60, 30)];
    headView.backgroundColor = BackColor;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [headView addSubview:titleLabel];
    titleLabel.frame = CGRectMake(18, 11, headView.frame.size.width - 18 * 2, headView.frame.size.height - 11 * 2);
    titleLabel.text = @"最新资讯";
    titleLabel.font = PingFangMedium(13);
    titleLabel.textColor = RGBA(153, 153, 153, 1);
    [self.view addSubview:headView];
}

- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView
{
        return _quetions.count;
}
- (__kindof GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    // 普通用法，只有一行label滚动显示文字
    // normal use, only one line label rolling
        GYNoticeViewCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"CustomNoticeCell"];
        XWSHelpModel *model = _quetions[index];
        cell.textLabel.text = model.Title;
        cell.textLabel.font = PingFangMedium(15);
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = NavColor;

        return cell;
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index
{
    XWSHelpModel *model = self.quetions[index];
    NSString *content = model.Content;
    NSString *title = model.Title;
    XWSDetailHelpViewController *vc = [[XWSDetailHelpViewController alloc] init];
    vc.title = title;
    vc.url = content;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -设置主页面
- (void)createMainView {
    _mainBackImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_mainBackImageView];
    [_mainBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    NSString *moment = [[NSUserDefaults standardUserDefaults] objectForKey:MomentAction];
    if ([moment isEqualToString:@"baitian"]) {
        _mainBackImageView.image = [UIImage imageNamed:@"baitian"];
        _mainAnimationView = [[TFMainAnimationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth) withAnimation:TFAnimationTypeOfDayTime];

    }
    else if ([moment isEqualToString:@"yewan"]) {
        _mainBackImageView.image = [UIImage imageNamed:@"yewan"];
        _mainAnimationView = [[TFMainAnimationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth) withAnimation:TFAnimationTypeOfDayTime];

    }
    [self.view addSubview:_mainAnimationView];
    
    _todayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _todayLabel.textColor = [UIColor whiteColor];
    _todayLabel.textAlignment = NSTextAlignmentLeft;
    _todayLabel.font = [UIFont systemFontOfSize:30];
    _todayLabel.text = @"今天";
    [_mainBackImageView addSubview:_todayLabel];
    [_todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ScreenHeight / 6 - 50);
        make.leading.mas_equalTo(30);
    }];
    
    _dateLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _dateLable.textColor = [UIColor whiteColor];
    _dateLable.textAlignment = NSTextAlignmentLeft;
    _dateLable.font = [UIFont systemFontOfSize:18];
    _dateLable.text = [self getNowDate];
    [_mainBackImageView addSubview:_dateLable];
    [_dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_todayLabel.mas_bottom).offset(10);
        make.leading.mas_equalTo(_todayLabel.mas_leading).offset(0);
    }];
}

- (void)checkBackImage {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [_mainBackImageView.layer addAnimation:transition forKey:@"a"];
    NSString *imageName = [[NSUserDefaults standardUserDefaults] objectForKey:MomentAction];
    [_mainBackImageView setImage:[UIImage imageNamed:imageName]];

}

- (NSString *)getNowDate {
    unsigned unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    NSLog(@"%ld, %ld, %ld", (long)components.year, (long)components.month, (long)components.day);
    NSString *dateStr = [NSString stringWithFormat:@"%ld月%ld日",(long)components.month,(long)components.day];
    NSString *weekStr = [self weekdayStringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%@ %@",dateStr,weekStr];
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}




#pragma -mark 设置导航栏
- (void)setUpNav{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_menu"] style:0 target:self action:@selector(showLeftView)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"right_notice"] style:0 target:self action:@selector(showSingleListRightView)];
    self.navigationItem.rightBarButtonItems = @[rightItem2];
}

#pragma - mark 设置左边
- (void)setUpLeftView{
    
    //获取到的个人信息
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:UserName];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"account"] = account;
    dic[@"icon"] = @"loading_shape_rectangular";
    
    if (!_leftView) {
        //目前里面设置的icon暂时没有实现加载网络图片，要实现可以自己到leftView里面去添加
        _leftView = [[XWSLeftView alloc] initWithFrame:CGRectZero withUserInfo:dic];
        [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor clearColor];
        
        [[UIApplication sharedApplication].keyWindow addSubview:_leftView];
        _leftView.delegate = self;
        _leftView.hidden = YES;
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(-ScreenWidth);
            make.width.mas_equalTo(ScreenWidth);
        }];
    }
}
//显示左边侧边栏
- (void)showLeftView{
    _leftView.hidden = NO;
    [UIView animateWithDuration:AnimationTime animations:^{
        [_leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
        }];
        [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
     //设置颜色渐变动画
    [_leftView startCoverViewOpacityWithAlpha:CoverAlphaValue withDuration:AnimationTime];
}

//收回左侧侧边栏
- (void)hideLeftView{
    [_leftView cancelCoverViewOpacity];
    [UIView animateWithDuration:AnimationTime animations:^{
        [_leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(-ScreenWidth);
        }];
        
        [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
        
    }completion:^(BOOL finished) {
        _leftView.hidden = YES;
    }];
}

#pragma mark - XWSLeftViewDelegate
- (void)touchLeftView:(XWSLeftView *)leftView byType:(XWSTouchItem)type{
    
    [self hideLeftView];
    
    UIViewController *vc = nil;
    
    switch (type) {
        case XWSTouchItemUserInfo:
        {
           
        }
            break;
        case XWSTouchItemDevicesList:
        {
            XWSDeviceListViewController *deviceList = [[XWSDeviceListViewController alloc] init];
            vc = deviceList;
        }
            break;
        case XWSTouchItemAlarm:
        {
            XWSAlarmViewController *alarm = [[XWSAlarmViewController alloc] init];
            vc = alarm;
        }
            break;
        case XWSTouchItemStatistics:
        {
            ESStatisticViewController *statisticVC = [[ESStatisticViewController alloc] init];
            vc = statisticVC;
        }
            break;
        case XWSTouchItemFeedback:
        {
            XWSFeedbackViewController *feedVC = [[XWSFeedbackViewController alloc] init];
            vc = feedVC;
        }
            break;
        case XWSTouchItemHelp:
        {
            XWSHelpViewController *helpVC = [[XWSHelpViewController alloc] init];
            vc = helpVC;
        }
            break;
        case XWSTouchItemScan:
        {
            XWSScanViewController *scanVC = [[XWSScanViewController alloc] init];
            vc = scanVC;
        }
            break;
        case XWSTouchItemSetting:
        {
            XWSSettingViewController *settingVC = [[XWSSettingViewController alloc] init];
            vc = settingVC;
           
        }
            break;
            
        default:
            break;
    }
    
    if (vc == nil) {
        return;
    }
     [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 公告
- (void)loadNoticeData{
    ElecHTTPManager *noticeMgr = [ElecHTTPManager manager];
    __weak typeof(self) weakVC = self;
    [noticeMgr GET:FrigateAPI_loadNotice parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSArray *ds = dic[@"rows"];
        [weakVC.notices removeAllObjects];
        
        NSInteger count = ds.count;
        
        //只获取最新的10个数据
        if (ds.count > 10) {
            count = 10;
        }

        for (int i = 0;i < count; i++) {
            NSDictionary *obj = ds[i];
            XWSNoticeModel *model = [[XWSNoticeModel alloc] init];
            model.ID = obj[@"ID"];
            model.Title = obj[@"Title"];
            model.Contents = obj[@"Contents"];
            model.ExpiredDate = obj[@"ExpiredDate"];
            model.UpdataDate = obj[@"UpdataDate"];
            
            [weakVC.notices addObject:model];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [ElecTipsView showTips:@"网络错误，请检查网络情况" during:2.0];
    }];
}

#pragma mark - 热点问题
- (void)loadHelpData{
    ElecHTTPManager *noticeMgr = [ElecHTTPManager manager];
    self.quetions = [[NSMutableArray alloc] initWithCapacity:0];
    __weak typeof(self) weakVC = self;
    [noticeMgr GET:FrigateAPI_Help_InformationList parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *results = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        [weakVC.quetions removeAllObjects];
        
        for (NSDictionary *dic in results) {
            XWSHelpModel *model = [[XWSHelpModel alloc] init];
            model.Title = dic[@"Title"];
            model.Content = dic[@"Content"];
            
            [weakVC.quetions addObject:model];
        }
        
        [self createScrollView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [ElecTipsView showTips:@"网络错误，请检查网络连接情况"];
    }];
}


- (void)setUpSingleListRightView{
    if (!_singleRighView) {
        _singleRighView = [[XWSSingleListRightView alloc] initWithFrame:CGRectZero];
        _singleRighView.delegate = self;
        _singleRighView.hidden = YES;
        [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor clearColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_singleRighView];
        [_singleRighView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(ScreenWidth);
        }];
    }
}

- (void)showSingleListRightView{
    _singleRighView.dataAtts = self.notices;
    _singleRighView.hidden = NO;
    [UIView animateWithDuration:AnimationTime animations:^{
        [_singleRighView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(-ScreenWidth);
        }];
        [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
    //设置颜色渐变动画
    [_singleRighView startCoverViewOpacityWithAlpha:CoverAlphaValue withDuration:AnimationTime];
}

- (void)hideSingleListRightView{
    
    //把盖板颜色的alpha值至为0
    [_singleRighView cancelCoverViewOpacity];
    
    //移动侧边栏回到原来的位置
    [UIView animateWithDuration:AnimationTime animations:^{
        [_singleRighView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(ScreenWidth);
        }];
        
        [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
        
    }completion:^(BOOL finished) {
        _singleRighView.hidden = YES;
    }];
}

- (void)clickListView:(XWSSingleListRightView *)rightView withObj:(id)obj{
    [self hideSingleListRightView];
    
    if (obj != nil) {
        
        XWSNoticeModel *model = (XWSNoticeModel *)obj;
        
        XWSNoticeViewController *noticeVC = [[XWSNoticeViewController alloc] init];
        noticeVC.noticeId = model.ID;
        
        XWSNavigationController *navi = [[XWSNavigationController alloc] initWithRootViewController:noticeVC];
        
        [self presentViewController:navi animated:YES completion:^{
            
        }];
    }
}

- (void)dealloc{
    NSLog(@"main:%s",__func__);
    [_noticeView stopRoll];
}

@end
