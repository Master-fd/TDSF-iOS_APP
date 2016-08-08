//
//  FDOrderModel.h
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDAddressModel;
@interface FDOrderModel : NSObject

/**
 *  订单ID
 */
@property (nonatomic, assign) NSInteger ID;

/**
 *  订单状态
 */
@property (nonatomic, copy) NSString *status;

/**
 *  订单所有的FDShoppingCartModel
 */
@property (nonatomic, strong) NSArray *shoppingCartModels;

/**
 *  订单收件地址
 */
@property (nonatomic, strong) FDAddressModel *address;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)orderWithDict:(NSDictionary *)dict;
@end
