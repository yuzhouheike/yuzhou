//
//  LYHeaderView.h
//  LeiLei
//
//  Created by liyi on 16/4/28.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol headerViewDelegate <NSObject>

@required

- (void)pushToLoginController;

@end

@interface LYHeaderView : UIView
@property(nonatomic,weak) id<headerViewDelegate> delegate;


@end
