//
//  UIImageView+FDExtension.h
//  School
//
//  Created by asus on 16/5/9.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FDExtension)

/**
 *  将一个图片添加圆角
 */
- (UIImage *)drawRectWithRoundedCorner:(CGFloat )radius atSize:(CGSize )size;

/**
 *  给一个uiimageview高效添加圆角
 */
- (void)addCorner:(CGFloat )radius;

@end
