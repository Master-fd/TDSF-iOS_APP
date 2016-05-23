//
//  FDHomeNetworkTool.h
//  T动衫魂
//
//  Created by asus on 16/5/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kParamIdStart   @"idstart"
#define kParamIdEnd     @"idend"
#define kParamSex       @"sex"
#define kParamSubClass  @"subclass"



@interface FDHomeNetworkTool : NSObject

typedef void (^getGoodsRequiresBlock)(NSArray *results);

/**
 *  发送get请求，获取数据
 */
+ (void)getGoodsRequires:(NSDictionary *)params dropUp:(BOOL)direction success:(getGoodsRequiresBlock)requireSuccessBlock failure:(getGoodsRequiresBlock)requireFailureBlock;


/**
 *  发送get请求，获取discover数据
 */
+ (void)getDiscoversRequires:(NSDictionary *)params dropUp:(BOOL)direction success:(getGoodsRequiresBlock)requireSuccessBlock failure:(getGoodsRequiresBlock)requireFailureBlock;

@end
