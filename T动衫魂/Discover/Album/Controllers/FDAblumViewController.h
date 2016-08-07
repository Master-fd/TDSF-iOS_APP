//
//  FDAblumViewController.h
//  MSTVTool
//
//  Created by asus on 16/6/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDAblumViewController : UIViewController

/**
 *  取出FDAssetsModel图片回调
 */
@property (nonatomic, copy) void(^didSelectImageBlock)(id asset);

@end
