//
//  XWSHelpViewController.m
//  ElecSafely
//
//  Created by TigerNong on 2018/3/26.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSHelpViewController.h"
#import "XWSDetailHelpViewController.h"
#import "XWSHelpModel.h"
#import "XWSHelpCell.h"

#define TableViewRowHeight 54.0f
#define TableViewHeaderHeight 41.0f

@interface XWSHelpViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
/*返回的热点问题数组*/
@property (nonatomic, strong) NSMutableArray *quetions;

@property (nonatomic, strong) ElecProgressHUD *progressHUD;
@property (nonatomic, strong) UIView *headView;
@end

@implementation XWSHelpViewController

- (ElecProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[ElecProgressHUD alloc] init];
    }
    return _progressHUD;
}

- (NSMutableArray *)quetions{
    if (!_quetions) {
        _quetions = [NSMutableArray array];
    }
    return _quetions;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.progressHUD dismiss];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助";
    [self initView];
    [self loadHelpData];
}

- (void)clickTipView{
    [XWSTipsView dismissTipViewWithSuperView:self.view];
    [self loadHelpData];
}

#pragma mark - 加载网络数据
- (void)loadHelpData{
    [self.progressHUD showHUD:self.view Offset:-NavibarHeight animation:18];
    ElecHTTPManager *manager = [ElecHTTPManager manager];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    __weak typeof(self) weakVC = self;
    [manager GET:FrigateAPI_Help_AnswerForAsk parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultStr =  [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"responseObject:%@",resultStr);
        [weakVC dismissNoti];
        [XWSTipsView dismissTipViewWithSuperView:weakVC.view];

        NSArray *results = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        [weakVC.quetions removeAllObjects];
        
        NSLog(@"results:%ld",results.count);
        
        for (NSDictionary *dic in results) {
            XWSHelpModel *model = [[XWSHelpModel alloc] init];
            model.Title = dic[@"Title"];
            model.Content = dic[@"Content"];
            
            [weakVC.quetions addObject:model];
        }
        
        [weakVC.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [weakVC dismissNoti];
        [XWSTipsView showTipViewWithType:XWSShowViewTypeError inSuperView:weakVC.view];
        [ElecTipsView showTips:@"网络错误，请检查网络连接情况"];
    }];
}

- (void)dismissNoti{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.progressHUD dismiss];
}

#pragma mark - 设置UI
- (void)initView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = TableViewRowHeight;
        _tableView.backgroundColor = BackColor;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.left.bottom.mas_equalTo(0);
            
        }];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.quetions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID = @"helpCell";
    XWSHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XWSHelpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    XWSHelpModel *model = self.quetions[indexPath.row];
    cell.model = model;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return TableViewHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!self.headView) {
        self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, [self tableView:tableView heightForHeaderInSection:section])];
        self.headView.backgroundColor = BackColor;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.headView addSubview:titleLabel];
        titleLabel.frame = CGRectMake(18, 11, self.headView.frame.size.width - 18 * 2, self.headView.frame.size.height - 11 * 2);
        titleLabel.text = @"热点问题";
        titleLabel.font = PingFangMedium(13);
        titleLabel.textColor = RGBA(153, 153, 153, 1);
    }
    
    return self.headView;
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
