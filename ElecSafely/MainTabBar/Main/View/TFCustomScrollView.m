//
//  TFCustomScrollView.m
//  ElecSafely
//
//  Created by Tianfu on 20/04/2018.
//  Copyright © 2018 Tianfu. All rights reserved.
//

#import "TFCustomScrollView.h"
//#import "SGFocusImageItem.h"
#import <objc/runtime.h>

#define ITEM_Height     70.f
#define PAGECONTROL_W   40.f
#define PAGECONTROL_H   25.f

static NSString *SG_FOCUS_ITEM_ASS_KEY = @"loopScrollview";
static CGFloat SWITCH_FOCUS_PICTURE_INTERVAL = 3.0; //switch interval time

@interface TFCustomScrollView () {
    UIScrollView   *_scrollView;
}

@property (nonatomic, strong) NSArray *advertisementSourceArray;

- (void)setupViews;
- (void)switchFocusImageItems;

@end

@implementation TFCustomScrollView

@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<TFCustomScrollViewDelegate>)delegate DataItems:(NSArray *)items isAuto:(BOOL)isAuto
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSMutableArray *imageItems = [NSMutableArray arrayWithArray:items];
        objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _isAutoPlay = isAuto;
        [self setupViews];
        
        [self setDelegate:delegate];
    }
    return self;
}

- (void)dealloc
{
    objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    _scrollView.delegate = nil;
}

#pragma mark - private methods
- (void)setupViews
{
    NSArray *dataItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;
    
    [self addSubview:_scrollView];
    
    if (_isAutoPlay) {
        _scrollView.scrollEnabled = YES;
    } else {
        _scrollView.scrollEnabled = NO;
    }
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = BackColor;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:tapGestureRecognize];
    _scrollView.contentSize = CGSizeMake(0, ITEM_Height * dataItems.count);
    _scrollView.exclusiveTouch = YES;
    
    // 加载图片
    for (NSInteger i = 0; i < dataItems.count; i++) {
        XWSHelpModel *item = (XWSHelpModel *)dataItems[i];
        UIButton *cell = [[UIButton alloc] initWithFrame:CGRectMake(0, i * ITEM_Height, self.bounds.size.width, ITEM_Height)];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.font = PingFangMedium(15);
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = NavColor;
        if([item.Title isKindOfClass:[NSString class]]) {
            [cell setTitle:item.Title forState:UIControlStateNormal];
        }
        
        cell.tag = 1000 + i;
        
        [_scrollView addSubview:cell];
    }
    
//    if ([dataItems count]>2)
//    {
//        [_scrollView setContentOffset:CGPointMake(0, ITEM_Height) animated:NO];
//        if (_isAutoPlay)
//        {
//            [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
//        }
//    }
}

//- (void)switchFocusImageItems
//{
//
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
//
//    CGFloat targetY = _scrollView.contentOffset.y + ITEM_Height;
//    NSArray *dataItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
//    targetY = (CGFloat)((int)(targetY/ITEM_Height)) *  _scrollView.frame.size.height;
//    [self moveToTargetPosition:targetY];
//
//    if ([dataItems count]>1 && _isAutoPlay) {
//        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
//    }
//}
//
//- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
//{
//    NSArray *imageItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
//    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
//    if (page > -1 && page < (int)imageItems.count) {
//        XWSHelpModel *item = imageItems[(NSUInteger)page];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
//            [self.delegate foucusImageFrame:self didSelectItem:item];
//        }
//    }
//}
//
//- (void)moveToTargetPosition:(CGFloat)targetX
//{
//    BOOL animated = YES;
//    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:animated];
//}
//
//#pragma mark - UIScrollViewDelegate
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    float targetY = scrollView.contentOffset.y;
//    NSArray *dataItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
//    if ([dataItems count]>=3)
//    {
//        if (targetY >= ITEM_Height * ([dataItems count] -1)) {
//            targetY = ITEM_Height;
//            [_scrollView setContentOffset:CGPointMake(0, targetY) animated:NO];
//        }
//        else if(targetY <= 0)
//        {
//            targetY = ITEM_Height *([dataItems count]-2);
//            [_scrollView setContentOffset:CGPointMake(0, targetY) animated:NO];
//        }
//    }
//
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (_isAutoPlay)
//    {
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
//        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
//    }
//    if (!decelerate)
//    {
//        CGFloat targetY = _scrollView.contentOffset.y + _scrollView.frame.size.height;
//        targetY = (int)(targetY/ITEM_Height) * ITEM_Height;
//        [self moveToTargetPosition:targetY];
//    }
//}
//
//- (void)scrollToIndex:(int)aIndex
//{
//    NSArray *dataItems = objc_getAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY);
//    if ([dataItems count]>1)
//    {
//        if (aIndex >= ((int)[dataItems count] - 2))
//        {
//            aIndex = (int)[dataItems count] - 3;
//        }
//        [self moveToTargetPosition:ITEM_Height*(aIndex+1)];
//    }else
//    {
//        [self moveToTargetPosition:0];
//    }
//    [self scrollViewDidScroll:_scrollView];
//}

@end

