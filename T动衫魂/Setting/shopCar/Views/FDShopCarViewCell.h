//
//  FDShopCarViewCell.h
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDShoppingCartModel;
@interface FDShopCarViewCell : UITableViewCell

@property (nonatomic, strong) FDShoppingCartModel *goodsModel;

//更新goods
@property (nonatomic, copy) void(^updateGoodsModelBlock)(FDShoppingCartModel *model);

+ (CGFloat)height;

@end
