//
//  FDAssetsModel.m
//  MSTVTool
//
//  Created by asus on 16/6/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAssetsModel.h"

@implementation FDAssetsModel


/**
 *  缩略图
 */
- (UIImage *)thumbImage
{
    return [UIImage imageWithCGImage:[self.asset thumbnail]];
}


/**
 *  原尺寸图
 */
- (UIImage *)originImage
{
    ALAssetRepresentation *rep = [self.asset defaultRepresentation];
    CGImageRef iref = [rep fullResolutionImage];
    return [UIImage imageWithCGImage:iref scale:[rep scale] orientation:(UIImageOrientation)[rep orientation]];
}

/**
 *  全屏图
 */
- (UIImage *)fullScreenImage
{
    return [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullScreenImage]];
}

/**
 *  获取相片URL
 */
- (NSURL *)assetURL
{
    return [[self.asset defaultRepresentation] url];
}

/**
 *  是否是视频类型
 */
- (BOOL)isVideoTypde
{
    return [[self.asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
}


@end
