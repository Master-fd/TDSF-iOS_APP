//
//  FDAddressCell.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAddressCell.h"
#import "FDAddressModel.h"



@interface FDAddressCell(){
    
    UILabel *_nameLab;
    UILabel *_numberLab;
    UILabel *_addressLab;
}

@property (nonatomic, strong) UIButton *defaultsBtn;
@end

@implementation FDAddressCell


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
    
    
    _nameLab = [[UILabel alloc] init];
    [self.contentView addSubview:_nameLab];
    _nameLab.backgroundColor = [UIColor clearColor];
    _nameLab.font = [UIFont systemFontOfSize:16];
    _nameLab.textColor = kBlackColor;
    _nameLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    _numberLab = [[UILabel alloc] init];
    [self.contentView addSubview:_numberLab];
    _numberLab.backgroundColor = [UIColor clearColor];
    _numberLab.text = @"￥";
    _numberLab.font = [UIFont boldSystemFontOfSize:16];
    _numberLab.textColor = kDeepGreyColor;
    _numberLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    _addressLab = [[UILabel alloc] init];
    [self.contentView addSubview:_addressLab];
    _addressLab.backgroundColor = [UIColor clearColor];
    _addressLab.font = [UIFont systemFontOfSize:13];
    _addressLab.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    _addressLab.lineBreakMode = NSLineBreakByTruncatingTail;
    

    _defaultsBtn = [[UIButton alloc] init];
    [self.contentView addSubview:_defaultsBtn];
    _defaultsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_defaultsBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_defaultsBtn setImage:[UIImage imageNamed:@"check_box"] forState:UIControlStateNormal];
    [_defaultsBtn setImage:[UIImage imageNamed:@"check_box_on"] forState:UIControlStateSelected];
    _defaultsBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    [_defaultsBtn addTarget:self action:@selector(defaultsDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.contentView.mas_leading).with.offset(15);
        make.width.mas_equalTo(150);
        make.top.equalTo(_weakSelf.contentView.mas_top).with.offset(7);
    }];
    
    [_numberLab sizeToFit];
    [_numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_weakSelf.contentView.mas_right).offset(-50);
        make.top.equalTo(_nameLab.mas_top);
    }];
    
    [_addressLab sizeToFit];
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLab.mas_left);
        make.right.equalTo(_numberLab.mas_right);
        make.bottom.equalTo(_weakSelf.contentView.mas_bottom).offset(-15);
    }];
    
    [_defaultsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@35);
        make.height.equalTo(@30);
        make.centerY.equalTo(_weakSelf.contentView);
        make.right.equalTo(_weakSelf.mas_right);
    }];
}

- (void)defaultsDidClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (self.defaultsDidClickBlock) {
        self.model.defaults = btn.selected;
        self.defaultsDidClickBlock(self.model);
    }
}


- (void)setModel:(FDAddressModel *)model
{
    _model = model;

    _nameLab.text = model.contact;
    _numberLab.text = model.number;
    _addressLab.text = model.address;
    _defaultsBtn.selected = model.defaults;
}

@end
