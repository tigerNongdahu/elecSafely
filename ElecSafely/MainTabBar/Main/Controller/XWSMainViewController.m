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
#import "TFCustomScrollView.h"
#import "TFMainAnimationView.h"
#import "NSString+XWSManager.h"

#define AnimationTime 0.4
#define CoverAlphaValue 0.5


@interface XWSMainViewController ()<XWSLeftViewDelegate,XWSSingleListRightViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) XWSLeftView *leftView;
@property (nonatomic, strong) XWSSingleListRightView *singleRighView;
/*公告数组*/
@property (nonatomic, strong) NSMutableArray *notices;
/*筛选的数据*/
@property (nonatomic, strong) NSMutableArray *screens;
@property (nonatomic, strong) UIImageView *mainBackImageView;
@property (nonatomic, strong) UILabel *todayLabel;
@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *quetions;
@property (nonatomic, strong) NSTimer *timeScroll;
@property (nonatomic, assign) NSInteger scrollIndex;

#warning 测试使用
//@property (nonatomic, strong) TFMainAnimationView *mainAnimationView;
@end

@implementation XWSMainViewController
#warning 测试使用
//- (TFMainAnimationView *)mainAnimationView{
//    if (!_mainAnimationView) {
//        _mainAnimationView = [[TFMainAnimationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth) withAnimation:TFAnimationTypeOfDayTime];
//        [self.view addSubview:_mainAnimationView];
//    }
//    return _mainAnimationView;
//}

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
    
#warning 测试使用
//    BOOL isDay = [NSString isDayTime];
//    if (isDay) {
//         [self mainAnimationView];
//    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //加载公告应该放在这里，这样在切换控制器的时候，可以加载到最新的公告数据
    [self loadNoticeData];
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
//    [self createTableView];
}

- (void)createScrollView {
    TFCustomScrollView *scrollView = [[TFCustomScrollView alloc] initWithFrame:CGRectMake(30, ScreenHeight - 140, ScreenWidth - 60, 140) delegate:self DataItems:self.quetions isAuto:YES];
    [self.view addSubview:scrollView];
}

- (void)createTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        _tableView.backgroundColor = BackColor;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(30);
            make.trailing.mas_equalTo(-30);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(170);
        }];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
}

#pragma mark -设置主页面
- (void)createMainView {
    _mainBackImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _mainBackImageView.image = [UIImage imageNamed:@"yewan"];
    [self.view addSubview:_mainBackImageView];
    [_mainBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
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
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:UserAccount];
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

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.quetions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID = @"helpCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = NavColor;
        cell.textLabel.font = PingFangMedium(15);
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    XWSHelpModel *model = self.quetions[indexPath.row];
    cell.textLabel.text = model.Title;
//        //label
//        UILabel *titleLabel = [[UILabel alloc]init];
//        [cell addSubview:titleLabel];
//        titleLabel.tag = 100 + indexPath.row;
//        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(18);
//            make.right.mas_equalTo(-38);
//            make.height.mas_equalTo(30);
//            make.top.mas_equalTo((70 - 30) * 0.5);
//        }];
//
//        //线条
//        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
//        line.backgroundColor = DarkBack;
//        [cell addSubview:line];
//        /*在这里使用masonry控制，会爆出约束冲突，但是不影响使用，所以就不管了*/
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(0);
//            make.left.mas_equalTo(17);
//            make.bottom.mas_equalTo(-0.3);
//            make.height.mas_equalTo(0.3);
//        }];
//    }
    
//    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100 + indexPath.row];
    
//    XWSHelpModel *model = self.quetions[indexPath.row];
//    titleLabel.text = model.Title;
//    titleLabel.font = PingFangMedium(17);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
};

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, [self tableView:tableView heightForHeaderInSection:section])];
    headView.backgroundColor = BackColor;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [headView addSubview:titleLabel];
    titleLabel.frame = CGRectMake(18, 11, headView.frame.size.width - 18 * 2, headView.frame.size.height - 11 * 2);
    titleLabel.text = @"最新资讯";
    titleLabel.font = PingFangMedium(13);
    titleLabel.textColor = RGBA(153, 153, 153, 1);
    
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XWSHelpModel *model = self.quetions[indexPath.row];
    NSString *content = model.Content;
    NSString *title = model.Title;
    XWSDetailHelpViewController *vc = [[XWSDetailHelpViewController alloc] init];
    vc.title = title;
    vc.url = content;
    [self.navigationController pushViewController:vc animated:YES];
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
        
        //        [weakVC.tableView reloadData];
        
        
        [self loadDataWithScroll];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [ElecTipsView showTips:@"网络错误，请检查网络连接情况"];
    }];
}

- (void)loadDataWithScroll {
    if ([_timeScroll isValid]) {
        [_timeScroll invalidate];
        _timeScroll = nil;
    }

    _scrollIndex = 0;
    if (!_timeScroll) { // [[self currentViewController] isKindOfClass:NSClassFromString(@"IMSSChatKnowledgeViewController")] &&
        _timeScroll = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:5 target:self selector:@selector(startScroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timeScroll forMode:NSDefaultRunLoopMode];
    }
    

}

- (void)startScroll {
    if (_quetions.count > 2) {
        /*
         末次滚动后需要重新定位到Table表头第一个cell
         奇数个数据时：
         1  2  2  3  1  2
         ∆
         1  2  2  3  1  2
         ∆
         偶数个数据时：
         1  2  3  4  1  2
         ∆
         1  2  3  4  1  2
         ∆
         */
        // 向上滚动2条数据
        _scrollIndex += 2;
        if (_scrollIndex < [self.tableView numberOfRowsInSection:0]) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_scrollIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        else {
            _scrollIndex = 0;
            [self.tableView reloadData];
        }
    }
    else {
        _scrollIndex = 0;
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (_scrollIndex == _quetions.count) {
        _scrollIndex = 0;
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    else if (_scrollIndex == _quetions.count - 1) {
//        [_timeScroll invalidate];
//        _timeScroll = nil;
//
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_scrollIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//            _scrollIndex = 0;
//            if (!_timeScroll) { // [[self currentViewController] isKindOfClass:NSClassFromString(@"IMSSChatKnowledgeViewController")] &&
//                _timeScroll = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:5 target:self selector:@selector(startScroll) userInfo:nil repeats:YES];
//                [[NSRunLoop currentRunLoop] addTimer:_timeScroll forMode:NSDefaultRunLoopMode];
//            }
//
//        });
    }
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
}

@end
