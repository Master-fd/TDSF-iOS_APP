//
//  FDDiscoverViewCell.h
//  T动衫魂
//
//  Created by asus on 16/5/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kcellID    @"kFDDiscoverViewCell"

@class FDDiscoverModel;
@interface FDDiscoverViewCell : UITableViewCell

@property (nonatomic, strong) FDDiscoverModel *model;

@end
