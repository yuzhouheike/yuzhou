//
//  SXTCycleScrollView.m
//  新闻展示
//
//  Created by 大欢 on 16/3/1.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "SXTCycleScrollView.h"
#import "UIImageView+WebCache.h"
@interface SXTCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView * leftImageView, * centerImageView, * rightImageView;

@property (nonatomic, strong) NSTimer * timer;

@end

@implementation SXTCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentPage = 1;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.contentSize = CGSizeMake(3 * CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        self.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.leftImageView];
        [self addSubview:self.centerImageView];
        [self addSubview:self.rightImageView];

        
        

    }
    return self;
}

- (void)layoutSubviews{
    
    self.contentSize = CGSizeMake(3 * CGRectGetWidth(self.bounds), 0);
    
    _leftImageView.frame = CGRectMake(0, 0, self.bounds.size.width, CGRectGetHeight(self.bounds));
    _centerImageView.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, CGRectGetHeight(self.bounds));
    _rightImageView.frame = CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, CGRectGetHeight(self.bounds));
}

- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView {
    
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] init];
    }
    return _centerImageView;
}

- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

//只是为了获取当前页数
- (void)loadData {
    
    if (self.contentOffset.x > self.bounds.size.width) {
        _currentPage = (_currentPage + 1) % _totalPage;
    }
    
    if (self.contentOffset.x < self.bounds.size.width) {
        _currentPage = (_currentPage - 1 + _totalPage) % _totalPage;
    }
    
    [self loadImage];
    
    
}

//载入图片
- (void)loadImage {
    
    /*
     *SDWebImageRetryFailed = 1<< 0,   默认选项，失败后重试   *
     *SDWebImageLowPriority = 1<< 1,    使用低优先级  *
     *SDWebImageCacheMemoryOnly = 1<< 2,   仅仅使用内存缓存
     *SDWebImageProgressiveDownload = 1<< 3,   显示现在进度
     *SDWebImageRefreshCached = 1<< 4,    刷新缓存
     *SDWebImageContinueInBackground =1 << 5,   后台继续下载图像
     *SDWebImageHandleCookies = 1<< 6,    处理Cookie
     *SDWebImageAllowInvalidSSLCertificates= 1 << 7,    允许无效的SSL验证
     *SDWebImageHighPriority = 1<< 8,     高优先级
     *SDWebImageDelayPlaceholder = 1<< 9     延迟显示占位图片
     */
    
    NSString * leftName = self.dataList[(_currentPage - 1 + _totalPage) % _totalPage];
//    _leftImageView.image = [UIImage imageNamed:leftName];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:leftName]placeholderImage:[UIImage imageNamed:@"桌面"] options:SDWebImageLowPriority | SDWebImageRetryFailed | SDWebImageProgressiveDownload];
    NSString * centerName = self.dataList[_currentPage];
//    _centerImageView.image = [UIImage imageNamed:centerName];
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:centerName]placeholderImage:[UIImage imageNamed:@"桌面"] options:SDWebImageLowPriority | SDWebImageRetryFailed | SDWebImageProgressiveDownload];
    
    NSString * rightName = self.dataList[(_currentPage + 1) % _totalPage];
//    _rightImageView.image = [UIImage imageNamed:rightName];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:rightName]placeholderImage:[UIImage imageNamed:@"桌面"] options:SDWebImageLowPriority | SDWebImageRetryFailed | SDWebImageProgressiveDownload];
    
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    
    if ([self.cycleDelegate respondsToSelector:@selector(cycleScrollView:currentPage:)]) {
        [self.cycleDelegate cycleScrollView:self currentPage:_currentPage];
    }
    
    if (self.block) {
    
        self.block(_currentPage);
    }
    
    //修改六，将启动计时器的方法换成新添加的StartTime
    
    [self startTime];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    //停止
    [self.timer invalidate];
    
    self.timer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self loadData];
    
    //修改六，将启动计时器的方法换成新添加的StartTime
    [self startTime];
}

//当setContentOffset动画结束时调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self loadData];
}

- (void)timeFire {
    
    //定时调到最后一页
    [self setContentOffset:CGPointMake(2 * self.bounds.size.width, 0) animated:YES];
}



//修改五，将添加计时器的内容单独放倒一个方法里面

- (void)startTime{
    [self.timer invalidate];
    
    self.timer = nil;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeFire) userInfo:nil repeats:YES];
}

@end
