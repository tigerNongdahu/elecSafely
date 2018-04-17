//
//  ESBaseNavigationController.m
//  ElecSafely
//
//  Created by lhb on 2018/1/31.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "ESBaseNavigationController.h"

@interface ESBaseNavigationController ()

@end

@implementation ESBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
    
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
