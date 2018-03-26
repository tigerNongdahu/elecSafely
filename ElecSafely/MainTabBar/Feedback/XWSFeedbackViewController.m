//
//  XWSFeedbackViewController.m
//  ElecSafely
//
//  Created by TigerNong on 2018/3/26.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSFeedbackViewController.h"
#define TableViewRowHeight 150.0
#define MAX_LIMIT_NUMS 300
#define MIN_LIMIT_NUMS 9

@interface XWSFeedbackViewController ()<UITextViewDelegate>
/*站位字符标签*/
@property (nonatomic, strong) UILabel *place;
/*字数提示标签*/
@property (nonatomic, strong) UILabel *numLabel;
/*提交按钮*/
@property (nonatomic, strong) UIButton *sendBtn;
/*输入框*/
@property (nonatomic, strong) UITextView *textView;
@end

@implementation XWSFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    [self initView];
}

- (void)setUpNavi{
    self.title = @"意见反馈";
    
    self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30)];
    [self.sendBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendBtn.titleLabel.font = PingFangMedium(17);
    self.sendBtn.enabled = NO;
    [self.sendBtn addTarget:self action:@selector(sendFeedBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.sendBtn];
}

#pragma mark - 设置UI
- (void)initView{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-17);
        make.height.mas_equalTo(40);
    }];
    
    titleLabel.font = PingFangLight(13);
    titleLabel.textColor = RGBA(153, 153, 153, 1);
    titleLabel.text = @"请补充详细问题和意见";
    
    UIView *textContentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:textContentView];
    textContentView.backgroundColor = NavColor;
    [textContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    self.place = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [textContentView addSubview:self.place];
    [self.place mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(17);
        make.height.mas_equalTo(30);
    }];
    self.place.text = @"请输入不少于10个字的描述";
    self.place.textColor = RGBA(153, 153, 153, 1);
    self.place.font = PingFangLight(17);
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.font = PingFangMedium(17);
    textView.delegate = self;
    textView.textColor = RGBA(221, 221, 221, 1);
    textView.backgroundColor = [UIColor clearColor];
    [textContentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(10);
    }];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [textContentView addSubview:self.numLabel];
    self.numLabel.textColor = RGBA(153, 153, 153, 1);
    self.numLabel.font = PingFangLight(13);
    self.numLabel.text = @"0/300";
    self.numLabel.textAlignment = NSTextAlignmentRight;
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-17);
    }];
    
    UIView *imageContentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:imageContentView];
    imageContentView.backgroundColor = NavColor;
    [imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textContentView.mas_bottom).mas_equalTo(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    UILabel *imageTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [imageContentView addSubview:imageTitleLabel];
    [imageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(17);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(250);
    }];
    imageTitleLabel.text = @"请提供相关问题的截图或相片";
    imageTitleLabel.textColor = RGBA(221, 221, 221, 1);
    imageTitleLabel.font = PingFangLight(17);
    
    UILabel *imageCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [imageContentView addSubview:imageCountLabel];
    imageCountLabel.font = PingFangLight(13);
    imageCountLabel.textColor = RGBA(153, 153, 153, 1);
    imageCountLabel.text = @"0/4";
    imageCountLabel.textAlignment = NSTextAlignmentRight;
    [imageCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-17);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark - 发送异常情况
- (void)sendFeedBack{
    NSLog(@"send");
    
    NSString *t = [self.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (t.length < 10) {
        [ElecTipsView showTips:@"请输入不小于10个字的描述字符"];
        return;
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        self.place.hidden = YES;
    }else{
        self.place.hidden = NO;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    //不让显示负数
    self.numLabel.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
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
