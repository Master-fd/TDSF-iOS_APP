//
//  FDAblumCollectionViewCell.m
//  MSTVTool
//
//  Created by asus on 16/6/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAblumCollectionViewCell.h"
#import "FDGroupModel.h"



@interface FDAblumCollectionViewCell(){
    
    UIImageView *_imageView;
    UILabel *_nameLab;
    UILabel *_numLab;
    UIView *_gapView;
}

@end

@implementation FDAblumCollectionViewCell

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
    self.contentView.backgroundColor = kWhiteColor;
    
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    _nameLab = [[UILabel alloc] init];
    [self addSubview:_nameLab];
    _nameLab.numberOfLines = 0;
    _nameLab.textColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1];
    _nameLab.font = [UIFont systemFontOfSize:13];
    
    _numLab = [[UILabel alloc] init];
    [self.contentView addSubview:_numLab];
    _numLab.numberOfLines = 0;
    _numLab.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    _numLab.font = [UIFont systemFontOfSize:13];
    
    _gapView = [[UIView alloc] init];
    [self.contentView addSubview:_gapView];
    _gapView.backgroundColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1];
    
}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
   
    [_nameLab sizeToFit];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf).with.offset(7);
        make.left.equalTo(_weakSelf).with.offset(10);
    }];
    
    [_gapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.mas_top).with.offset(2);
        make.left.equalTo(_nameLab.mas_right).with.offset(8);
        make.width.equalTo(@0.5);
        make.bottom.equalTo(_nameLab.mas_bottom).with.offset(-2);
    }];
    
    [_numLab sizeToFit];
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.mas_top);
        make.left.equalTo(_gapView.mas_right).with.offset(8);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.mas_bottom).with.offset(10);
        make.left.equalTo(_weakSelf).with.offset(7);
        make.right.equalTo(_weakSelf.mas_right).with.offset(-7);
        make.bottom.equalTo(_weakSelf).with.offset(-7);
    }];
    
    
}

- (void)setModel:(FDGroupModel *)model
{
    _model = model;
    
    _nameLab.text = model.groupName;
    _numLab.text = [NSString stringWithFormat:@"%ld", model.assetsCount];
    _imageView.image = model.thumbImage;
    
}
@end
