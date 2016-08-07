//
//  FDHomeNetworkTool.h
//  T动衫魂
//
//  Created by asus on 16/5/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

/*网络返回数据格式：
 {code ：状态码
    message ：附带信息
    data : [数据1字典，数据2字典]
}*/
//取数据key
#define kCodeKey  @"code"
#define kMessageKey  @"message"
#define kDataKey     @"data"

//网络错误
#define kUnknownNetwordStatusCode    300
#define kUnknownNetwordMessage   @"unknownNetword"
//请求网络状态码
typedef NS_ENUM(NSUInteger, networdStatus)
{
    networdStatusSuccess = 200,
    networdStatusExist = 300,
    networdStatusFail = 400
    
};




/**
 *  一个请求成功返回的结果,
 */
typedef void(^requiresSuccessResultBlock)(NSArray *results);

/**
 *  请求失败，网络不通，没有数据，等等
 */
typedef void(^requiresFailureResultBlock)(NSInteger statusCode, NSString *message);

@class FDCollectModel;
@class FDAddressModel;
@class FDShoppingCartModel;
@interface FDHomeNetworkTool : NSObject


/**
 *  从服务器获取colloct信息
 */
+ (void)getCollectWithName:(NSString *)name success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock;

/**
 *  post collect信息到服务器
 */
+ (void)postCollectWithName:(NSString *)name model:(FDCollectModel *)collectModel operation:(NSString *)operation success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock;

/**
 *  从服务器获取address信息
 */
+ (void)getAddressesWithName:(NSString *)name success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock;

/**
 *  post修改后的address信息到服务器
 */
+ (void)postAddressesWithName:(NSString *)name model:(FDAddressModel *)addressModel operation:(NSString *)operation success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock;

/**
 *  post购物车信息到服务器
 */
+ (void)postShoppingCartGoodsWithName:(NSString *)name model:(FDShoppingCartModel *)shoppingCartModel operation:(NSString *)operation success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock;

/**
 *  从服务器获取购物车数据
 */
+ (void)getShoppingCartGoodsWithName:(NSString *)name success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock;

/**
 *  发送post请求,登录,password采用MD5加密，其他的明文
 */
+ (void)userLoginWithName:(NSString *)name password:(NSString *)password success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock;

/**
 *  发送post请求,注册用户,password采用MD5加密，其他的明文
 */
+ (void)userRegisterWithName:(NSString *)name password:(NSString *)password success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock;


/**
 *  发送get请求，获取goods数据
 */
+ (void)getGoodsRequires:(NSDictionary *)params dropUp:(BOOL)direction success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock;


/**
 *  发送get请求，获取discover数据
 */
+ (void)getDiscoversWithParams:(NSDictionary *)params dropUp:(BOOL)direction success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock;

/**
 *  发送post请求，上传图片，发布朋友圈数据, 传入图片和文字内容
 */
+ (void)addDiscoverWithName:(NSString *)name image:(UIImage *)image content:(NSString *)content success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock;

/**
 *  发送get请求，获取指定名字的discover数据
 */
+ (void)getDiscoversWithName:(NSString *)name success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock;

/**
 *  发送post请求，删除指定买家秀
 */
+ (void)postDeleteDiscoverWithName:(NSString *)name content:(NSString *)content success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock;

@end
