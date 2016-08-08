//
//  FDConfirmOrderBarView.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDConfirmOrderBarView.h"


@interface FDConfirmOrderBarView()


@property (nonatomic, strong) UIButton *confireBtn;   //确定
@property (nonatomic, strong) UILabel *priceLab; //价格

@property (nonatomic, strong) UILabel *priceValueLab;

@end


@implementation FDConfirmOrderBarView

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
    
    _confireBtn = [[UIButton alloc] init];
    [self addSubview:_confireBtn];
    _confireBtn.layer.borderColor = kWhiteColor.CGColor;
    _confireBtn.layer.borderWidth = 1;
    _confireBtn.layer.cornerRadius = 4;
    _confireBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_confireBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_confireBtn setTitle:@"确认订单" forState:UIControlStateNormal];
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

//下单
- (void)gotoCostBtnDidClick:(UIButton *)btn
{
    if (self.costSumDidClick) {
        self.costSumDidClick();
    }
}
- (void)setSumPrice:(CGFloat )sumPrice
{
    _sumPrice = sumPrice;
    _priceValueLab.text = [NSString stringWithFormat:@"￥%0.02f", sumPrice];
}

@end
