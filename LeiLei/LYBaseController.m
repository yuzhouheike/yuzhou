//
//  LYBaseController.m
//  LeiLei
//
//  Created by liyi on 16/4/28.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import "LYBaseController.h"
#import "LYTimeLimitShopController.h"
#import "LYCategoryViewController.h"
#import "LYMyController.h"
#import "LYShoppingCarController.h"
@interface LYBaseController ()

@end

@implementation LYBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem = [UITabBarItem appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithRed:56/255.0 green:166/255.0 blue:238/255.0 alpha:1];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_back"];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"nav_backImage"];
    self.navigationController.navigationBar.alpha=0;
    
    [self.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];

    
    [self setUpChildController:@"LYTimeLimitShopController" title:@"限时购" image:@"菜单栏限时特卖按钮未选中状态" selectedImage:@"菜单栏限时特卖按钮选中状态"];
    
    [self setUpChildController:@"LYCategoryViewController" title:@"分类" image:@"菜单栏分类按钮未选中状态" selectedImage:@"菜单栏分类按钮选中状态"];
    
    [self setUpChildController:@"LYShoppingCarController" title:@"购物车" image:@"菜单栏购物车按钮未选中状态" selectedImage:@"菜单栏购物车按钮选中状态"];
    
    [self setUpChildController:@"LYMyController" title:@"我的" image:@"菜单栏我的按钮未选中状态" selectedImage:@"菜单栏我的按钮选中状态"];
    
    //self.view.backgroundColor = [UIColor greenColor];
}
- (void)setUpChildController: (NSString *)controller  title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
  
    UIViewController *viewController =  [[NSClassFromString(controller) alloc] init];
    viewController.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.navigationItem.title=@"磊易联盟";
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    viewController.view.backgroundColor =[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:navigationController];
    
    
}
@end
