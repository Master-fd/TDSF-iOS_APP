//
//  FDOrderCell.h
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDShoppingCartModel;
@interface FDOrderCell : UITableViewCell

@property (nonatomic, strong) FDShoppingCartModel *goodsModel;

+ (CGFloat)height;

@end
