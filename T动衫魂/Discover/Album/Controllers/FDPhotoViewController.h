//
//  FDPhotoViewController.h
//  MSTVTool
//
//  Created by asus on 16/6/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDGroupModel;

@interface FDPhotoViewController : UIViewController

/**
 *  组
 */
@property (nonatomic, strong) FDGroupModel *group;


/**
 *  取出FDAssetsModel图片回调
 */
@property (nonatomic, copy) void(^didSelectImageBlock)(id asset);

@end
