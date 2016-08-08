//
//  FDStatusBarView.m
//  T动衫魂
//
//  Created by asus on 16/8/8.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDStatusBarView.h"

@interface FDStatusBarView()


@property (nonatomic, strong) UILabel *statusLab;   //确定
@property (nonatomic, strong) UILabel *priceLab; //价格

@property (nonatomic, strong) UILabel *priceValueLab;

@end


@implementation FDStatusBarView

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
    
    _statusLab = [[UILabel alloc] init];
    [self addSubview:_statusLab];
    _statusLab.font = [UIFont boldSystemFontOfSize:12];
    _statusLab.textColor = kWhiteColor;
    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.right.mas_equalTo(_statusLab.mas_left).offset(-10);
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

- (void)setSumPrice:(CGFloat )sumPrice
{
    _sumPrice = sumPrice;
    _priceValueLab.text = [NSString stringWithFormat:@"￥%0.02f", sumPrice];
}
- (void)setStatus:(NSString *)status
{
    _status = status;
    _statusLab.text = status;
}


@end
