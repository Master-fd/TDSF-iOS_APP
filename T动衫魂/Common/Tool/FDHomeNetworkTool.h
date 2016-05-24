//
//  FDHomeNetworkTool.h
//  T动衫魂
//
//  Created by asus on 16/5/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求goods 结果 block
 */
typedef void (^getGoodsRequiresBlock)(NSArray *results);

/**
 *  发布朋友圈，上传图片结果
 */
typedef void(^addDiscoverBlock)();


@interface FDHomeNetworkTool : NSObject




/**
 *  发送get请求，获取数据
 */
+ (void)getGoodsRequires:(NSDictionary *)params dropUp:(BOOL)direction success:(getGoodsRequiresBlock)requireSuccessBlock failure:(getGoodsRequiresBlock)requireFailureBlock;


/**
 *  发送get请求，获取discover数据
 */
+ (void)getDiscoversRequires:(NSDictionary *)params dropUp:(BOOL)direction success:(getGoodsRequiresBlock)requireSuccessBlock failure:(getGoodsRequiresBlock)requireFailureBlock;

/**
 *  发送post请求，上传图片，发布朋友圈数据, 传入图片和文字内容
 */
+ (void)addDiscoverWithImage:(UIImage *)image content:(NSString *)str success:(addDiscoverBlock)addDiscoverSuccessBlock failure:(addDiscoverBlock)addDiscoverFaildBlock;


@end
