//
//  SXTHeadView.m
//  新闻展示
//
//  Created by 大欢 on 16/3/1.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "SXTHeadView.h"
#import "SXTCycleScrollView.h"
//#import "SXTNewsHeader.h"

static NSInteger kBackViewHeight = 30;

//static NSInteger kMargin = 10;

@interface SXTHeadView ()<SXTCycleScrollViewDelegate>

@property (nonatomic, strong) SXTCycleScrollView * scrollView;

@property (nonatomic, strong) UIView * backView;

@property (nonatomic, strong) UILabel * textLabel;

@property (nonatomic, strong) UIPageControl * pageControl;

@end

@implementation SXTHeadView

- (SXTCycleScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[SXTCycleScrollView alloc] init];
//        _scrollView.backgroundColor = [UIColor redColor];
//        _scrollView.cycleDelegate = self;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        __weak id weakself = self;
        
        _scrollView.block = ^(NSInteger currentPage) {
            
            SXTHeadView * w = (SXTHeadView *)weakself;
            
            //修改一45行引调
            
//            w.textLabel.text = [w.dataList[currentPage] title];
            w.pageControl.currentPage = currentPage;
        };
    }
    return _scrollView;
}

- (UILabel *)textLabel {
    
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        //修改二
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.hidden = YES;
    }
    return _textLabel;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        //修改二
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

- (UIView *)backView {
    
    if (!_backView) {
        _backView = [[UIView alloc] init];
//        _backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _backView.backgroundColor = [UIColor clearColor];
        //修改二
        _backView.translatesAutoresizingMaskIntoConstraints = NO;
        [_backView addSubview:self.textLabel];
        [_backView addSubview:self.pageControl];
    }
    return _backView;
}

- (void)setDataList:(NSArray *)dataList {
    
    
    
    _dataList = dataList;
    
    _pageControl.numberOfPages = _scrollView.totalPage = dataList.count;
    
    //修改三，引调数组的制作，并添加第103行
    
//    NSMutableArray * images = [NSMutableArray array];
//    for (SXTNewsHeader * header in dataList) {
//        [images addObject:header.image];
//    }
//    
//    //给scrollView传图片数组
//    _scrollView.dataList = images;
    _scrollView.dataList = dataList;
    
    //修改五，在添加数据以后启动计时器，否则在没有数据的时候会造成崩溃
    [_scrollView loadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self addSubview:self.backView];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //修改四，给scroll上的全部控件添加约束，为了以后能继续使用，约束条件用VFL添加
//    self.scrollView.frame = self.bounds;
    NSArray *scrollViewWidth = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(_scrollView)];
    [self addConstraints:scrollViewWidth];
    
    NSArray *scrollViewHeight = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(_scrollView)];
    [self addConstraints:scrollViewHeight];
    
//    self.backView.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - kBackViewHeight, CGRectGetWidth(self.bounds), kBackViewHeight);
    
    NSArray *backViewWidth = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backView]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(_backView)];
    [self addConstraints:backViewWidth];
    
    NSLayoutConstraint *backViewHeight = [NSLayoutConstraint constraintWithItem:_backView
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0
                                                                       constant:kBackViewHeight];
    [_backView addConstraint:backViewHeight];
    
    NSLayoutConstraint *backViewBottom = [NSLayoutConstraint constraintWithItem:_backView
                                                                      attribute:(NSLayoutAttributeBottom)
                                                                      relatedBy:(NSLayoutRelationEqual)
                                                                         toItem:self
                                                                      attribute:(NSLayoutAttributeBottom)
                                                                     multiplier:1.0
                                                                       constant:0];
    [self addConstraint:backViewBottom];

    
    CGSize pageSize = [self.pageControl sizeForNumberOfPages:self.dataList.count];
    NSNumber *number = [NSNumber numberWithInteger:pageSize.width];
//    self.pageControl.frame = CGRectMake(CGRectGetWidth(self.bounds) - pageSize.width - kMargin, 0, pageSize.width, kBackViewHeight);
//    NSInteger count = self.dataList.count*16;
//    NSNumber *number = [NSNumber numberWithInteger:count];
    NSArray *textLabellWidth = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_textLabel]-10-[_pageControl(>=number@999)]-10-|"
                                                                       options:kNilOptions
                                                                       metrics:NSDictionaryOfVariableBindings(number)
                                                                         views:NSDictionaryOfVariableBindings(_textLabel,_pageControl)];
    [_backView addConstraints:textLabellWidth];
    
    NSArray *textLabelHeight = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_textLabel]|"
                                                                       options:kNilOptions
                                                                       metrics:nil
                                                                         views:NSDictionaryOfVariableBindings(_textLabel)];
    [_backView addConstraints:textLabelHeight];
    
    NSArray *pageControlHeight = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_pageControl]|"
                                                                       options:kNilOptions
                                                                       metrics:nil
                                                                         views:NSDictionaryOfVariableBindings(_pageControl)];
    [_backView addConstraints:pageControlHeight];

//    self.textLabel.frame = CGRectMake(kMargin, 0, CGRectGetMidX(self.pageControl.frame)- 2 * kMargin, kBackViewHeight);

    
}

- (void)cycleScrollView:(SXTCycleScrollView *)scrollView currentPage:(NSInteger)currentPage {
    
    self.textLabel.text = [self.dataList[currentPage] title];
    self.pageControl.currentPage = currentPage;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
