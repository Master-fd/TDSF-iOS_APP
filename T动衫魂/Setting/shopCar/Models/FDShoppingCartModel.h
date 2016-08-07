//
//  FDGoodModel.h
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FDGoodsModel;
@interface FDShoppingCartModel : NSObject


/**
 *  在服务购物车数据库中的id
 */
@property (nonatomic, assign) NSInteger ID;

/**
 *  衣服名称，描述
 */
@property (nonatomic, copy) NSString *goodsName;

/**
 *  金钱
 */
@property (nonatomic, assign) CGFloat sumPrice;

/**
 *  数量
 */
@property (nonatomic, assign) NSInteger count;

/**
 *  大小
 */
@property (nonatomic, copy) NSString *size;

/**
 *  是否被选择
 */
@property (nonatomic, assign) BOOL isSelect;

/**
 *  商品实际的model,跳转到指定商品界面需要
 */
@property (nonatomic, strong) FDGoodsModel *goodsInfoModel;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)shoppingCartWithDict:(NSDictionary *)dict;


@end
