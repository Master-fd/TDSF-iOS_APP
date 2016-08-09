//
//  FDDiscoverModel.h
//  T动衫魂
//
//  Created by asus on 16/5/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kIdKey          @"id"
#define kNameKey     @"name"
#define kContentKey     @"content"
#define kImageUrlKey    @"contentImageUrl"


@interface FDDiscoverModel : NSObject

@property (nonatomic, copy) NSString *ID;
/**
 *  账户
 */
@property (nonatomic, copy) NSString *name;

/**
 *  内容
 */
@property (nonatomic, copy) NSString *content;


/**
 *  图片在服务器的url
 */
@property (nonatomic, copy) NSString *contentImageUrl;


/**
 *  字典转模型
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)discoverWithDict:(NSDictionary *)dict;



@end
