//
//  FDLoginViewCell.h
//  T动衫魂
//
//  Created by asus on 16/8/5.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDLoginViewCell : UITableViewCell

@property (nonatomic, copy) void(^btnDidClickBlock)(UIButton *btn);

@property (nonatomic, assign) BOOL loginStatus;

@end
