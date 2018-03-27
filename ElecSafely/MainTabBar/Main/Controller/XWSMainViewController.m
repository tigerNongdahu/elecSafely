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

#define AnimationTime 0.35
#define CoverAlphaValue 0.5

@interface XWSMainViewController ()<XWSLeftViewDelegate,XWSRightViewDelegate>
@property (nonatomic, strong) XWSLeftView *leftView;
@property (nonatomic, strong) XWSRightView *rightView;

@end

@implementation XWSMainViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNav];
    [self setUpLeftView];
    [self setUpRightView];
    
    NSLog(@"size:%@",NSStringFromCGSize([UIScreen mainScreen].bounds.size));
    if (ScreenWidth == IPHONE_X_WIDTH && ScreenHeight == IPHONE_X_HEIGHT) {
        NSLog(@"DDD");
    }
    
}


- (void)setUpNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_devices_list"] style:0 target:self action:@selector(showLeftView)];
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateNormal];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_setting"] style:0 target:self action:@selector(showRightView)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_scan"] style:0 target:self action:@selector(changeAlpha)];
    self.navigationItem.rightBarButtonItems = @[rightItem1,rightItem2];
}

- (void)changeAlpha{
 
    
    
    
    
}


#pragma - mark 设置左边
- (void)setUpLeftView{
    
    //获取到的个人信息
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:UserAccount];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"account"] = account;
    dic[@"icon"] = @"left_setting";
    
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
    
    if (!_rightView) {
        _rightView = [[XWSRightView alloc] initWithFrame:CGRectZero withDatas:dataArray];
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


- (void)dealloc{
    NSLog(@"main:%s",__func__);
}

@end
