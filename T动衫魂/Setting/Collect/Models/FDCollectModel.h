//
//  FDCollectModel.h
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDGoodsModel;
@interface FDCollectModel : NSObject


/**
 *  在服务器数据库中的id
 */
@property (nonatomic, assign) NSInteger ID;

/**
 *  商品实际的model,跳转到指定商品界面需要
 */
@property (nonatomic, strong) FDGoodsModel *goodsInfoModel;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)collectWithDict:(NSDictionary *)dict;

@end
