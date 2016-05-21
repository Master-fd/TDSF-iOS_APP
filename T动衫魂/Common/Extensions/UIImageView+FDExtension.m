//
//  UIImageView+FDExtension.m
//  School
//
//  Created by asus on 16/5/9.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "UIImageView+FDExtension.h"

@implementation UIImageView (FDExtension)


/**
 *  将一个图片添加圆角
 */
- (UIImage *)drawRectWithRoundedCorner:(CGFloat )radius atSize:(CGSize )size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.width);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    
    [self drawRect:rect];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


/**
 *  给一个uiimageview高效添加圆角
 */
- (void)addCorner:(CGFloat )radius
{
    self.size = self.image.size;   //如果是通过约束来设置frame的，这个一定要设置上，否则size大小为0，不能设置圆角效果
    self.image = self.image ? [self drawRectWithRoundedCorner:radius atSize:self.size] : nil;

}
@end
