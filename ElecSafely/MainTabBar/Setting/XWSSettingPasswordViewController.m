//
//  XWSSettingPasswordViewController.m
//  ElecSafely
//
//  Created by TigerNong on 2018/3/29.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSSettingPasswordViewController.h"
#import "NSString+XWSManager.h"
#import "XWSPwdInputCell.h"
#import "XWSDeviceInfoCell.h"
#import "TFLoginViewController.h"
#import "XWSNavigationController.h"
#define RowHeight  66.0f

#define OLD_PASSWORD_ERROR_STRING @"原始密码错误"
#define MODIFY_PASSWORD_SUCCESS_STRING @"密码修改成功"
@interface XWSSettingPasswordViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UITextField *oldTextField;
@property (nonatomic, weak) UITextField *neTextField;
@property (nonatomic, weak) UITextField *conTextField;
@property (nonatomic, strong) UIButton *sendBtn;

@property (nonatomic, strong) ElecProgressHUD *progressHUD;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *places;

@property (nonatomic, copy) NSString *OldPwd;
@property (nonatomic, copy) NSString *NewPwd;
@property (nonatomic, copy) NSString *conPwd;
@end

@implementation XWSSettingPasswordViewController

- (NSMutableArray *)places{
    if (!_places) {
        _places = [NSMutableArray arrayWithObjects:@"请输入6-16位原密码",@"请输入6-16位新密码",@"请重复输入新密码", nil];
    }
    return _places;
}

- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray arrayWithObjects:@"原密码",@"新密码",@"确认密码", nil];
    }
    return _titles;
}

- (ElecProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[ElecProgressHUD alloc] init];
    }
    return _progressHUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    [self initView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.oldTextField resignFirstResponder];
    [self.neTextField resignFirstResponder];
    [self.conTextField resignFirstResponder];
    
}

- (void)setUpNavi{
    //设置标题
    self.title = @"账号与安全";
    self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30)];
    [self.sendBtn setTitle:@"提交" forState:UIControlStateNormal];
    _sendBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.sendBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
    self.sendBtn.titleLabel.font = PingFangMedium(15);
    self.sendBtn.userInteractionEnabled = NO;
    [self.sendBtn addTarget:self action:@selector(savePwd) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.sendBtn];
}

- (void)initView{
    
    //设置表视图
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0.3);
    }];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = RowHeight;
    
    //去掉系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackColor;
    
}

#pragma mark - 修改密码
- (void)savePwd{
    
    if (![self checkParam]) {
        return;
    }
    
     [self.progressHUD showHUD:self.view Offset:-NavibarHeight animation:18];
    
    NSString *old = [self.oldTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *nP = [self.neTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

   
    ElecHTTPManager *manager = [ElecHTTPManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    param[@"OldPW"] = [NSString md5:old];
    param[@"NldPW"] = [NSString md5:nP];
    // password:8ddcff3a80f4189ca1c9d4d902c3c909
    //          8ddcff3a80f4189ca1c9d4d902c3c909
     NSLog(@"[NSString md5:old]:%@",param[@"OldPW"]);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    __weak typeof(self) weakVC = self;
    [manager POST:FrigateAPI_ChangePW parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [weakVC.progressHUD dismiss];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        NSString *resultStr =  [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        
        [ElecTipsView showTips:resultStr during:2.0];
         NSLog(@"checkId:%@",resultStr);
        // 如果放回的是“密码修改成功”，则退出到登录页面
        if ([resultStr containsString:MODIFY_PASSWORD_SUCCESS_STRING]) {
            [weakVC logOut];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [weakVC.progressHUD dismiss];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [ElecTipsView showTips:@"网络错误，请检查网络情况" during:2.0];
    }];
}

- (void)logOut{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            TFLoginViewController *loginVC = [[TFLoginViewController alloc] initWithFrame:CGRectZero];
            XWSNavigationController *navi = [[XWSNavigationController alloc] initWithRootViewController:loginVC];
            [UIApplication sharedApplication].keyWindow.rootViewController = navi;
        });
    });
}

- (BOOL)checkParam{
    [self.oldTextField resignFirstResponder];
    [self.neTextField resignFirstResponder];
    [self.conTextField resignFirstResponder];
    
    if (![self checkPwd:self.oldTextField.text]) {
        [ElecTipsView showTips:@"请输入6~16位的原密码" during:2.0];
        return NO;
    }
    
    if (![self checkPwd:self.neTextField.text]) {
        [ElecTipsView showTips:@"请输入6~16位的新密码" during:2.0];
        return NO;
    }
    
    if (![self checkPwd:self.conTextField.text]) {
        [ElecTipsView showTips:@"请输入6~16位的新密码" during:2.0];
        return NO;
    }
    
    if (![self.neTextField.text isEqualToString:self.conTextField.text]) {
        [ElecTipsView showTips:@"新密码与确认密码不一致" during:2.0];
        return NO;
    }
    
    return YES;
}


- (BOOL)checkPwd:(NSString *)pwd{
    NSString *p = [pwd stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (p.length < 6 || p.length > 16) {
        return NO;
    }
    return YES;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title = self.titles[indexPath.row];
    NSString *place = self.places[indexPath.row];
    
    XWSDeviceInfoCell *cell = [XWSDeviceInfoCell cellWithTableView:tableView withTitle:title withPlaceHolder:place withStandardTextLength:4 withStandardString:@"确认密码"];
    cell.textField.delegate = self;
    cell.textField.secureTextEntry = YES;
    cell.textField.returnKeyType = UIReturnKeyNext;
    
    switch (indexPath.row) {
        case 0:
        {
            self.oldTextField = cell.textField;
        }
            break;
        case 1:
        {
            self.neTextField = cell.textField;
        }
            break;
        case 2:
        {
            cell.textField.returnKeyType = UIReturnKeyDone;
            self.conTextField = cell.textField;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.oldTextField resignFirstResponder];
    [self.neTextField resignFirstResponder];
    [self.conTextField resignFirstResponder];
}

#pragma mark - UItextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.oldTextField) {
        [self.neTextField becomeFirstResponder];
    }else if (textField == self.neTextField){
        [self.conTextField becomeFirstResponder];
    }else{
        [self.conTextField resignFirstResponder];
    }
    return YES;
}


- (void)textFieldDidChange{
    if (![NSString checkIsNilWithStr:self.neTextField.text] && ![NSString checkIsNilWithStr:self.oldTextField.text] && ![NSString checkIsNilWithStr:self.conTextField.text]) {
        self.sendBtn.userInteractionEnabled = YES;
        [self.sendBtn setTitleColor:RGBA(255, 255, 255, 1) forState:UIControlStateNormal];
    }else{
        self.sendBtn.userInteractionEnabled = NO;
        [self.sendBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.oldTextField resignFirstResponder];
    [self.neTextField resignFirstResponder];
    [self.conTextField resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
