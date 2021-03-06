//
//  NSString+FDExtension.m
//  School
//
//  Created by asus on 16/4/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "NSString+FDExtension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (FDExtension)



/**
 *  md5加密
 */
- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}


/**
 *  将第一个字符转换成大写字母
 *  如果是中文，取拼音的首字符,如果是字母，取首字符
 */

+ (NSString *)capitalizedWithFristCharactor:(NSString *)string
{

    NSMutableString *stringM = [[NSMutableString alloc] initWithString:string];
    
    if ([self isChineseFristWithString:stringM]) {
    
        //转为带声调的拼音
        CFStringTransform((CFMutableStringRef)stringM, NULL, kCFStringTransformMandarinLatin, NO);
    
        //转成不带声调的拼音
        CFStringTransform((CFMutableStringRef)stringM, NULL, kCFStringTransformStripDiacritics, NO);
    }
    
    //转为大写字符
    NSString *capitalized = [stringM capitalizedString];

    return [capitalized substringWithRange:NSMakeRange(0, 1)];
}

/**
 *  判断字符串是否是字母开头
 */
+ (BOOL)isEnglishFristWithString:(NSString *)string
{
    NSString *pattern = @"^[a-zA-Z]+";
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];

    if (results.count) {
        return YES;
    }else{
        return NO;
    }
}


/**
 *  判断字符串是否是中文开头
 */
+ (BOOL)isChineseFristWithString:(NSString *)string
{
    NSString *pattern = @"^[\\u4e00-\\u9fa5]+";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    if (results.count) {
        return YES;
    }else{
        return NO;
    }
}


/**
 *  自动计算文字size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}


@end
