//
//  LYHeaderView.m
//  LeiLei
//
//  Created by liyi on 16/4/28.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import "LYHeaderView.h"
#import "LYcollectController.h"
#import "LYLogInController.h"



@interface LYHeaderView ()

@property(nonatomic, strong)UIButton*login;
@property(nonatomic, strong)UIButton *enroll;


@end

@implementation LYHeaderView

- (UIButton *)login
{
    if(!_login)
    {
        _login = [[UIButton alloc] init];
        [_login addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
        [_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_login setTitle:@"登录" forState:UIControlStateNormal];
        
    }
    return _login;
}
- (UIButton *)enroll
{
    if(!_enroll)
    {
        _enroll = [[UIButton alloc] init];
        [_enroll addTarget:self action:@selector(enrollClicked) forControlEvents:UIControlEventTouchUpInside];
        [_enroll setTitle:@"注册" forState:UIControlStateNormal];
        [_enroll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
    return _enroll;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor colorWithRed:63/255.0 green:205/255.0 blue:231/255.0 alpha:1];
        [self addSubview:self.login];
        [self addSubview:self.enroll];
        self.frame = CGRectMake(0, 64, 375, 124);
        
    }
    
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.login.frame = CGRectMake(107.5, 55, 67.5, 30);
    self.enroll.frame = CGRectMake(215, 55, 67.5, 30);
    //self.login.backgroundColor=[UIColor redColor];
    //self.enroll.backgroundColor=[UIColor redColor];
    
}
- (void)loginClicked
{
    NSLog(@"点击登录");
    if ([self.delegate respondsToSelector:@selector(pushToLoginController)]) {
        [self.delegate pushToLoginController];
    }
    
//    [self]
    
}
- (void)enrollClicked
{
    NSLog(@"点击注册");
}
@end
