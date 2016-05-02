//
//  LYCellModel.h
//  LeiLei
//
//  Created by liyi on 16/4/28.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYCellModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

+ (instancetype) cellModelWithDict:(NSDictionary *) dict;

- (instancetype) initWithDict:(NSDictionary *) dict;

+ (NSArray *) dataList ;

@end
