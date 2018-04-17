//
//  TFLaunchViewController.m
//  ElecSafely
//
//  Created by Tianfu on 23/12/2017.
//  Copyright © 2017 Tianfu. All rights reserved.
//

#import "TFLaunchViewController.h"
#import "Contans.h"
#import "TileGridView.h"
#import "TileView.h"
#import "TFLoginViewController.h"
#import "TFLoginProgram.h"


@interface TFLaunchViewController () <TFLoginProgramDelegate>
@property (nonatomic,strong) TileGridView *tileGridView;

@end

@implementation TFLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    _tileGridView = [[TileGridView alloc] initWithTileFileName:@"Chimes2"];
    [self.view addSubview:_tileGridView];
    _tileGridView.frame = [UIScreen mainScreen].bounds;
    
    self.view.backgroundColor = DarkBack;
    NSString *userAccount = [[NSUserDefaults standardUserDefaults] objectForKey:UserAccount];
    NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:UserPassword];
    if (userAccount.length > 0 && passWord.length > 0) {
        // to check login
        [[TFLoginProgram sharedInstance] userLoginWithAccount:userAccount passWord:passWord];
    }
    else {
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TFLoginViewController *loginVC = [[TFLoginViewController alloc] initWithFrame:CGRectZero];
        CATransition *tration = [CATransition animation];
        tration.duration = 0.3f;
        tration.type = kCATransitionFade;
        [self.navigationController.view.layer addAnimation:tration forKey:nil];
        [self.navigationController pushViewController:loginVC animated:NO];
    });
}

- (void)delayPushNextViewContoller {
    TFLoginViewController *loginVC = [[TFLoginViewController alloc] initWithFrame:CGRectZero];
    CATransition *tration = [CATransition animation];
    tration.duration = 0.3f;
    tration.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:tration forKey:nil];
    [self.navigationController pushViewController:loginVC animated:NO];
}

// 验证成功跳转mainVC
- (void)loginProgram:(TFLoginProgram *)program
     DidLoginSuccess:(NSString *)account
            passWord:(NSString *)password {
    
}

// 验证失败跳转登录页面
- (void)loginProgram:(TFLoginProgram *)program
      DidLoginFailed:(NSString *)error {
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tileGridView startAnimating];
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
