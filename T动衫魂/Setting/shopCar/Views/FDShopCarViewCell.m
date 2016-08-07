//
//  FDShopCarViewCell.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDShopCarViewCell.h"
#import "FDShoppingCartModel.h"
#import "FDGoodsModel.h"

@interface FDShopCarViewCell()

@property (nonatomic, strong) UIImageView *iconView;  //图片
@property (nonatomic, strong) UIButton *checkBoxBtn;   //选择框
@property (nonatomic, strong) UILabel *titleLab;  //名字
@property (nonatomic, strong) NSArray *sizes; //所有尺码，s m l xl
@property (nonatomic, strong) UIButton *reduceBtn;   //减小
@property (nonatomic, strong) UIButton *addBtn; //增加
@property (nonatomic, strong) UILabel *countLab; //数量
@property (nonatomic, strong) UILabel *priceLab; //价格
@property (nonatomic, strong) UILabel *priceValueLab;  //价格值

@property (nonatomic, strong) UIButton *selectSizeBtn;  //商品选中尺码
@property (nonatomic, assign) NSUInteger count;  //商品数量


@end


@implementation FDShopCarViewCell



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
    self.count = 1;
    __weak typeof(self) _weakSelf = self;
    
    _checkBoxBtn = [[UIButton alloc] init];
    [self.contentView addSubview:_checkBoxBtn];
    [_checkBoxBtn setImage:[UIImage imageNamed:@"check_box"] forState:UIControlStateNormal];
    [_checkBoxBtn setImage:[UIImage imageNamed:@"check_box_on"] forState:UIControlStateSelected];
    [_checkBoxBtn addTarget:self action:@selector(goodDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_checkBoxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_weakSelf.contentView.mas_centerY);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    _iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.contentView.mas_top).offset(margin);
        make.left.mas_equalTo(_weakSelf.checkBoxBtn.mas_right).offset(15);
        make.size.mas_equalTo(CGSizeMake(screenW/4, screenW/3));
    }];
    
    _titleLab = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLab];
    _titleLab.font = [UIFont systemFontOfSize:14];
    _titleLab.textColor = kDeepGreyColor;
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.iconView.mas_top).offset(10);
        make.left.mas_equalTo(_weakSelf.iconView.mas_right).offset(margin);
    }];
    
    UIButton *lastSizeBtn = nil;
    for (UIButton *sizeBtn in self.sizes) {
        
        [self.contentView addSubview:sizeBtn];
        [sizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(_weakSelf.titleLab.mas_bottom).offset(15);
            make.width.mas_equalTo(28);
            make.height.mas_equalTo(17);
            if (lastSizeBtn) {
                make.left.mas_equalTo(lastSizeBtn.mas_right).offset(8);
            }else{
                make.left.mas_equalTo(_weakSelf.titleLab.mas_left);
            }
            
        }];
        lastSizeBtn = sizeBtn;
    }
    
    _reduceBtn = [[UIButton alloc] init];
    [self.contentView addSubview:_reduceBtn];
    _reduceBtn.layer.borderWidth = 1;
    _reduceBtn.layer.borderColor = kDeepGreyColor.CGColor;
    _reduceBtn.layer.cornerRadius = 4;
    _reduceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_reduceBtn addTarget:self action:@selector(sumBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [_reduceBtn setTitleColor:kDeepGreyColor forState:UIControlStateNormal];
    [_reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_weakSelf.iconView.mas_bottom).offset(-10);
        make.left.mas_equalTo(_weakSelf.iconView.mas_right).offset(margin);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    _countLab = [[UILabel alloc] init];
    [self.contentView addSubview:_countLab];
    _countLab.font = [UIFont systemFontOfSize:12];
    _countLab.textColor = kDeepGreyColor;
    _countLab.textAlignment = NSTextAlignmentCenter;
    _countLab.text = @"1";
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_weakSelf.reduceBtn.mas_right);
        make.top.bottom.mas_equalTo(_weakSelf.reduceBtn);
        make.width.mas_equalTo(30);
    }];
    
    _addBtn = [[UIButton alloc] init];
    [self.contentView addSubview:_addBtn];
    _addBtn.layer.borderWidth = 1;
    _addBtn.layer.borderColor = kDeepGreyColor.CGColor;
    _addBtn.layer.cornerRadius = 4;
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_addBtn addTarget:self action:@selector(sumBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addBtn setTitleColor:kDeepGreyColor forState:UIControlStateNormal];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_weakSelf.reduceBtn.mas_bottom);
        make.left.mas_equalTo(_weakSelf.countLab.mas_right);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    
    _priceValueLab = [[UILabel alloc] init];
    [self.contentView addSubview:_priceValueLab];
    _priceValueLab.font = [UIFont systemFontOfSize:12];
    _priceValueLab.textColor = kRoseColor;
    _priceValueLab.text = @"0.00";
    [_priceValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.addBtn.mas_top);
        make.width.mas_equalTo(55);
        make.right.mas_equalTo(_weakSelf.contentView.mas_right).offset(-20);
    }];
    
    _priceLab = [[UILabel alloc] init];
    [self.contentView addSubview:_priceLab];
    _priceLab.font = [UIFont systemFontOfSize:11];
    _priceLab.textColor = kDeepGreyColor;
    _priceLab.text = @"小计";
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_weakSelf.priceValueLab.mas_left).offset(-3);
        make.top.mas_equalTo(_weakSelf.priceValueLab.mas_top);
    }];

}

+ (CGFloat)height
{
    return [UIScreen mainScreen].bounds.size.width/3 + 40;
}

- (NSArray *)sizes
{
    if (!_sizes) {
        
        UIButton *btnS = [[UIButton alloc] init];
        self.selectSizeBtn = btnS;
        btnS.titleLabel.font = [UIFont systemFontOfSize:10];
        btnS.layer.borderColor = kRoseColor.CGColor;
        btnS.layer.borderWidth = 1;
        btnS.layer.cornerRadius = 4;
        [btnS setTitleColor:kDeepGreyColor forState:UIControlStateNormal];
        [btnS setTitle:@"S" forState:UIControlStateNormal];
        [btnS addTarget:self action:@selector(sizeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnM = [[UIButton alloc] init];
        btnM.titleLabel.font = [UIFont systemFontOfSize:10];
        btnM.layer.borderColor = kDeepGreyColor.CGColor;
        btnM.layer.borderWidth = 1;
        btnM.layer.cornerRadius = 4;
        [btnM setTitleColor:kDeepGreyColor forState:UIControlStateNormal];
        [btnM setTitle:@"M" forState:UIControlStateNormal];
        [btnM addTarget:self action:@selector(sizeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnL = [[UIButton alloc] init];
        btnL.titleLabel.font = [UIFont systemFontOfSize:10];
        btnL.layer.borderColor = kDeepGreyColor.CGColor;
        btnL.layer.borderWidth = 1;
        btnL.layer.cornerRadius = 4;
        [btnL setTitleColor:kDeepGreyColor forState:UIControlStateNormal];
        [btnL setTitle:@"L" forState:UIControlStateNormal];
        [btnL addTarget:self action:@selector(sizeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnXL = [[UIButton alloc] init];
        btnXL.titleLabel.font = [UIFont systemFontOfSize:10];
        btnXL.layer.borderColor = kDeepGreyColor.CGColor;
        btnXL.layer.borderWidth = 1;
        btnXL.layer.cornerRadius = 4;
        [btnXL setTitleColor:kDeepGreyColor forState:UIControlStateNormal];
        [btnXL setTitle:@"XL" forState:UIControlStateNormal];
        [btnXL addTarget:self action:@selector(sizeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _sizes = @[btnS, btnM, btnL, btnXL];
    }
    
    return _sizes;
}
/**
 *  数量选中,更新
 */
- (void)sumBtnDidClick:(UIButton *)btn
{
    FDGoodsModel *infoModel = self.goodsModel.goodsInfoModel;
    if (btn == self.reduceBtn) {
        if (self.count > 1) {
            self.count --;
            self.countLab.text = [@(self.count) stringValue];
            self.priceValueLab.text = [NSString stringWithFormat:@"￥%.02f", self.count * [infoModel.price floatValue]];
            
            //更新最新的商品信息
            [self updateGoodsInfo];
        }
        
    }
    
    if (btn == self.addBtn) {
        if (self.count<1000) {
            self.count ++;
            self.countLab.text = [@(self.count) stringValue];
            self.priceValueLab.text = [NSString stringWithFormat:@"￥%.02f", self.count * [infoModel.price floatValue]];
            //更新最新的商品信息
            [self updateGoodsInfo];
        }
    }
}

/**
 *  选中商品size
 */
- (void)sizeBtnDidClick:(UIButton *)btn
{
    self.selectSizeBtn.layer.borderColor = kDeepGreyColor.CGColor;
    self.selectSizeBtn = btn;
    self.selectSizeBtn.layer.borderColor = kRoseColor.CGColor;
    
    //更新最新的商品信息
    [self updateGoodsInfo];
}


/**
 *  更新商品是否选中
 */
- (void)goodDidSelect:(UIButton *)btn
{
    self.checkBoxBtn.selected = !self.checkBoxBtn.selected;
    
    self.goodsModel.goodsName = self.titleLab.text;
    self.goodsModel.count = [self.countLab.text integerValue];
    self.goodsModel.size = self.selectSizeBtn.titleLabel.text;
    self.goodsModel.sumPrice = [[self.priceValueLab.text substringWithRange:NSMakeRange(1, self.priceValueLab.text.length-1)] floatValue];
    self.goodsModel.isSelect = self.checkBoxBtn.selected;
    
    [self updateGoodsInfo];
}

/**
 *  更新商品信息
 */
- (void)updateGoodsInfo
{
    self.goodsModel.goodsName = self.titleLab.text;
    self.goodsModel.count = [self.countLab.text integerValue];
    self.goodsModel.size = self.selectSizeBtn.titleLabel.text;
    self.goodsModel.sumPrice = [[self.priceValueLab.text substringWithRange:NSMakeRange(1, self.priceValueLab.text.length-1)] floatValue];
    self.goodsModel.isSelect = self.checkBoxBtn.selected;
    
    if (self.updateGoodsModelBlock) { //将最新的商品数据传出去
        self.updateGoodsModelBlock(self.goodsModel);
    }
}

/**
 *  懒加载，设置商品title和单价
 */
- (void)setGoodsModel:(FDShoppingCartModel *)goodsModel
{
    _goodsModel = goodsModel;
    FDGoodsModel *infoModel = goodsModel.goodsInfoModel;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:infoModel.minImageUrl1] placeholderImage:[UIImage imageNamed:@"icon_AboutMeMax"] options:SDWebImageProgressiveDownload];
    _titleLab.text = goodsModel.goodsName;
    _priceValueLab.text = [NSString stringWithFormat:@"￥%.02f", goodsModel.sumPrice];
    _checkBoxBtn.selected = goodsModel.isSelect;
    _countLab.text = [NSString stringWithFormat:@"%ld", goodsModel.count];
    
    if ([goodsModel.size isEqualToString:@"S"]) {
        [self sizeBtnDidClick:self.sizes[0]];
    }
    if ([goodsModel.size isEqualToString:@"M"]) {
        [self sizeBtnDidClick:self.sizes[1]];
    }
    if ([goodsModel.size isEqualToString:@"L"]) {
        [self sizeBtnDidClick:self.sizes[2]];
    }
    if ([goodsModel.size isEqualToString:@"XL"]) {
        [self sizeBtnDidClick:self.sizes[3]];
    }
    
}


@end
