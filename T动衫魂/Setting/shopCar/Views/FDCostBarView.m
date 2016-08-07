//
//  FDCostBarView.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDCostBarView.h"

@interface FDCostBarView()


@property (nonatomic, strong) UIButton *confireBtn;   //确定
@property (nonatomic, strong) UILabel *priceLab; //价格


@end


@implementation FDCostBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    self.backgroundColor = kRoseColor;
    __weak typeof(self) _weakSelf = self;
    
    _checkBoxBtn = [[UIButton alloc] init];
    [self addSubview:_checkBoxBtn];
    _checkBoxBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_checkBoxBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_checkBoxBtn setImage:[UIImage imageNamed:@"check_box"] forState:UIControlStateNormal];
    [_checkBoxBtn setImage:[UIImage imageNamed:@"check_box_on"] forState:UIControlStateSelected];
    [_checkBoxBtn setTitle:@"全选" forState:UIControlStateNormal];
    _checkBoxBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    [_checkBoxBtn addTarget:self action:@selector(goodsDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_checkBoxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_weakSelf).offset(10);
        make.bottom.mas_equalTo(_weakSelf).offset(-10);
        make.width.mas_equalTo(100);
    }];
    
    _confireBtn = [[UIButton alloc] init];
    [self addSubview:_confireBtn];
    _confireBtn.layer.borderColor = kWhiteColor.CGColor;
    _confireBtn.layer.borderWidth = 1;
    _confireBtn.layer.cornerRadius = 4;
    _confireBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_confireBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_confireBtn setTitle:@"确定下单" forState:UIControlStateNormal];
    [_confireBtn addTarget:self action:@selector(gotoCostBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_confireBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_weakSelf.mas_right).offset(-25);
        make.top.mas_equalTo(_weakSelf).offset(10);
        make.bottom.mas_equalTo(_weakSelf).offset(-10);
        make.width.mas_equalTo(60);
    }];
    
    
    _priceValueLab = [[UILabel alloc] init];
    [self addSubview:_priceValueLab];
    _priceValueLab.font = [UIFont systemFontOfSize:12];
    _priceValueLab.textColor = kWhiteColor;
    _priceValueLab.text = @"￥0.00";
    [_priceValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_weakSelf);
        make.width.mas_equalTo(60);
        make.right.mas_equalTo(_confireBtn.mas_left).offset(-10);
    }];
    
    _priceLab = [[UILabel alloc] init];
    [self addSubview:_priceLab];
    _priceLab.font = [UIFont systemFontOfSize:11];
    _priceLab.textColor = kWhiteColor;
    _priceLab.text = @"合计";
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_weakSelf.priceValueLab.mas_left).offset(-3);
        make.top.bottom.mas_equalTo(_weakSelf);
    }];
    
}
//全选框
- (void)goodsDidSelect:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (self.selectDidClick) {
        self.selectDidClick(btn.selected);
    }
    
}
//下单
- (void)gotoCostBtnDidClick:(UIButton *)btn
{
    if (self.costSumDidClick) {
        self.costSumDidClick();
    }
    
}

@end
