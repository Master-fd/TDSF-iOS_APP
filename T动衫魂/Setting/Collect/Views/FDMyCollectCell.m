//
//  FDMyCollectCell.m
//  T动衫魂
//
//  Created by asus on 16/5/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyCollectCell.h"
#import "FDGoodsModel.h"





@interface FDMyCollectCell(){
    
    UIImageView *_imageView;
    UIImageView *_arrowImageView;
    UILabel *_nameLab;
    UILabel *_priceLab;
    UILabel *_priceValue;
}

@end

@implementation FDMyCollectCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupViews];
        
        [self setupContraints];
    }
    
    return self;
}
- (void)setupViews
{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    _imageView.backgroundColor = [UIColor clearColor];
    
    _nameLab = [[UILabel alloc] init];
    [self.contentView addSubview:_nameLab];
    _nameLab.backgroundColor = [UIColor clearColor];
    _nameLab.font = [UIFont systemFontOfSize:17];
    _nameLab.textColor = kBlackColor;
    
    _priceLab = [[UILabel alloc] init];
    [self.contentView addSubview:_priceLab];
    _priceLab.backgroundColor = [UIColor clearColor];
    _priceLab.text = @"￥";
    _priceLab.font = [UIFont boldSystemFontOfSize:14];
    _priceLab.textColor = kRoseColor;
    
    _priceValue = [[UILabel alloc] init];
    [self.contentView addSubview:_priceValue];
    _priceValue.backgroundColor = [UIColor clearColor];
    _priceValue.font = [UIFont boldSystemFontOfSize:16];
    _priceValue.textColor = kRoseColor;
    
    _arrowImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_arrowImageView];
    _arrowImageView.backgroundColor = [UIColor clearColor];
    _arrowImageView.image = [UIImage imageNamed:@"AlbumTimeLineTipArrow"];
}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.contentView).with.offset(5);
        make.width.equalTo(_imageView.mas_height);
        make.top.equalTo(_weakSelf.contentView.mas_top).with.offset(5);
        make.bottom.equalTo(_weakSelf.contentView.mas_bottom).with.offset(-5);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_right).with.offset(10);
        make.right.equalTo(_weakSelf.contentView).with.offset(-50);
        make.top.equalTo(_imageView.mas_top).with.offset(7);
    }];
    
    [_priceLab sizeToFit];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLab);
        make.bottom.equalTo(_imageView.mas_bottom).with.offset(-7);
    }];
    
    [_priceValue sizeToFit];
    [_priceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLab.mas_right).with.offset(5);
        make.bottom.equalTo(_priceLab.mas_bottom);
    }];
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.centerY.equalTo(_weakSelf.contentView);
        make.right.equalTo(_weakSelf.mas_right).with.offset(-10);
    }];
}




- (void)setModel:(FDGoodsModel *)model
{
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.minImageUrl1] placeholderImage:[UIImage imageNamed:@"icon_AboutMeMax"] options:SDWebImageProgressiveDownload];
    
    _nameLab.text = model.name;
    _priceValue.text = model.price ? model.price:@"00.00";
    
    
}
@end
