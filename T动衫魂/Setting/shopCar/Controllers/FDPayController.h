//
//  FDPayController.h
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseViewController.h"

@class FDAddressModel;
@interface FDPayController : FDBaseViewController

/**
 *  该订单的所有的商品信息,每个都是 shoppingCart model
 */
@property (nonatomic, strong) NSArray *OrderGoodses;

/**
 *  地址
 */
@property (nonatomic, strong) FDAddressModel *address;

@end
