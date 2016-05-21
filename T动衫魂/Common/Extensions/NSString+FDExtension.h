//
//  NSString+FDExtension.h
//  School
//
//  Created by asus on 16/4/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSString (FDExtension)


/**
 *  传入一个字符串，输出一个大写字符首字母
 *  传入的是字母，则转换成大写的首字母
 *  传入的是中文，转换成大写拼音首字母
 *  传入其他非法
 */
+ (NSString *)capitalizedWithFristCharactor:(NSString *)String;

/**
 *  判断字符串是否是字母开头
 */
+ (BOOL)isEnglishFristWithString:(NSString *)string;

/**
 *  判断字符串是否是中文开头
 */
+ (BOOL)isChineseFristWithString:(NSString *)string;

/**
 *  计算文本size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;


@end
