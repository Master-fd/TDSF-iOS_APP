//
//  FDAddressEditController.h
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseViewController.h"

@class FDAddressModel;
@interface FDAddressEditController : FDBaseViewController

@property (nonatomic, strong) FDAddressModel *model;

//是否是添加address操作
@property (nonatomic, assign) BOOL isAddAddress;
@end
