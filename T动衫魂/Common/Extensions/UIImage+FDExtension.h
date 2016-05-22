//
//  UIImage+FDExtension.h
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FDExtension)

+(UIImage *)addIconToImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize;

/**
 *  修改图片的size
 */
- (UIImage *)imageWithSize:(CGSize) size equal:(BOOL)equal;

@end
