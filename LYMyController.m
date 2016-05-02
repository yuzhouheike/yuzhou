//
//  LYMyController.m
//  LeiLei
//
//  Created by liyi on 16/4/28.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import "LYMyController.h"
#import "LYCellModel.h"
#import "LYMyController.h"
#import "LYHeaderView.h"
#import "LYLogInController.h"
#define ID @"Cell"
@interface LYMyController ()<UITableViewDelegate, UITableViewDataSource,headerViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *cellModels;


@end

@implementation LYMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];

    LYHeaderView *header = [[LYHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    header.delegate=self;
    self.tableView.tableHeaderView = header;
    
    [self cellModels];
    
}
- (NSArray *) cellModels
{
    if(!_cellModels)
    {
        
        _cellModels = [LYCellModel dataList];
        
    }
    
    return _cellModels;
}
- (UITableView *) tableView {
    
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];

        _tableView.dataSource = self;
        
        _tableView.delegate = self;
        

    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYCellModel *cellModel = self.cellModels[indexPath.row];
    NSLog(@"%@", cellModel.title);
    if(indexPath.row == 3)
    {
//        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"15004525416"];
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"15004525416"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
//        [callWebview release];
//        [str release];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
   
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    LYCellModel *cellModel = self.cellModels[indexPath.row];
    cell.textLabel.text = cellModel.title;
    cell.imageView.image = [UIImage imageNamed:cellModel.image];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(indexPath.row == 3)
    {
      
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        
        cell.detailTextLabel.text = @"15004525416";
//        cell.backgroundColor = [UIColor redColor];

        
    }
    return cell;
    
}

- (void)pushToLoginController
{
    LYLogInController * loginController = [[LYLogInController alloc]init];
    [self.navigationController pushViewController:loginController animated:YES];
}

@end
