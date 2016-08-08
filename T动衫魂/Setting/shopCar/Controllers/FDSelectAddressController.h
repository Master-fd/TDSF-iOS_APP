//
//  FDSelectAddressController.h
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseViewController.h"

@class FDAddressModel;
@interface FDSelectAddressController : FDBaseViewController

/**
 *  所有的address，  FDAddressModel
 */
@property (nonatomic, strong) NSArray *addresses;

@property (nonatomic, copy) void(^didSelectAddressBlck)(FDAddressModel *selectAddress);

@end
