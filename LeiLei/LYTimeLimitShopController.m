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
#import "LYRightModel.h"
#import "LYRightCell.h"
#import "LYLeftCell.h"
#import "LYleftModel.h"

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
         *  加载tableView
         */
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        /**
         *  注册左边的cell
         */
//        [_tableView registerNib:[UINib nibWithNibName:@"LYLeftCell" bundle:nil] forCellReuseIdentifier:leftCellID];
//        [_tableView registerNib:[UINib nibWithNibName:@"LYLeftCell" bundle:nil] forCellReuseIdentifier:@"leftcellID"];
        /**
         *  注册右边的cell
         */
        
        [_tableView registerNib:[UINib nibWithNibName:@"LYRightCell" bundle:nil] forCellReuseIdentifier:rightCellID];
        
        [_tableView registerNib:[UINib nibWithNibName:@"LYLeftCell" bundle:nil] forCellReuseIdentifier:@"leftcellID"];
        
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
    //添加轮播图为tableView 的头
    self.tableView.tableHeaderView = self.headImage;

    [self getData];
    
    
//    [self twoButtonMethod:self.twoButtonView.leftButton];
}

#pragma mark － tableView 的dataSource方法



- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    if (isLeftButton) {
        return self.leftArray.count;
    }
    return self.rightArray.count;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.twoButtonView;
    
}
#pragma mark - 两个按钮的方法

- (void)twoButtonMethod:(UIButton *)button {
    
    NSLog(@"%@", button.titleLabel.text);

    
    if (button == self.twoButtonView.leftButton) {
        
        self.twoButtonView.leftButton.selected = YES;
        self.twoButtonView.rightButton.selected = NO;
    } else {
        
        self.twoButtonView.leftButton.selected = NO;
        self.twoButtonView.rightButton.selected = YES;
    }
 
    [self.tableView reloadData];
}


#pragma mark tableView 的行高

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isLeftButton) {
        return 200;
    }
    return 175;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /**
     *  cell 的数据
     */
 
    if (isLeftButton) {

        LYLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftcellID"];
        cell.leftModel = self.leftArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
       
        LYRightCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCellID];
        
        LYRightModel *model = self.rightArray[indexPath.row];
        
        cell.rightModel = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
  
}

#pragma mark - 从网络获取数据

- (void)getData {
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [manger GET:@"http://123.57.141.249:8080/beautalk/appHome/appHome.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *cycelModelArray = [CycleModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        NSMutableArray *mutableModelarray = [NSMutableArray array];
        
        for (CycleModel *model  in cycelModelArray) {
            
            [mutableModelarray addObject:model.ImgView];
        }
        
        self.headImage.dataList = [NSArray arrayWithArray:mutableModelarray];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ error", error);
    }];

    /**
     * 首页单品团购
     */

    [ manger GET:@"http://123.57.141.249:8080/beautalk/appActivity/appHomeGoodsList.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@", responseObject);
        
        self.leftArray = [LYleftModel mj_objectArrayWithKeyValuesArray:responseObject];
        NSLog(@"%@", self.leftArray);
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    /**
     *首页右边的图
     */
    
    [manger GET:@"http://123.57.141.249:8080/beautalk/appActivity/appActivityList.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@", responseObject);
        
        self.rightArray = [LYRightModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        NSLog(@"%@", error);
    }];
}

#pragma mark - 每一行cell选中后的方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", @(indexPath.row));
    
}

@end
