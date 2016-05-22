//
//  UIImage+FDExtension.m
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "UIImage+FDExtension.h"

@implementation UIImage (FDExtension)


+(UIImage *)addIconToImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize
{
    UIGraphicsBeginImageContext(image.size);
    //通过两张图片进行位置和大小的绘制，实现两张图片的合并；其实此原理做法也可以用于多张图片的合并
    CGFloat widthOfImage = image.size.width;
    CGFloat heightOfImage = image.size.height;
    CGFloat widthOfIcon = iconSize.width;
    CGFloat heightOfIcon = iconSize.height;
    
    [image drawInRect:CGRectMake(0, 0, widthOfImage, heightOfImage)];
    [icon drawInRect:CGRectMake((widthOfImage-widthOfIcon)/2, (heightOfImage-heightOfIcon)/2,
                                widthOfIcon, heightOfIcon)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  修改图片的size, equal :YES  等比例，  scale: NO  不等比例
 */
- (UIImage *)imageWithSize:(CGSize) size equal:(BOOL)equal
{
    
    
    if (equal) {
        CGRect rect;
        if(size.width/size.height < self.size.width/self.size.height) {
            rect.size.width = size.height*self.size.width/self.size.height;
            rect.size.height = size.height;
            rect.origin.x = (size.width - rect.size.width)/2;
            rect.origin.y = 0;
        }else {
            rect.size.width = size.width;
            rect.size.height = size.width*self.size.height/self.size.width;
            rect.origin.x = 0;
            rect.origin.y = (size.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(size);
        [self drawInRect:rect];
    } else {
        UIGraphicsBeginImageContext(size);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    }
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
