//
//  FDAssetsModel.h
//  MSTVTool
//
//  Created by asus on 16/6/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>



@interface FDAssetsModel : NSObject

@property (nonatomic, strong) ALAsset *asset;

/**
 *  缩略图
 */
- (UIImage *)thumbImage;

/**
 *  原尺寸图
 */
- (UIImage *)originImage;

/**
 *  全屏图
 */
- (UIImage *)fullScreenImage;

/**
 *  获取相片URL
 */
- (NSURL *)assetURL;


@end
