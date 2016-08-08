//
//  FDOrderCell.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDOrderCell.h"
#import "FDShoppingCartModel.h"
#import "FDGoodsModel.h"

@interface FDOrderCell()

@property (nonatomic, strong) UIImageView *iconView;  //图片
@property (nonatomic, strong) UILabel *titleLab;  //名字
@property (nonatomic, strong) UILabel *countLab; //数量
@property (nonatomic, strong) UILabel *priceValueLab;  //价格值
@property (nonatomic, strong) UILabel *sizeLab;  //商品选中尺码


@end


@implementation FDOrderCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
        
    }
    
    return self;
}

- (void)setupViews
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = 20;
    __weak typeof(self) _weakSelf = self;
    
    
    _iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.contentView.mas_top).offset(margin);
        make.left.mas_equalTo(_weakSelf.contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(screenW/4, screenW/3));
    }];
    
    _titleLab = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLab];
    _titleLab.font = [UIFont systemFontOfSize:14];
    _titleLab.textColor = kDeepGreyColor;
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.iconView.mas_top).offset(10);
        make.right.equalTo(_weakSelf.contentView.mas_right).offset(-20);
        make.left.mas_equalTo(_weakSelf.iconView.mas_right).offset(margin);
    }];
    
    _sizeLab = [[UILabel alloc] init];
    [self.contentView addSubview:_sizeLab];
    _sizeLab.textColor = kDeepGreyColor;
    _sizeLab.textAlignment = NSTextAlignmentCenter;
    _sizeLab.font = [UIFont systemFontOfSize:10];
    _sizeLab.layer.borderColor = kRoseColor.CGColor;
    _sizeLab.layer.borderWidth = 1;
    _sizeLab.layer.cornerRadius = 4;
    [_sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.titleLab.mas_bottom).offset(15);
        make.leading.equalTo(_weakSelf.titleLab.mas_leading);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(17);
    }];
    
    _countLab = [[UILabel alloc] init];
    [self.contentView addSubview:_countLab];
    _countLab.font = [UIFont systemFontOfSize:14];
    _countLab.textColor = kRoseColor;
    _countLab.textAlignment = NSTextAlignmentCenter;
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_weakSelf.sizeLab.mas_right).offset(35);
        make.top.bottom.mas_equalTo(_weakSelf.sizeLab);
        make.width.mas_equalTo(40);
    }];
    
    
    _priceValueLab = [[UILabel alloc] init];
    [self.contentView addSubview:_priceValueLab];
    _priceValueLab.font = [UIFont systemFontOfSize:12];
    _priceValueLab.textColor = kRoseColor;
    _priceValueLab.text = @"0.00";
    [_priceValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.countLab.mas_bottom).offset(15);
        make.leading.equalTo(_weakSelf.titleLab.mas_leading);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(_weakSelf.titleLab.mas_height);
    }];
}

- (void)setGoodsModel:(FDShoppingCartModel *)goodsModel
{
    _goodsModel = goodsModel;
      
    FDGoodsModel *infoModel = goodsModel.goodsInfoModel;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:infoModel.minImageUrl1] placeholderImage:[UIImage imageNamed:@"icon_AboutMeMax"] options:SDWebImageProgressiveDownload];
    _titleLab.text = goodsModel.goodsName;
    _priceValueLab.text = [NSString stringWithFormat:@"￥%.02f", goodsModel.sumPrice];
    _countLab.text = [NSString stringWithFormat:@"x%ld", goodsModel.count];
    _sizeLab.text = goodsModel.size;
    
}

+ (CGFloat)height
{
    return [UIScreen mainScreen].bounds.size.width/3 + 40;
}
@end
