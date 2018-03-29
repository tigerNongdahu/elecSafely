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

#define SIDE_MARGIN 18
#define IMAGE_MARGIN 10

#define ITEM_SIZE_WIDTH ((ScreenWidth - 2 * SIDE_MARGIN - 5 * IMAGE_MARGIN)/ 4)
#define ITEM_SIZE_HEIGHT ITEM_SIZE_WIDTH

@interface XWSFeedbackViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
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
@property (nonatomic, strong) UILabel *imageCountLabel;
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
        make.top.mas_equalTo(17);
        make.left.mas_equalTo(18);
        make.height.mas_equalTo(30);
    }];
    self.place.text = @"请输入不少于10个字的描述";
    self.place.textColor = RGBA(102, 102, 102, 1);
    self.place.font = PingFangRegular(17);
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView.font = PingFangRegular(17);
    self.textView.delegate = self;
    self.textView.textColor = RGBA(221, 221, 221, 1);
    self.textView.backgroundColor = [UIColor clearColor];
    [textContentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
//    UIView *imageContentView = [[UIView alloc] initWithFrame:CGRectZero];
//
//    CGFloat ch = (ScreenWidth - 84) / 4.0 + 67 + 17;
//
//    [self.view addSubview:imageContentView];
//    imageContentView.backgroundColor = NavColor;
//    [imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(textContentView.mas_bottom).mas_equalTo(20);
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(ch);
//    }];
//
//    UILabel *imageTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    [imageContentView addSubview:imageTitleLabel];
//    [imageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(18);
//        make.height.mas_equalTo(57);
//
//    }];
//    imageTitleLabel.text = @"请提供相关问题的截图或相片";
//    imageTitleLabel.textColor = RGBA(221, 221, 221, 1);
//    imageTitleLabel.font = PingFangRegular(17);
//
//    UILabel *imageCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    self.imageCountLabel = imageCountLabel;
//    [imageContentView addSubview:imageCountLabel];
//    imageCountLabel.font = PingFangMedium(12);
//    imageCountLabel.textColor = RGBA(102, 102, 102, 1);
//    imageCountLabel.text = @"0/4";
//    imageCountLabel.textAlignment = NSTextAlignmentRight;
//    [imageCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(imageTitleLabel.mas_centerY);
//        make.right.mas_equalTo(-17);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(50);
//    }];
//
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//
//    flowLayout.itemSize = CGSizeMake(ITEM_SIZE_WIDTH, ITEM_SIZE_HEIGHT);
//
//    //设置CollectionView的属性
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SIDE_MARGIN, 63, ScreenWidth - 2 * SIDE_MARGIN, ITEM_SIZE_WIDTH) collectionViewLayout:flowLayout];
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    self.collectionView.scrollEnabled = YES;
//    self.collectionView.backgroundColor = NavColor;
//    //注册Cell
//    [self.collectionView registerClass:[XWSFeedImageCell class] forCellWithReuseIdentifier:@"XWSFeedImageCell"];
//    [imageContentView addSubview:self.collectionView];

}

#pragma mark - 发送异常情况
- (void)sendFeedBack{
    NSLog(@"send");
    [self.textView resignFirstResponder];
    NSString *t = [self.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (t.length < 10) {
        [ElecTipsView showTips:@"请输入不小于10个字的描述字符"];
        return;
    }
     ElecHTTPManager *manager = [ElecHTTPManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"ask"] = self.textView.text;
    [manager POST:FrigateAPI_SubmitAsk parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ElecTipsView showTips:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [ElecTipsView showTips:@"网络错误，请检查网络连接情况"];
    }];
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
    if(self.images.count == 4){
        return self.images.count;
    }
    return self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XWSFeedImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XWSFeedImageCell" forIndexPath:indexPath];
    
    if (indexPath.row == self.images.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn@2x"];
        cell.close.hidden = YES;
    }else{
        cell.imageView.image = self.images[indexPath.row];
        cell.close.hidden = NO;
    }
    
    cell.close.tag = 100 + indexPath.row;
    [cell.close addTarget:self action:@selector(deletePhotos:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.textView resignFirstResponder];
    
    XWSFeedImageCell *cell = (XWSFeedImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.images.count == indexPath.item && cell.close.hidden == YES) {
        [self addFeedImage];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(ITEM_SIZE_WIDTH, ITEM_SIZE_HEIGHT);
}

#pragma mark -  删除图片
- (void)deletePhotos:(UIButton *)sender{
    [self.images removeObjectAtIndex:sender.tag - 100];
    self.imageCountLabel.text = [NSString stringWithFormat:@"%ld/4",self.images.count];
    [_collectionView reloadData];
}

#pragma mark - 添加图片
//点击头像获取图片
- (void)addFeedImage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //图片选自控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    
    //相机
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
        
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            ipc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        }
        
        [self presentViewController:ipc animated:YES completion:nil];
        
    }];
    
    //相册
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) return;
        
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:ipc animated:YES completion:nil];
    }];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cameraAction];
    [alertController addAction:albumAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - uiimagePicke
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //如果是拍照，则拍照后把图片保存在相册
    UIImage *image;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    [self.images addObject:image];
    
    self.imageCountLabel.text = [NSString stringWithFormat:@"%ld/4",self.images.count];
    [picker dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
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
