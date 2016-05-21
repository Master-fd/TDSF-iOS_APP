//
//  FDHomeCollectionViewCell.h
//  T动衫魂
//
//  Created by asus on 16/5/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

#define cellID         @"HomeCollectionViewCell"
@class FDGoodsModel;
@interface FDHomeCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong) FDGoodsModel *model;

@end
