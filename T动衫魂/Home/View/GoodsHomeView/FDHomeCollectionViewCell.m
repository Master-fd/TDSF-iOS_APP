//
//  FDHomeCollectionViewCell.m
//  T动衫魂
//
//  Created by asus on 16/5/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDHomeCollectionViewCell.h"
#import "FDGoodsModel.h"



#define  marginMax     8
#define  marginMin     5

@interface FDHomeCollectionViewCell(){
    
    UIImageView *_imageView;
    UILabel *_nameLab;
    UILabel *_priceLab;
    UILabel *_priceValue;
}

@end

@implementation FDHomeCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
    _imageView.image = [UIImage imageNamed:@"defult_placeholder"];
    
    _nameLab = [[UILabel alloc] init];
    [self.contentView addSubview:_nameLab];
    _nameLab.backgroundColor = [UIColor clearColor];
    _nameLab.font = [UIFont systemFontOfSize:16];
    _nameLab.textColor = kBlackColor;
    
    _priceLab = [[UILabel alloc] init];
    [self.contentView addSubview:_priceLab];
    _priceLab.backgroundColor = [UIColor clearColor];
    _priceLab.text = @"￥";
    _priceLab.font = [UIFont boldSystemFontOfSize:13];
    _priceLab.textColor = kRoseColor;
    
    _priceValue = [[UILabel alloc] init];
    [self.contentView addSubview:_priceValue];
    _priceValue.backgroundColor = [UIColor clearColor];
    _priceValue.font = [UIFont boldSystemFontOfSize:17];
    _priceValue.textColor = kRoseColor;
}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf.contentView).with.offset(marginMax);
        make.left.equalTo(_weakSelf.contentView).with.offset(marginMax);
        make.right.equalTo(_weakSelf.contentView).with.offset(-marginMax);
        make.bottom.equalTo(_nameLab.mas_top).with.offset(-marginMax);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.contentView).with.offset(marginMin);
        make.right.equalTo(_weakSelf.contentView).with.offset(-marginMin);
        make.height.equalTo([NSNumber numberWithFloat:_nameLab.font.lineHeight]);
        make.bottom.equalTo(_priceValue.mas_top).with.offset(-marginMin);
    }];
    
    [_priceLab sizeToFit];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLab);
        make.bottom.equalTo(_weakSelf.contentView).with.offset(-marginMin);
    }];
    
    [_priceValue sizeToFit];
    [_priceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLab.mas_right).with.offset(marginMin);
        make.height.equalTo([NSNumber numberWithFloat:_priceLab.font.lineHeight]);
        make.bottom.equalTo(_weakSelf.contentView).with.offset(-marginMin);
    }];
}

- (void)setModel:(FDGoodsModel *)model
{
    _model = model;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.minImageUrl1] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
    _nameLab.text = model.name;
    _priceValue.text = model.price ? model.price:@"00.00";
}



@end





