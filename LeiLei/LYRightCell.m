//
//  LYRightCell.m
//  LeiLei
//
//  Created by liyi on 16/5/2.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import "LYRightCell.h"
#import "UIImageView+WebCache.h"
@interface LYRightCell ()

@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@end

@implementation LYRightCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRightModel:(LYRightModel *)rightModel {
    
    _rightModel = rightModel;
    /**
     *   [_leftImageView sd_setImageWithURL:[NSURL URLWithString:leftName]placeholderImage:[UIImage imageNamed:@"桌面"] options:SDWebImageLowPriority | SDWebImageRetryFailed | SDWebImageProgressiveDownload]
     */
//    NSLog(@"%@", _rightModel.imgView);
    [_rightImage sd_setImageWithURL:[NSURL URLWithString:rightModel.ImgView]placeholderImage:[UIImage imageNamed:@"桌面"] options:SDWebImageLowPriority | SDWebImageRetryFailed | SDWebImageProgressiveDownload];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
