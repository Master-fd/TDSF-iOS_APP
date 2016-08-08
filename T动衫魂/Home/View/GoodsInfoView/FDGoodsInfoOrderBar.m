//
//  FDGoodsInfoOrderBar.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDGoodsInfoOrderBar.h"

@interface FDGoodsInfoOrderBar(){
    
    UIButton *_infoBtn;
    
    UIButton *_remarkBtn;
    
}

@end


@implementation FDGoodsInfoOrderBar


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
    self.backgroundColor = kFrenchGreyColor;
    
    _infoBtn = [[UIButton alloc] init];
    [self addSubview:_infoBtn];
    _infoBtn.layer.borderColor = [UIColor colorWithRed:191/255.0 green:200/255.0 blue:113/255.0 alpha:1].CGColor;
    _infoBtn.layer.borderWidth = 0.5;
    _infoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_infoBtn setBackgroundColor:[UIColor clearColor]];
    [_infoBtn setTitle:@"我的购物车" forState:UIControlStateNormal];
    [_infoBtn setTitleColor:kRoseColor forState:UIControlStateNormal];
    [_infoBtn addTarget:self action:@selector(infoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _remarkBtn = [[UIButton alloc] init];
    [self addSubview:_remarkBtn];
    _remarkBtn.layer.borderColor = [UIColor colorWithRed:191/255.0 green:200/255.0 blue:113/255.0 alpha:1].CGColor;
    _remarkBtn.layer.borderWidth = 0.5;
    _remarkBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_remarkBtn setBackgroundColor:[UIColor clearColor]];
    [_remarkBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [_remarkBtn setTitleColor:kRoseColor forState:UIControlStateNormal];
    [_remarkBtn addTarget:self action:@selector(remarkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf);
        make.left.equalTo(_weakSelf);
        make.height.equalTo(@50);
        make.width.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/2]);
    }];
    
    [_remarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf);
        make.left.equalTo(_infoBtn.mas_right);
        make.height.equalTo(@50);
        make.width.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/2]);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_infoBtn.mas_bottom);
    }];
}


- (void)infoBtnClick
{\
    if (self.gotoBtnDidClickBlock) {
        self.gotoBtnDidClickBlock();
    }
}

- (void)remarkBtnClick
{
    if (self.payBtnDidClickBlock) {
        self.payBtnDidClickBlock();
    }
}
@end
