//
//  FDOrderAddressCell.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDOrderAddressCell.h"
#import "FDAddressModel.h"


@interface FDOrderAddressCell()
    
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *nameValueLab;
@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) UILabel *numberValueLab;
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UILabel *addressValueLab;

@end

@implementation FDOrderAddressCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
        
        [self setupContraints];
    }
    
    return self;
}
- (void)setupViews
{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LLStorePin"]];
    [self.contentView addSubview:_iconView];
    
    _nameValueLab = [[UILabel alloc] init];
    [self.contentView addSubview:_nameValueLab];
    _nameValueLab.backgroundColor = [UIColor clearColor];
    _nameValueLab.font = [UIFont boldSystemFontOfSize:15];
    _nameValueLab.textColor = kDeepGreyColor;
    _nameValueLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    _numberValueLab = [[UILabel alloc] init];
    [self.contentView addSubview:_numberValueLab];
    _numberValueLab.backgroundColor = [UIColor clearColor];
    _numberValueLab.font = [UIFont boldSystemFontOfSize:15];
    _numberValueLab.textColor = kDeepGreyColor;
    _numberValueLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    _addressValueLab = [[UILabel alloc] init];
    [self.contentView addSubview:_addressValueLab];
    _addressValueLab.backgroundColor = [UIColor clearColor];
    _addressValueLab.font = [UIFont boldSystemFontOfSize:12];
    _addressValueLab.numberOfLines = 0;
    _addressValueLab.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    _addressValueLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    _nameLab = [[UILabel alloc] init];
    [self.contentView addSubview:_nameLab];
    _nameLab.text = @"收  件  人:";
    _nameLab.backgroundColor = [UIColor clearColor];
    _nameLab.font = [UIFont systemFontOfSize:13];
    _nameLab.textColor = kDeepGreyColor;
    _nameLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    _numberLab = [[UILabel alloc] init];
    [self.contentView addSubview:_numberLab];
    _numberLab.backgroundColor = [UIColor clearColor];
    _numberLab.text = @"联系电话:";
    _numberLab.font = [UIFont systemFontOfSize:13];
    _numberLab.textColor = kDeepGreyColor;
    _numberLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    _addressLab = [[UILabel alloc] init];
    [self.contentView addSubview:_addressLab];
    _addressLab.text = @"详细地址:";
    _addressLab.backgroundColor = [UIColor clearColor];
    _addressLab.font = [UIFont systemFontOfSize:13];
    _addressLab.textColor = kDeepGreyColor;
    _addressLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(10);
        make.centerY.equalTo(_weakSelf.contentView);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.iconView.mas_right).with.offset(10);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(20);
        make.top.equalTo(_weakSelf.contentView.mas_top).with.offset(10);
    }];
    [_nameValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.nameLab.mas_right);
        make.right.equalTo(_weakSelf.contentView.mas_right).offset(20);
        make.top.equalTo(_weakSelf.contentView.mas_top).with.offset(10);
    }];

    [_numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.iconView.mas_right).with.offset(10);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(20);
        make.top.equalTo(_weakSelf.nameLab.mas_bottom).with.offset(10);
    }];
    [_numberValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.numberLab.mas_right);
        make.right.equalTo(_weakSelf.contentView.mas_right).offset(20);
        make.top.equalTo(_weakSelf.numberLab.mas_top);
    }];
    
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.iconView.mas_right).with.offset(10);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(20);
        make.top.equalTo(_weakSelf.numberLab.mas_bottom).with.offset(10);
    }];
    [_addressValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.addressLab.mas_right);
        make.right.equalTo(_weakSelf.contentView.mas_right).offset(-10);
        make.top.equalTo(_weakSelf.addressLab.mas_top);
        make.bottom.equalTo(_weakSelf.contentView.mas_bottom).offset(-15);
    }];
}



- (void)setAddress:(FDAddressModel *)address
{
    _address = address;
    _nameValueLab.text = address.contact;
    _numberValueLab.text = address.number;
    _addressValueLab.text = address.address;
}

@end
