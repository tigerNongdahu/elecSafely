//
//  TFLaunchViewController.m
//  ElecSafely
//
//  Created by Tianfu on 23/12/2017.
//  Copyright © 2017 Tianfu. All rights reserved.
//

#import "TFLaunchViewController.h"
#import "AnimatedULogoView.h"
#import "Contans.h"
#import "TileGridView.h"
#import "TileView.h"
#import "TFLoginViewController.h"


@interface TFLaunchViewController ()
@property (nonatomic,strong) AnimatedULogoView *animatedView;
@property (nonatomic,strong) TileGridView *tileGridView;

@end

@implementation TFLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tileGridView = [[TileGridView alloc] initWithTileFileName:@"Chimes"];
    [self.view addSubview:_tileGridView];
    _tileGridView.frame = [UIScreen mainScreen].bounds;
    
//    _tileGridView.didEndBlock = ^{
//        TFLoginViewController *loginVC = [[TFLoginViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//        [UIApplication sharedApplication].delegate.window.rootViewController = nav;
//        [[UIApplication sharedApplication].delegate.window reloadInputViews];
//    };
    
    _animatedView = [[AnimatedULogoView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    [self.view addSubview:_animatedView];
    _animatedView.layer.position = self.view.layer.position;
    self.view.backgroundColor = UberBlue;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tileGridView startAnimating];
    [_animatedView startAniamting];
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
