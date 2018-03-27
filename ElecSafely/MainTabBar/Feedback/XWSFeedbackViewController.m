//
//  XWSFeedbackViewController.m
//  ElecSafely
//
//  Created by TigerNong on 2018/3/26.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSFeedbackViewController.h"
#import "XWSFeedImageCell.h"
#define TableViewRowHeight 150.0
#define MAX_LIMIT_NUMS 300
#define MIN_LIMIT_NUMS 9

@interface XWSFeedbackViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
/*站位字符标签*/
@property (nonatomic, strong) UILabel *place;
/*字数提示标签*/
@property (nonatomic, strong) UILabel *numLabel;
/*提交按钮*/
@property (nonatomic, strong) UIButton *sendBtn;
/*输入框*/
@property (nonatomic, strong) UITextView *textView;
/*显示图片的view*/
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation XWSFeedbackViewController

- (NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavi];
    [self initView];
    self.view.backgroundColor = BackColor;
    
//    [self.images addObject:[UIImage imageNamed:@"left_help"]];
//    [self.images addObject:[UIImage imageNamed:@"left_setting"]];

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
        make.left.mas_equalTo(18);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo(40);
    }];
    
    titleLabel.font = PingFangMedium(13);
    titleLabel.textColor = RGBA(102, 102, 102, 1);
    titleLabel.text = @"请补充详细问题和意见";
    
    UIView *textContentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:textContentView];
    textContentView.backgroundColor = NavColor;
    [textContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(138);
    }];
    
    self.place = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [textContentView addSubview:self.place];
    [self.place mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(18);
        make.height.mas_equalTo(30);
    }];
    self.place.text = @"请输入不少于10个字的描述";
    self.place.textColor = RGBA(102, 102, 102, 1);
    self.place.font = PingFangRegular(17);
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.font = PingFangRegular(17);
    textView.delegate = self;
    textView.textColor = RGBA(221, 221, 221, 1);
    textView.backgroundColor = [UIColor clearColor];
    [textContentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-12);
    }];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [textContentView addSubview:self.numLabel];
    self.numLabel.textColor = RGBA(102, 102, 102, 1);
    self.numLabel.font = PingFangMedium(13);
    self.numLabel.text = @"300/300";
    self.numLabel.textAlignment = NSTextAlignmentRight;
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.right.mas_equalTo(-15);
    }];
    
    UIView *imageContentView = [[UIView alloc] initWithFrame:CGRectZero];
    
    CGFloat ch = (ScreenWidth - 84) / 4.0 + 67 + 17;
    
    [self.view addSubview:imageContentView];
    imageContentView.backgroundColor = NavColor;
    [imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textContentView.mas_bottom).mas_equalTo(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(ch);
    }];
    
    UILabel *imageTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [imageContentView addSubview:imageTitleLabel];
    [imageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(18);
        make.height.mas_equalTo(57);

    }];
    imageTitleLabel.text = @"请提供相关问题的截图或相片";
    imageTitleLabel.textColor = RGBA(221, 221, 221, 1);
    imageTitleLabel.font = PingFangRegular(17);
    
    UILabel *imageCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [imageContentView addSubview:imageCountLabel];
    imageCountLabel.font = PingFangMedium(12);
    imageCountLabel.textColor = RGBA(102, 102, 102, 1);
    imageCountLabel.text = @"0/4";
    imageCountLabel.textAlignment = NSTextAlignmentRight;
    [imageCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageTitleLabel.mas_centerY);
        make.right.mas_equalTo(-17);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(50);
    }];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    flowLayout.itemSize = CGSizeMake((ScreenWidth - 36 - 50)/ 4, (ScreenWidth - 36 - 50)/ 4);

    //设置CollectionView的属性
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(17, 63, ScreenWidth - 36, (ScreenWidth - 86) / 4 ) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.backgroundColor = NavColor;
    //注册Cell
    [self.collectionView registerClass:[XWSFeedImageCell class] forCellWithReuseIdentifier:@"XWSFeedImageCell"];
    [imageContentView addSubview:self.collectionView];

}

#pragma mark - 发送异常情况
- (void)sendFeedBack{
    NSLog(@"send");
     [self.textView resignFirstResponder];
    [self.textView endEditing:YES];
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

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XWSFeedImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XWSFeedImageCell" forIndexPath:indexPath];
    
//    if (indexPath.row == self.images.count) {
//        cell.imageView.image = [UIImage imageNamed:@"left_scan"];
//        cell.close.hidden = YES;
//    }else{
//        NSLog(@"ddd");
//        cell.imageView.image = self.images[indexPath.row];
//        cell.close.hidden = NO;
//    }
    
    cell.imageView.image = [UIImage imageNamed:@"left_scan"];
    
    cell.close.tag = 100 + indexPath.row;
    [cell.close addTarget:self action:@selector(deletePhotos:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"ss");
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake((ScreenWidth - 86)/ 4, (ScreenWidth - 86)/ 4);
}

- (void)deletePhotos:(UIButton *)sender{
    [self.images removeObjectAtIndex:sender.tag - 100];

    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag-100 inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
    [self.textView endEditing:YES];
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
