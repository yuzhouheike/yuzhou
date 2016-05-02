//
//  LYTimeLimitShopController.m
//  LeiLei
//
//  Created by liyi on 16/4/28.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import "LYTimeLimitShopController.h"
#import "SXTHeadView.h"
#import "AFNetworking.h"
#import "CycleModel.h"
#import "MJExtension.h"
#import "LYTwoButtonView.h"
//#import "LYLeftCell.h"
//#import "LYleftModel.h"

static NSString *cellID = @"cellID";
static NSString *leftCellID = @"leftCellID";
static NSString *rightCellID = @"rightCellID";

#define isLeftButton self.twoButtonView.leftButton.selected

@interface LYTimeLimitShopController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SXTHeadView *headImage;

@property (nonatomic, strong) LYTwoButtonView *twoButtonView;

@property (nonatomic, strong) NSArray *leftArray;

@property (nonatomic, strong) NSArray *rightArray;


@end

@implementation LYTimeLimitShopController

- (LYTwoButtonView *)twoButtonView {
    if (!_twoButtonView) {
        _twoButtonView = [[LYTwoButtonView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
        
        [_twoButtonView.leftButton addTarget:self action:@selector(twoButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
        [_twoButtonView.rightButton addTarget:self action:@selector(twoButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    }

    return _twoButtonView;
}

- (SXTHeadView *)headImage {
    
    if (!_headImage) {
        _headImage = [[SXTHeadView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 230)];

    }
    
    return _headImage;
}

- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        /**
         LYScrollView *scrollView = [[LYScrollView alloc]init];
         _tableView.tableHeaderView = scrollView;

         */
        /**
         *  加载tableView
         */
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
//        [_tableView registerClass: forCellReuseIdentifier:<#(nonnull NSString *)#>]
        
        [_tableView registerNib:[UINib nibWithNibName:@"LYLeftCell" bundle:nil] forCellReuseIdentifier:leftCellID];
//        _tableView 
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headImage;
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem.image=[UIImage imageNamed:@"限时特卖界面搜索按钮"];
    
    [self.tableView setSectionHeaderHeight:50];
    
    self.tableView.tableHeaderView = self.headImage;
//    [self.view addSubview:self.headImage];
    [self getData];
}

#pragma uitableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return 30;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UIView *view = [[UIView alloc] init];
//    
//    view.backgroundColor = [UIColor redColor];
//    
//    view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100);
//    
//    
//    return view;
    
    return self.twoButtonView;
    
}

- (void)twoButtonMethod:(UIButton *)button {
    
    NSLog(@"%@", button.titleLabel.text);
    
//    self.twoButtonView.leftButton.selected = !self.twoButtonView.leftButton.selected;
//    self.twoButtonView.rightButton.selected = !self.twoButtonView.rightButton.selected;
    
    if (button == self.twoButtonView.leftButton) {
        
        self.twoButtonView.leftButton.selected = YES;
        self.twoButtonView.rightButton.selected = NO;
    } else {
        
        self.twoButtonView.leftButton.selected = NO;
        self.twoButtonView.rightButton.selected = YES;
    }
 
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isLeftButton) {
        return 100;
    }
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /**
     *  限时特卖轮播图 数据
     */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
//    if (self.twoButtonView.leftButton.selected) {
//        
//        LYLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellID];
//        return cell;
//    } else {
//       
//        return cell;
//    }
    
    
    return cell;
}

- (void)getData {
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [manger GET:@"http://123.57.141.249:8080/beautalk/appHome/appHome.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@ haha", responseObject);
        
//        NSArray *cycelModelArray = [CycleModel mj_objectArrayWithKeyValuesArray:responseObject];
//        
//        NSLog(@"%@", cycelModelArray);
//        
//        NSMutableArray *mutableModelarray = [NSMutableArray array];
//        
//        for (CycleModel *model  in cycelModelArray) {
//            
//            [mutableModelarray addObject:model.ImgView];
//        }
//        
//        self.headImage.dataList = [NSArray arrayWithArray:mutableModelarray];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ error", error);
    }];

    /**
     * 首页单品团购
     */

//    [ manger GET:@"http://123.57.141.249:8080/beautalk/appActivity/appHomeGoodsList.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"%@", responseObject);
//        
//        NSArray *leftModelArray = [LYleftModel mj_objectArrayWithKeyValuesArray:responseObject];
//        
//        NSMutableArray *mutableLeftModelArray = [NSMutableArray array];
//        
//        
//        for (LYleftModel *model in leftModelArray) {
//            
//            [mutableLeftModelArray addObject:model];
//        }
//        
//        [self.leftArray arrayByAddingObjectsFromArray:mutableLeftModelArray];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
    
    [manger GET:@"http://123.57.141.249:8080/beautalk/appActivity/appHomeGoodsList.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
}

@end
