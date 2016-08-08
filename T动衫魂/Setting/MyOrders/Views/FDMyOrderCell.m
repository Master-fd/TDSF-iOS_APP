//
//  FDMyOrderCell.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyOrderCell.h"
#import "FDImageBarView.h"
#import "FDOrderModel.h"
#import "FDShoppingCartModel.h"
#import "FDGoodsModel.h"


@interface FDMyOrderCell()


@property (nonatomic, strong) UILabel *countLab; //总数量
@property (nonatomic, strong) UILabel *sumPriceLab; //合计
@property (nonatomic, strong) UILabel *statusLab;  //状态
@property (nonatomic, strong) FDImageBarView *imageBarView;

@end


@implementation FDMyOrderCell



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
    __weak typeof(self) _weakSelf = self;
    
    
    _statusLab = [[UILabel alloc] init];
    [self.contentView addSubview:_statusLab];
    _statusLab.font = [UIFont systemFontOfSize:14];
    _statusLab.textColor = kRoseColor;
    _statusLab.backgroundColor = kWhiteColor;
    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.contentView);
        make.leading.mas_equalTo(_weakSelf.contentView).offset(20);
        make.right.mas_equalTo(_weakSelf.contentView).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    _imageBarView = [[FDImageBarView alloc] init];
    [self.contentView addSubview:_imageBarView];
    _imageBarView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [_imageBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.statusLab.mas_bottom);
        make.left.right.mas_equalTo(_weakSelf.contentView);
    }];
    
    
    _sumPriceLab = [[UILabel alloc] init];
    [self.contentView addSubview:_sumPriceLab];
    _sumPriceLab.textColor = kRoseColor;
    _sumPriceLab.textAlignment = NSTextAlignmentCenter;
    _sumPriceLab.font = [UIFont systemFontOfSize:12];
    [_sumPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.imageBarView.mas_bottom).offset(5);
        make.right.equalTo(_weakSelf.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(_weakSelf.contentView.mas_bottom).offset(-5);
    }];
    
    _countLab = [[UILabel alloc] init];
    [self.contentView addSubview:_countLab];
    _countLab.font = [UIFont systemFontOfSize:14];
    _countLab.textColor = kRoseColor;
    _countLab.textAlignment = NSTextAlignmentCenter;
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_weakSelf.sumPriceLab.mas_left).offset(-15);
        make.top.bottom.mas_equalTo(_weakSelf.sumPriceLab);
        make.width.mas_equalTo(100);
    }];
    
}

/**
 *  配置数据
 */
- (void)setOrderModel:(FDOrderModel *)orderModel
{
    _orderModel = orderModel;
    _statusLab.text = [NSString stringWithFormat:@"状态:%@", orderModel.status];  //设置状态
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i=0; i<orderModel.shoppingCartModels.count; i++) {
        FDShoppingCartModel *model = orderModel.shoppingCartModels[i];
        FDGoodsModel *goodsModel = model.goodsInfoModel;
        
        [arrayM addObject:goodsModel.minImageUrl1];
    }
    _imageBarView.iconArray = arrayM; //设置图片
    //设置钱
    __block CGFloat sumPrice = 0;
    [orderModel.shoppingCartModels enumerateObjectsUsingBlock:^(FDShoppingCartModel *obj, NSUInteger idx, BOOL *stop) {
        if (obj.isSelect) {
            sumPrice += obj.sumPrice;
        }
    }];
    _sumPriceLab.text = [NSString stringWithFormat:@"合计:￥%0.02f", sumPrice];
    _countLab.text = [NSString stringWithFormat:@"共x%d件商品", orderModel.shoppingCartModels.count];
}


@end
