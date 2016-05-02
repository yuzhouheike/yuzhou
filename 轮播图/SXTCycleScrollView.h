//
//  SXTCycleScrollView.h
//  新闻展示
//
//  Created by 大欢 on 16/3/1.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CycleBlock)(NSInteger);

@class SXTCycleScrollView;

@protocol SXTCycleScrollViewDelegate <NSObject>

- (void)cycleScrollView:(SXTCycleScrollView *)scrollView currentPage:(NSInteger)currentPage;

@end

@interface SXTCycleScrollView : UIScrollView

@property (nonatomic, strong) NSArray * dataList;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger totalPage;

@property (nonatomic, weak) id<SXTCycleScrollViewDelegate> cycleDelegate;

@property (nonatomic, copy) CycleBlock block;

- (void)loadData;

@end
