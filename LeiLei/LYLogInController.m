//
//  LYLogInController.m
//  LeiLei
//
//  Created by liyi on 16/4/29.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import "LYLogInController.h"

@interface LYLogInController ()

@property(nonatomic, strong)UITextField *phoneNumber;
@property(nonatomic, strong)UITextField *psd;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UIButton *QQButton;
@property(nonatomic,strong)UIButton *WeiXinButton;
@property(nonatomic,strong)UIButton *WeiBoButton;

@end

@implementation LYLogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.phoneNumber];
    [self.view addSubview:self.psd];
    [self.view addSubview:self.QQButton];
    [self.view addSubview:self.WeiXinButton];
    [self.view addSubview:self.WeiBoButton];
    LYLog(@"has come to login controller");  
    self.view.backgroundColor=globleColor;
    
}

- (UIButton *)QQButton
{
    if(!_QQButton)
    {
        _QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _QQButton.frame = CGRectMake(60, 254.5, 45, 45);
        
        [_QQButton setBackgroundImage:[UIImage imageNamed:@"登录界面qq登陆" ] forState:UIControlStateNormal];
    }
    return _QQButton;
}
- (UIButton *)WeiXinButton
{
    if(!_WeiXinButton)
    {
        _WeiXinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _WeiXinButton.frame = CGRectMake(165, 254.5, 45, 45);
        
        [_WeiXinButton setBackgroundImage:[UIImage imageNamed:@"登录界面微信登录" ] forState:UIControlStateNormal];
    }
    return _WeiXinButton;
}
- (UIButton *)WeiBoButton
{
    if(!_WeiBoButton)
    {
        _WeiBoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _WeiBoButton.frame = CGRectMake(270, 254.5, 45, 45);
        
        [_WeiBoButton setBackgroundImage:[UIImage imageNamed:@"登陆界面微博登录" ] forState:UIControlStateNormal];
    }
    return _WeiBoButton;
}
- (UITextField *)phoneNumber
{
    if(!_phoneNumber)
    {
        _phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)];
        _phoneNumber.backgroundColor=[UIColor whiteColor];
        _phoneNumber.placeholder=@"请输入手机号码";
       // _phoneNumber.placeholder.
        //怎么设置placeholder在中间
        //两个textView之间如何设置横线
        _phoneNumber.contentMode= UIViewContentModeCenter;
    }
    return _phoneNumber;
}
- (UITextField *)psd
{
    if(!_psd)
    {
        _psd = [[UITextField alloc]initWithFrame:CGRectMake(0, 109, [UIScreen mainScreen].bounds.size.width, 44)];
         _psd.backgroundColor=[UIColor whiteColor];
        _psd.placeholder=@"请输入密码";
    }
    return _psd;
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
