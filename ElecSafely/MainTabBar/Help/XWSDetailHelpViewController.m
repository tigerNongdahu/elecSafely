//
//  XWSDetailHelpViewController.m
//  ElecSafely
//
//  Created by TigerNong on 2018/3/26.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSDetailHelpViewController.h"
#import <WebKit/WebKit.h>
@interface XWSDetailHelpViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation XWSDetailHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}


- (void)initView{
    
    // 进度条
    if (!self.progressView) {
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:self.progressView];
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(3.f);
        }];
        self.progressView.tintColor = UIColorRGB(0x1C86EE);
        self.progressView.trackTintColor = [UIColor whiteColor];
    }
    
    if (!self.webview) {
        self.webview = [[WKWebView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:self.webview];
        [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.progressView.mas_bottom).mas_equalTo(0);
            make.left.right.bottom.mas_equalTo(0);
        }];
        
        //监控加载进度
        [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        self.webview.navigationDelegate = self;
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        
    }
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webview && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        }
    }
}



- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{

    [XWSTipsView showTipViewWithType:XWSShowViewTypeError inSuperView:self.view];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
//    NSLog(@"error++++:%@",error);
    [XWSTipsView showTipViewWithType:XWSShowViewTypeError inSuperView:self.view];
}

- (void)dealloc{
//    NSLog(@"%s",__func__);
    //移除kvo的监听
    [self.webview removeObserver:self forKeyPath:@"estimatedProgress"];
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
