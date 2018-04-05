//
//  XWSMainViewController.m
//  ElecSafely
//
//  Created by TigerNong on 2018/3/23.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSMainViewController.h"
#import "XWSSettingViewController.h"
#import "XWSLeftView.h"
#import "XWSScanViewController.h"
#import "XWSRightView.h"
#import "XWSHelpViewController.h"
#import "XWSFeedbackViewController.h"
#import "XWSSingleListRightView.h"
#import "XWSNoticeViewController.h"
#import "XWSNavigationController.h"
#import "XWSNoticeModel.h"

#define AnimationTime 0.35
#define CoverAlphaValue 0.5

@interface XWSMainViewController ()<XWSLeftViewDelegate,XWSRightViewDelegate,XWSSingleListRightViewDelegate>
@property (nonatomic, strong) XWSLeftView *leftView;
@property (nonatomic, strong) XWSRightView *rightView;
@property (nonatomic, strong) XWSSingleListRightView *singleRighView;
/*公告数组*/
@property (nonatomic, strong) NSMutableArray *notices;
/*筛选的数据*/
@property (nonatomic, strong) NSMutableArray *screens;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self initView];
}

#pragma mark - 加载数据
- (void)loadData{
    [self loadNoticeData];
}

#pragma mark - 设置页面
- (void)initView{
    [self setUpNav];
    [self setUpLeftView];
    [self setUpRightView];
    [self setUpSingleListRightView];
}

#pragma -mark 设置导航栏
- (void)setUpNav{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_menu"] style:0 target:self action:@selector(showLeftView)];
//
//    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateNormal];
//    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_setting"] style:0 target:self action:@selector(showRightView)];
    
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"right_notice"] style:0 target:self action:@selector(showSingleListRightView)];
    self.navigationItem.rightBarButtonItems = @[rightItem2];
//    self.navigationItem.rightBarButtonItems = @[rightItem1,rightItem2];
}

#pragma - mark 设置左边
- (void)setUpLeftView{
    
    //获取到的个人信息
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:UserAccount];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"account"] = account;
    dic[@"icon"] = @"logo_icon";
    
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
            
        }
            break;
        case XWSTouchItemAlarm:
        {
            
        }
            break;
        case XWSTouchItemStatistics:
        {
            
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

#pragma mark - 设置右边侧边栏
- (void)setUpRightView{
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json" ofType:@"json"]];
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    [self.screens removeAllObjects];
    [self.screens addObjectsFromArray:dataArray];
    
    if (!_rightView) {
        _rightView = [[XWSRightView alloc] initWithFrame:CGRectZero];
        _rightView.delegate = self;
        _rightView.hidden = YES;
        [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor clearColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_rightView];
        [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(ScreenWidth);
        }];
    }
}

- (void)showRightView{
    
    _rightView.datas = self.screens;
    _rightView.hidden = NO;
    [UIView animateWithDuration:AnimationTime animations:^{
        [_rightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(-ScreenWidth);
        }];
        [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
    //设置颜色渐变动画
    [_rightView startCoverViewOpacityWithAlpha:CoverAlphaValue withDuration:AnimationTime];
}

- (void)hideRightView{

    //把盖板颜色的alpha值至为0
    [_rightView cancelCoverViewOpacity];
    
    //移动侧边栏回到原来的位置
    [UIView animateWithDuration:AnimationTime animations:^{
        [_rightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(ScreenWidth);
        }];
        
        [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
        
    }completion:^(BOOL finished) {
        _rightView.hidden = YES;
    }];
}

#pragma mark - XWSRightViewDelegate
- (void)clickRightView:(XWSRightView *)rightView getLeftText:(NSString *)leftText getRightText:(NSString *)rightText{
    NSLog(@"leftText:%@ rightText:%@",leftText,rightText);
    [self hideRightView];
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
