//
//  LYTwoButtonView.m
//  LeiLei
//
//  Created by liyi on 16/5/1.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import "LYTwoButtonView.h"

@implementation LYTwoButtonView





- (instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame ]) {
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
    }
    
    return self;
}


- (UIButton *)leftButton {
    
    if (!_leftButton ) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setTitle:@"新品团购" forState:UIControlStateNormal];
        [_leftButton setTitle:@"新品团购" forState:UIControlStateHighlighted];
        [_leftButton setTitle:@"新品团购" forState:UIControlStateSelected];
//        
//        [_leftButton setTitleColor:[RGB(0,181,248) ]forState:UIControlStateNormal];
        
      
        [_leftButton setTitleColor:[UIColor colorWithRed:0 / 255.0 green:181 /255.0 blue:248 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"新品团未选中"] forState:UIControlStateNormal];
        _leftButton.selected = YES;
        
        
        
        [_leftButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:83 /255.0 blue:46 / 255.0 alpha:1.0] forState:UIControlStateSelected];
        [_leftButton setImage:[UIImage imageNamed:@"新品团选中"] forState:UIControlStateSelected];
        
        _leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);

        
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        [_rightButton setTitle:@"品牌团购" forState:UIControlStateNormal];
        [_rightButton setTitle:@"品牌团购" forState:UIControlStateSelected];
    
        [_rightButton setTitleColor:[UIColor colorWithRed:0 / 255.0 green:181 /255.0 blue:248 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"品牌团未选中"] forState:UIControlStateNormal];
        
        
        [_rightButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:83 /255.0 blue:46 / 255.0 alpha:1.0] forState:UIControlStateSelected];
        [_rightButton setImage:[UIImage imageNamed:@"品牌团选中"] forState:UIControlStateSelected];
        
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);

    }
    
    return _rightButton;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _leftButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds));
    

    _rightButton.frame = CGRectMake(CGRectGetMaxX(_leftButton.bounds), 0, CGRectGetWidth(_leftButton.bounds), CGRectGetHeight(_leftButton.bounds));

    
    
}

@end
