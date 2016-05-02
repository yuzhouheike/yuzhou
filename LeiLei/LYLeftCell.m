//
//  LYLeftCell.m
//  LeiLei
//
//  Created by liyi on 16/5/2.
//  Copyright © 2016年 liyi. All rights reserved.
//

#import "LYLeftCell.h"
#import "UIImageView+WebCache.h"
@interface LYLeftCell ()

@property (weak, nonatomic) IBOutlet UIImageView *countryImage;

@property (weak, nonatomic) IBOutlet UIImageView *ImgView;

@property (weak, nonatomic) IBOutlet UILabel *GoodsIntro;

@property (weak, nonatomic) IBOutlet UILabel *ForeignPrice;

@property (weak, nonatomic) IBOutlet UILabel *Price;

@end

@implementation LYLeftCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setLeftModel:(LYleftModel *)leftModel {
    
    _leftModel = leftModel;
    _GoodsIntro.text = leftModel.GoodsIntro;
    _GoodsIntro.numberOfLines = 0;
    _ForeignPrice.text = [NSString stringWithFormat:@"原价:%@", leftModel.ForeignPrice];
    _ForeignPrice.font = [UIFont systemFontOfSize:12];
    _Price.font = [UIFont systemFontOfSize:13];
    _Price.text = [NSString stringWithFormat:@"现价:%@", leftModel.Price];

    
    [_ImgView sd_setImageWithURL:[NSURL URLWithString:leftModel.ImgView]];
    [_countryImage sd_setImageWithURL:[NSURL URLWithString:leftModel.CountryImg]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
