//
//  ESStatisticViewController.m
//  ElecSafely
//
//  Created by lhb on 2018/3/22.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "ESStatisticViewController.h"
#import "ESStatisticView.h"
#import "XWSFliterView.h"
#import "ESDeviceDataProcessor.h"

@interface ESStatisticViewController ()<XWSFliterViewDelegate>

@property (nonatomic,strong)ESStatisticView *statisticView;
@property (nonatomic, strong) XWSFliterView *fliterView;
@property (nonatomic,strong)ESDeviceDataProcessor *dataProcessor;
@property (nonatomic, strong) ElecProgressHUD *progressHUD;

@end

@implementation ESStatisticViewController

- (ElecProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[ElecProgressHUD alloc] init];
    }
    return _progressHUD;
}

- (ESStatisticView *)statisticView{
    
    if (_statisticView == nil) {
        _statisticView = [[ESStatisticView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavibarHeight)];
    }
    return _statisticView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.08 green:0.09 blue:0.14 alpha:1.00];
    self.title = @"统计";
    self.dataProcessor = [[ESDeviceDataProcessor alloc] init];

    [self setUpFliterView];
    [self createRightBarItem];
    [self.view addSubview:self.statisticView];
    [self.progressHUD showHUD:self.view Offset:- NavibarHeight animation:18];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.progressHUD dismiss];
}

- (void)setUpFliterView{
    if (!_fliterView) {
        _fliterView = [[XWSFliterView alloc] initWithFrame:CGRectZero type:Statistic];
        _fliterView.delegate = self;
    }
}

- (void)createRightBarItem{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_filter"] style:UIBarButtonItemStyleDone target:self action:@selector(filterData:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//
- (void)filterData:(id)sender{
    [_fliterView show];
}

#pragma mark - XWSFliterViewDelegate
- (void)clickFliterView:(XWSFliterView *)fliterView dataSource:(NSDictionary *)dataSource{
    
    __weak typeof(self) weakSelf = self;
    NSString *deviceID = dataSource[@"deviceID"];
    [self.dataProcessor requestDeviceChartHistoryDataWithDeviceID:deviceID success:^(NSArray *chartData) {
        [weakSelf.statisticView loadCurveChartData:chartData];
        [weakSelf.progressHUD dismiss];
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
