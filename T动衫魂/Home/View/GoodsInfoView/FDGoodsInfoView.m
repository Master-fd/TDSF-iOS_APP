//
//  FDGoodsInfoView.m
//  T动衫魂
//
//  Created by asus on 16/5/19.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDGoodsInfoView.h"
#import "FDGoodsModel.h"


@interface FDGoodsInfoView(){
    
    /**
     *  关于产品
     */
    UIImageView *_aboutImageview;
    
    /**
     *  商品细节图片，最多5个图片
     */
    UIImageView *_imageview1;
    UIImageView *_imageview2;
    UIImageView *_imageview3;
    UIImageView *_imageview4;
    UIImageView *_imageview5;
    
    /**
     *  尺码表
     */
    UIImageView *_sizeImageview;
    
}

@end



@implementation FDGoodsInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        
        [self setupContrints];
    }
    
    return self;
}


- (void)setupViews
{
    CGFloat lineWidth = 1.5;
    
    self.backgroundColor = kWhiteColor;
    
    _aboutImageview = [[UIImageView alloc] init];
    [self addSubview:_aboutImageview];
    _aboutImageview.backgroundColor = [UIColor clearColor];
    
    _imageview1 = [[UIImageView alloc] init];
    [self addSubview:_imageview1];
    _imageview1.backgroundColor = [UIColor clearColor];
    _imageview1.layer.borderColor = [UIColor yellowColor].CGColor;
    _imageview1.layer.borderWidth = lineWidth;
    
    _imageview2 = [[UIImageView alloc] init];
    [self addSubview:_imageview2];
    _imageview2.backgroundColor = [UIColor clearColor];
    _imageview2.layer.borderColor = [UIColor yellowColor].CGColor;
    _imageview2.layer.borderWidth = lineWidth;
    
    _imageview3 = [[UIImageView alloc] init];
    [self addSubview:_imageview3];
    _imageview3.backgroundColor = [UIColor clearColor];
    _imageview3.layer.borderColor = [UIColor yellowColor].CGColor;
    _imageview3.layer.borderWidth = lineWidth;
    
    _imageview4 = [[UIImageView alloc] init];
    [self addSubview:_imageview4];
    _imageview4.backgroundColor = [UIColor clearColor];
    _imageview4.layer.borderColor = [UIColor yellowColor].CGColor;
    _imageview4.layer.borderWidth = lineWidth;
    
    _imageview5 = [[UIImageView alloc] init];
    [self addSubview:_imageview5];
    _imageview5.backgroundColor = [UIColor clearColor];
    _imageview5.layer.borderColor = [UIColor yellowColor].CGColor;
    _imageview5.layer.borderWidth = lineWidth;
    
    _sizeImageview = [[UIImageView alloc] init];
    [self addSubview:_sizeImageview];
    _sizeImageview.backgroundColor = [UIColor clearColor];
    
}


- (void)setupContrints
{
    
    CGFloat margin = 5;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;  //屏幕宽度
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.width;  //屏幕高度
    NSNumber *height = [NSNumber numberWithFloat:screenWidth];
    __weak typeof(self) _weakSelf = self;
    [_aboutImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf);
        make.left.and.right.equalTo(_weakSelf);
        make.height.equalTo(height);
    }];
    
    [_imageview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_aboutImageview.mas_bottom).with.offset(margin);
        make.left.equalTo(_weakSelf).with.offset(margin);
        make.right.equalTo(_weakSelf).with.offset(-margin);
        make.height.equalTo([NSNumber numberWithFloat:screenWidth*4/5]);
    }];
    
    [_imageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageview1.mas_bottom).with.offset(margin);
        make.left.and.right.equalTo(_imageview1);
        make.height.equalTo(_imageview1);
    }];
    
    [_imageview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageview2.mas_bottom).with.offset(margin);
        make.left.and.right.equalTo(_imageview1);
        make.height.equalTo(_imageview1);
    }];
    
    [_imageview4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageview3.mas_bottom).with.offset(margin);
        make.left.and.right.equalTo(_imageview1);
        make.height.equalTo(_imageview1);
    }];
    
    [_imageview5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageview4.mas_bottom).with.offset(margin);
        make.left.and.right.equalTo(_imageview1);
        make.height.equalTo(_imageview1);
    }];
    
    [_sizeImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageview5.mas_bottom).with.offset(margin);
        make.left.and.right.equalTo(_weakSelf);
        make.height.equalTo([NSNumber numberWithFloat:screenHeight*2]);
    }];
    
    //约束自己，起到有一个高度
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_sizeImageview.mas_bottom).with.offset(margin);
    }];
    
}

- (void)setModel:(FDGoodsModel *)model
{
    _model = model;
    
    [_imageview1 sd_setImageWithURL:[NSURL URLWithString:model.descImageUrl1] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
    [_imageview2 sd_setImageWithURL:[NSURL URLWithString:model.descImageUrl2] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
    [_imageview3 sd_setImageWithURL:[NSURL URLWithString:model.descImageUrl3] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
    [_imageview4 sd_setImageWithURL:[NSURL URLWithString:model.descImageUrl4] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
    [_imageview5 sd_setImageWithURL:[NSURL URLWithString:model.descImageUrl5] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
    
    [_aboutImageview sd_setImageWithURL:[NSURL URLWithString:model.aboutImageUrl] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
    [_sizeImageview sd_setImageWithURL:[NSURL URLWithString:model.sizeImageUrl] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
}


@end




































