//
//  FDGoodInfoBarView.m
//  T动衫魂
//
//  Created by asus on 16/5/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDGoodInfoBarView.h"

@interface FDGoodInfoBarView(){
    
    UIButton *_infoBtn;
    
    UIButton *_remarkBtn;
    
}

@end


@implementation FDGoodInfoBarView


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
    self.backgroundColor = kWhiteColor;
    
    _infoBtn = [[UIButton alloc] init];
    [self addSubview:_infoBtn];
    _infoBtn.layer.borderColor = kFrenchGreyColor.CGColor;
    _infoBtn.layer.borderWidth = 1;
    _infoBtn.selected = YES;
    _infoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_infoBtn setBackgroundColor:[UIColor clearColor]];
    [_infoBtn setTitle:@"商品详情" forState:UIControlStateNormal];
    [_infoBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_infoBtn setTitleColor:kRoseColor forState:UIControlStateSelected];
    [_infoBtn addTarget:self action:@selector(infoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _remarkBtn = [[UIButton alloc] init];
    [self addSubview:_remarkBtn];
    _remarkBtn.layer.borderColor = kFrenchGreyColor.CGColor;
    _remarkBtn.layer.borderWidth = 1;
    _remarkBtn.selected = NO;
    _remarkBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_remarkBtn setBackgroundColor:[UIColor clearColor]];
    [_remarkBtn setTitle:@"购买说明" forState:UIControlStateNormal];
    [_remarkBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_remarkBtn setTitleColor:kRoseColor forState:UIControlStateSelected];
    [_remarkBtn addTarget:self action:@selector(remarkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
    [_infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf);
        make.left.equalTo(_weakSelf);
        make.height.equalTo(@44);
        make.width.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/2]);
    }];
    
    [_remarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf);
        make.left.equalTo(_infoBtn.mas_right);
        make.height.equalTo(@44);
        make.width.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/2]);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_infoBtn.mas_bottom);
    }];
}


- (void)infoBtnClick
{
    _infoBtn.selected = YES;
    _remarkBtn.selected = NO;
    
    if (self.infoBtnClickBlock) {
        self.infoBtnClickBlock();
    }
}

- (void)remarkBtnClick
{
    _remarkBtn.selected = YES;
    _infoBtn.selected = NO;
    
    if (self.remarkBtnClickBlock) {
        self.remarkBtnClickBlock();
    }
}

@end
