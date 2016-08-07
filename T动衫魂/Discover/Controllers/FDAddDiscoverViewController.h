//
//  FDAddDiscoverViewController.h
//  T动衫魂
//
//  Created by asus on 16/5/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseViewController.h"


@interface FDAddDiscoverViewController : FDBaseViewController

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) void(^didSendDiscoverBlock)(UIImage *image, NSString *content);
@end
