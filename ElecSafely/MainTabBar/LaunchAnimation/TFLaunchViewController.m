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
#import "JTSlideShadowAnimation.h"

@interface TFLaunchViewController ()
@property (nonatomic,strong) TileGridView *tileGridView;
@property (nonatomic, strong) JTSlideShadowAnimation *shadowAnimation;
@end

@implementation TFLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    _tileGridView = [[TileGridView alloc] initWithTileFileName:@"Chimes"];
    [self.view addSubview:_tileGridView];
    _tileGridView.frame = [UIScreen mainScreen].bounds;
    
//    self.shadowAnimation = [JTSlideShadowAnimation new];
//    self.shadowAnimation.shadowForegroundColor = [UIColor whiteColor];
//    self.shadowAnimation.shadowBackgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//    self.shadowAnimation.animatedView = self.tileGridView.companyLabel;
//    self.shadowAnimation.duration = 1.5;
//    self.shadowAnimation.shadowWidth = 40.;
    
    self.view.backgroundColor = DarkBack;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TFLoginViewController *loginVC = [[TFLoginViewController alloc] initWithFrame:CGRectZero];
        CATransition *tration = [CATransition animation];
        tration.duration = 0.3f;
        tration.type = kCATransitionFade;
        [self.navigationController.view.layer addAnimation:tration forKey:nil];
        [self.navigationController pushViewController:loginVC animated:NO];
    });
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tileGridView startAnimating];
    
    [self.shadowAnimation start];
    

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
