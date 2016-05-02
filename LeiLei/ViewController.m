//
//  ViewController.m
//  PictureScroll
//
//  Created by liyi on 16/3/9.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import "ViewController.h"
#define  kViewPages 5
@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageContrlol;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIImageView *zuoImage,*youImage,*centerImage;
@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation ViewController
-(UIScrollView *)scrollView
{
    if(_scrollView==nil)
    {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(20, 20, 280, 130)];
        _scrollView.backgroundColor=[UIColor redColor];
    }
    return _scrollView;
}
-(UIPageControl *)pageContrlol
{
    if(!_pageContrlol)
        _pageContrlol=[[UIPageControl alloc]initWithFrame:CGRectMake(150, 100, 60, 30)];
    _pageContrlol.numberOfPages=5;
    _pageContrlol.pageIndicatorTintColor=[UIColor blackColor];
    _pageContrlol.currentPageIndicatorTintColor=[UIColor orangeColor];
    return _pageContrlol;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageContrlol];
    
    self.scrollView.delegate=self;
    CGFloat imageY=0;
    CGFloat imageW=280;
    CGFloat imageH=130;
    for (int i=0; i<kViewPages; i++) {
        self.zuoImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, imageY, imageW, imageH)];
        self.zuoImage.image=[UIImage imageNamed:@"img_05"];
        self.centerImage=[[UIImageView alloc]initWithFrame:CGRectMake(imageW, imageY, imageW, imageH)];
        self.centerImage.image=[UIImage imageNamed:@"img_01"];
        self.youImage=[[UIImageView alloc]initWithFrame:CGRectMake(imageW*2, imageY, imageW, imageH)];
        self.youImage.image=[UIImage imageNamed:@"img_02"];
        
        [self.scrollView addSubview:self.zuoImage];
        [self.scrollView addSubview:self.youImage];
        [self.scrollView addSubview:self.centerImage];
        [self.scrollView setContentOffset:CGPointMake(imageW, 0) animated:NO];
    }
    self.pageContrlol.currentPage=0;
    self.scrollView.contentSize=CGSizeMake(3*imageW, imageH);
    [self.scrollView setPagingEnabled:YES];
    [self openTimer];
    
}
//定时器搞动画的时候也会进入此函数
//本质就是两个函数都改变了currenPage的值，所以currentPage显得跳的比较凌乱
-(void)openTimer
{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)closeTimer
{
    [self.timer invalidate];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageContrlol.currentPage=self.currentPage;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self nextImage];
}
-(void)nextImage
{
    NSInteger page=self.pageContrlol.currentPage;
    self.zuoImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"img_%02ld",(page-1+5)%5+1]];
    self.youImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"img_%02ld",page+1]];
    self.centerImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"img_%02ld",(page+1)%5+1]];
    self.scrollView.contentOffset=CGPointMake(self.scrollView.frame.size.width*2, 0);
        CGPoint offset=CGPointMake(self.scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:offset animated:YES];
    self.currentPage=(self.pageContrlol.currentPage+1)%5;
}

@end
