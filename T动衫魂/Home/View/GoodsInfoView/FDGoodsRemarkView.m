//
//  FDGoodsRemarkView.m
//  T动衫魂
//
//  Created by asus on 16/5/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDGoodsRemarkView.h"
#import "FDGoodsModel.h"

@interface FDGoodsRemarkView(){
    
    UIImageView *_remarkImageView;
}

@end
@implementation FDGoodsRemarkView


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
    _remarkImageView = [[UIImageView alloc] init];
    [self addSubview:_remarkImageView];
    _remarkImageView.backgroundColor = [UIColor clearColor];
}

- (void)setupContraints
{
    [_remarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width*2]);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_remarkImageView.mas_bottom);
    }];
}

- (void)setModel:(FDGoodsModel *)model
{
    _model = model;
    
    [_remarkImageView sd_setImageWithURL:[NSURL URLWithString:model.remarkImageUrl] placeholderImage:[UIImage imageNamed:@"defult_placeholder"]];
}

@end









