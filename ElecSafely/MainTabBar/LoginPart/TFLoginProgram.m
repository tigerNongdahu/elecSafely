//
//  TFLoginProgram.m
//  ElecSafely
//
//  Created by Tianfu on 01/02/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#import "TFLoginProgram.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+XWSManager.h"
#import "AppDelegate.h"
#import "TFLoginViewController.h"
#import "XWSNavigationController.h"

@interface TFLoginProgram ()<XGPushTokenManagerDelegate>

@property (nonatomic, strong) ElecHTTPManager *requestManager;

@end

@implementation TFLoginProgram

static TFLoginProgram *loginProgram = nil;
+ (TFLoginProgram *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginProgram = [[TFLoginProgram alloc] init];
        loginProgram.requestManager = [ElecHTTPManager manager];
    });
    return loginProgram;
}

- (void)userLoginWithAccount:(NSString *)account passWord:(NSString *)password {
    password = [NSString md5:password];
    if (account.length > 0 && password.length > 0) {

        [_requestManager POST:FrigateAPI_Login_Check parameters:@{@"name":account,@"pwd":password} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *checkId =  [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];

            if ([checkId isEqualToString:@"-1"]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(loginProgram: DidLoginSuccess: passWord:)]) {
                    [self.delegate loginProgram:loginProgram DidLoginSuccess:account passWord:password];
                }
            }
            else if ([checkId isEqualToString:@"1"]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(loginProgram: DidLoginFailed:)]) {
                    [self.delegate loginProgram:loginProgram DidLoginFailed:@"密码错误"];
                }
                
                TFLoginViewController *loginVC = [[TFLoginViewController alloc] initWithFrame:CGRectZero];
                XWSNavigationController *navi = [[XWSNavigationController alloc] initWithRootViewController:loginVC];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserPassword];
                [UIApplication sharedApplication].keyWindow.rootViewController = navi;
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
            if (self.delegate && [self.delegate respondsToSelector:@selector(loginProgram: DidLoginFailed:)]) {
                [self.delegate loginProgram:loginProgram DidLoginFailed:@"登陆失败"];
            }
            
            TFLoginViewController *loginVC = [[TFLoginViewController alloc] initWithFrame:CGRectZero];
            XWSNavigationController *navi = [[XWSNavigationController alloc] initWithRootViewController:loginVC];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserPassword];
            [UIApplication sharedApplication].keyWindow.rootViewController = navi;
        }];
        
        [_requestManager POST:FrigateAPI_BindApp parameters:@{@"account":account,@"pwd":password,@"SourceType":@"02"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            
            if ([dic[@"Flag"] isKindOfClass:[NSNumber class]] &&
                     [dic[@"Flag"] integerValue] == 1) {
                [self bindWithAccount:account];
            }
            else if ([dic[@"Flag"] isKindOfClass:[NSString class]] &&
                [dic[@"Flag"] isEqualToString:@"1"]) {
                [self bindWithAccount:account];
            }
            
            if ([dic[@"Name"] isKindOfClass:[NSString class]]) {
                NSString *userName = dic[@"Name"];
                userName = userName.length > 0 ? userName : [[NSUserDefaults standardUserDefaults] objectForKey:UserAccount];
                [[NSUserDefaults standardUserDefaults] setObject:userName forKey:UserName];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // do nothing;
        }];
        
    }
}

//绑定信鸽推送
- (void)bindWithAccount:(NSString *)account {
    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:account type:XGPushTokenBindTypeAccount];
}


@end
