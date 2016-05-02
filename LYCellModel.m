//
//  LYCellModel.m
//  LeiLei
//
//  Created by liyi on 16/4/28.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import "LYCellModel.h"

@implementation LYCellModel
+ (instancetype) cellModelWithDict:(NSDictionary *) dict {
    
    return [[self alloc]initWithDict:dict];
}

- (instancetype) initWithDict:(NSDictionary *) dict {
    
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (NSArray *)dataList {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"my" ofType:@"plist"];
    
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        LYCellModel *cellModel = [LYCellModel cellModelWithDict:dict];
        
        [mutableArray addObject:cellModel];
    }
    
    return mutableArray;
}

@end
