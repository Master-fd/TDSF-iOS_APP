//
//  FDMyCollectCell.h
//  T动衫魂
//
//  Created by asus on 16/5/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kcellID  @"collectCellID"
@class FDGoodsModel;
@interface FDMyCollectCell : UITableViewCell


@property (nonatomic, strong) FDGoodsModel *model;

@end
