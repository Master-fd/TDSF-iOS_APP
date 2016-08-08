//
//  FDHomeNetworkTool.m
//  T动衫魂
//
//  Created by asus on 16/5/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDHomeNetworkTool.h"
#import "FDGoodsModel.h"
#import "FDDiscoverModel.h"
#import "FDShoppingCartModel.h"
#import "FDAddressModel.h"
#import "FDCollectModel.h"
#import "FDOrderModel.h"


@implementation FDHomeNetworkTool



/**
 *  从服务器获取Order信息
 */
+ (void)getOrderWithName:(NSString *)name success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    NSDictionary *params = @{@"name" : name,
                             @"operation" : kOperationSelectKey};
    [manager GET:kOrderAddr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        if (statusCode == networdStatusSuccess) {
            //成功
            
            NSMutableArray *arrayM = [NSMutableArray array];
            for (NSDictionary *dict in data) {
                
                FDOrderModel *order = [FDOrderModel orderWithDict:dict];
                [arrayM insertObject:order atIndex:0];
            }
            if (requireSuccessBlock) {
                requireSuccessBlock(arrayM);
            }
        }else{
            //失败
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  post Order信息到服务器
 */
+ (void)postOrderWithName:(NSString *)name model:(FDOrderModel *)orderModel status:(NSString *)status operation:(NSString *)operation success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    //封装请求参数
    //addressMode
    NSData *addrBase64Data = [[NSKeyedArchiver archivedDataWithRootObject:orderModel.address] base64EncodedDataWithOptions:0];
    NSString *addrBase64Str = [[NSString alloc] initWithData:addrBase64Data encoding:NSUTF8StringEncoding];

    //shoppoingcartModels
    //先将所有的shoppingcartModel 转成str，放入数组
    __block NSMutableArray *arrayM = [NSMutableArray array];
    [orderModel.shoppingCartModels enumerateObjectsUsingBlock:^(FDShoppingCartModel *shoppingCart, NSUInteger idx, BOOL *stop) {
        //解码
        NSData *shopBase64Data = [[NSKeyedArchiver archivedDataWithRootObject:shoppingCart] base64EncodedDataWithOptions:0];
        NSString *shopBase64Str = [[NSString alloc] initWithData:shopBase64Data encoding:NSUTF8StringEncoding];
        //保存
        [arrayM addObject:shopBase64Str];
    }];
    //再将数字转成str
    NSString *shopsBase64Str = [arrayM componentsJoinedByString:@","];
    
    //封装请求参数
    NSDictionary *params = @{@"id" : [@(orderModel.ID) stringValue],
                             @"name" : name,
                             @"status" : status,
                             @"addressModel" : addrBase64Str,
                             @"shoppingCartModels" : shopsBase64Str,
                             @"operation" : operation};
    
    [manager POST:kOrderAddr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        
        if (statusCode == networdStatusSuccess) {
            //成功
            if (requireSuccessBlock) {
                requireSuccessBlock(data);
            }
        }else{
            //失败
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];

}

/**
 *  从服务器获取colloct信息
 */
+ (void)getCollectWithName:(NSString *)name success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    NSDictionary *params = @{@"name" : name,
                             @"operation" : kOperationSelectKey};
    [manager GET:kCollectAddr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        if (statusCode == networdStatusSuccess) {
            //成功
            NSMutableArray *arrayM = [NSMutableArray array];
            for (NSDictionary *dict in data) {
                
                FDCollectModel *collect = [FDCollectModel collectWithDict:dict];
                [arrayM insertObject:collect atIndex:0];
            }
            if (requireSuccessBlock) {
                requireSuccessBlock(arrayM);
            }
        }else{
            //失败
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  post collect信息到服务器
 */
+ (void)postCollectWithName:(NSString *)name model:(FDCollectModel *)collectModel operation:(NSString *)operation success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    //封装请求参数
    NSData *base64Data = [[NSKeyedArchiver archivedDataWithRootObject:collectModel.goodsInfoModel] base64EncodedDataWithOptions:0];
    NSString *base64Str = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    //封装请求参数
    NSDictionary *params = @{@"id" : [@(collectModel.ID) stringValue],
                             @"name" : name,
                             @"goodsModel" : base64Str,
                             @"operation" : operation};
    
    [manager POST:kCollectAddr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        
        if (statusCode == networdStatusSuccess) {
            //成功
            if (requireSuccessBlock) {
                requireSuccessBlock(data);
            }
        }else{
            //失败
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  从服务器获取address信息
 */
+ (void)getAddressesWithName:(NSString *)name success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    NSDictionary *params = @{@"name" : name};
    [manager GET:kAddressesAddr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        if (statusCode == networdStatusSuccess) {
            //成功
            
            NSMutableArray *arrayM = [NSMutableArray array];
            for (NSDictionary *dict in data) {
                
                FDAddressModel *address = [FDAddressModel addressWithDict:dict];
                [arrayM insertObject:address atIndex:0];
            }
            if (requireSuccessBlock) {
                requireSuccessBlock(arrayM);
            }
        }else{
            //失败
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  post修改后的address信息到服务器
 */
+ (void)postAddressesWithName:(NSString *)name model:(FDAddressModel *)addressModel operation:(NSString *)operation success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;

    //封装请求参数
    NSDictionary *params = @{@"id" : [@(addressModel.ID) stringValue],
                             @"name" : name,
                             @"contact" : addressModel.contact,
                             @"number" : addressModel.number,
                             @"address" : addressModel.address,
                             @"defaults" : [@(addressModel.defaults) stringValue],
                             @"operation" : operation};
    
    [manager POST:kAddressesAddr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        
        if (statusCode == networdStatusSuccess) {
            //成功
            if (requireSuccessBlock) {
                requireSuccessBlock(data);
            }
        }else{
            //失败
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  post购物车信息到服务器
 */
+ (void)postShoppingCartGoodsWithName:(NSString *)name model:(FDShoppingCartModel *)shoppingCartModel operation:(NSString *)operation success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock
{
    //先进行MD5加密
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    //封装请求参数
    NSData *base64Data = [[NSKeyedArchiver archivedDataWithRootObject:shoppingCartModel.goodsInfoModel] base64EncodedDataWithOptions:0];
    NSString *base64Str = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    NSDictionary *params = @{@"id" : [@(shoppingCartModel.ID) stringValue],
                             @"name" : name,
                             @"goodsName" : shoppingCartModel.goodsName,
                             @"sumPrice" : [@(shoppingCartModel.sumPrice) stringValue],
                             @"count" : [@(shoppingCartModel.count) stringValue],
                             @"size" : shoppingCartModel.size,
                             @"isSelect" : [@(shoppingCartModel.isSelect) stringValue],
                             @"goodsModel" : base64Str,
                             @"operation" : operation};
    
    [manager POST:kPostShoppingCartAddr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        
        if (statusCode == networdStatusSuccess) {
            //成功
            if (requireSuccessBlock) {
                requireSuccessBlock(data);
            }
        }else{
            //失败
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  从服务器获取购物车数据
 */
+ (void)getShoppingCartGoodsWithName:(NSString *)name success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    NSDictionary *params = @{@"name" : name};
    
    [manager GET:kGetShoppingCartAddr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        //成功
        if (statusCode == networdStatusSuccess) {
            //成功
            NSMutableArray *arrayM = [NSMutableArray array];
            //字典转模型
            for (NSDictionary *dict in data) {
                
                FDShoppingCartModel *model = [FDShoppingCartModel shoppingCartWithDict:dict];
                [arrayM insertObject:model atIndex:0];
            }
            if (requireSuccessBlock) {
                requireSuccessBlock(arrayM);
            }
        }else {
            //失败
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  发送post请求,登录,password采用MD5加密，其他的明文
 */
+ (void)userLoginWithName:(NSString *)name password:(NSString *)password success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock
{
    
    //先进行MD5加密
    NSString *md5_password = [password md5String];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    //封装请求参数
    NSDictionary *params = @{@"name" : name,
                             @"password" : md5_password};
    
    [manager POST:kUserLoginAddr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        
        if (statusCode == networdStatusSuccess) {
            //登录成功
            [FDUserInfo shareFDUserInfo].name = name;
            [FDUserInfo shareFDUserInfo].password = password;
            [FDUserInfo shareFDUserInfo].isLogin = YES;
            if (requireSuccessBlock) {
                requireSuccessBlock(data);
            }
        }else {
            //登录失败
            [FDUserInfo shareFDUserInfo].name = nil;
            [FDUserInfo shareFDUserInfo].password = nil;
            [FDUserInfo shareFDUserInfo].isLogin = NO;
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //登录失败
        [FDUserInfo shareFDUserInfo].name = nil;
        [FDUserInfo shareFDUserInfo].password = nil;
        [FDUserInfo shareFDUserInfo].isLogin = NO;
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  发送post请求,注册用户,password采用MD5加密，其他的明文
 */
+ (void)userRegisterWithName:(NSString *)name password:(NSString *)password success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock
{
    
    //先进行MD5加密
    NSString *md5_password = [password md5String];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    //封装请求参数
    NSDictionary *params = @{@"name" : name,
                             @"password" : md5_password};
    
    [manager POST:kUserRegisterAddr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
      
        if (statusCode == networdStatusSuccess) {
            //注册成功
            if (requireSuccessBlock) {
                requireSuccessBlock(data);
            }
        }else{
            //注册失败
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //注册失败
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  发送get请求，获取discover数据
 */
+ (void)getDiscoversWithParams:(NSDictionary *)params dropUp:(BOOL)direction success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock;
{
    //发送get请求，返回json数据
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];  //可接受text/html格式
    manager.requestSerializer.timeoutInterval = 20;
    //发送请求
    [manager GET:kDiscoversRequireAddr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        /**
         *  返回的就是dict， 保存到array, 开始刷新tableview
         *  格式：{code ：状态码
                  message ：附带信息
                  data : [数据1字典，数据2字典]
                  }
         */
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        if (statusCode == networdStatusSuccess) {
            //请求成功，返回数据
            NSMutableArray *arrayM = [NSMutableArray array];
            //字典转模型
            for (NSDictionary *dict in data) {
                
                FDDiscoverModel *model = [FDDiscoverModel discoverWithDict:dict];
                                
                if (direction) {
                    [arrayM insertObject:model atIndex:0];
                }else{
                    [arrayM addObject:model];
                }
            }
            
            
            if (requireSuccessBlock) {   //请求成功之后，执行block
                requireSuccessBlock(arrayM);
            }
        }else{
            //请求失败，返回状态码信息
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
    
}


/**
 *  发送post请求，上传JPG格式的图片，发布朋友圈数据, 传入jpg图片和文字内容
 */
+ (void)addDiscoverWithName:(NSString *)name image:(UIImage *)image content:(NSString *)content success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock
{
    if (!name) {
        return;
    }
    if (!image) {
        return;
    }
    if (!content) {
        return;
    }
    //发送get请求，返回json数据
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];  //可接受text/html格式
    manager.requestSerializer.timeoutInterval = 120;
    
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[kContentKey] = content;  //文字内容,需要服务器配合
    params[kNameKey] = name;
    [manager POST:kAddDiscoverAddr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        [formData appendPartWithFileData:data name:@"contentImage" fileName:@"image.jpg" mimeType:@"image/jpg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        
        if (statusCode == networdStatusSuccess) {
            if (requireSuccessBlock) {
                requireSuccessBlock(data);
            }
        } else {
            requireFailureBlock(statusCode, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
    
}

/**
 *  发送get请求，获取指定名字的discover数据
 */
+ (void)getDiscoversWithName:(NSString *)name success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock
{
    //发送get请求，返回json数据
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];  //可接受text/html格式
    manager.requestSerializer.timeoutInterval = 20;
    
    NSDictionary *params = @{@"name" : [FDUserInfo shareFDUserInfo].name};
    //发送请求
    [manager GET:kDiscoversGetMyAddr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {

        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];

        if (statusCode == networdStatusSuccess) {
            //请求成功，返回数据
            NSMutableArray *arrayM = [NSMutableArray array];
            //字典转模型
            for (NSDictionary *dict in data) {
                
                FDDiscoverModel *model = [FDDiscoverModel discoverWithDict:dict];
                [arrayM insertObject:model atIndex:0];
            }
            
            
            if (requireSuccessBlock) {   //请求成功之后，执行block
                requireSuccessBlock(arrayM);
            }
        }else{
            //请求失败，返回状态码信息
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  发送post请求，删除指定买家秀
 */
+ (void)postDeleteDiscoverWithName:(NSString *)name content:(NSString *)content success:(requiresSuccessResultBlock )requireSuccessBlock failure:(requiresFailureResultBlock )requireFailureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 20;
    
    //封装请求参数
    NSDictionary *params = @{@"name" : name,
                             @"content" : content};
    
    [manager POST:kDiscoversDeleteMyAddr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSInteger statusCode = [[responseObject objectForKey:kCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:kMessageKey];
        NSArray *data = [responseObject objectForKeyedSubscript:kDataKey];
        
        if (statusCode == networdStatusSuccess) {
            //注册成功
            if (requireSuccessBlock) {
                requireSuccessBlock(data);
            }
        }else{
            //注册失败
            if (requireFailureBlock) {
                requireFailureBlock(statusCode, message);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //注册失败
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
}

/**
 *  发送get请求，获取goods数据
 */
+ (void)getGoodsRequires:(NSDictionary *)params dropUp:(BOOL)direction success:(requiresSuccessResultBlock)requireSuccessBlock failure:(requiresFailureResultBlock)requireFailureBlock
{
    //发送get请求，返回json数据
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];  //可接受text/html格式
    manager.requestSerializer.timeoutInterval = 20;
    
    //发送请求//idPage=0&pageSize=10&sex=female&subClass=common
    [manager GET:kGoodsRequireAddr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /**
         *  返回的就是dict， 保存到array, 开始刷新collectionview
         */
        if (responseObject) {
            
            NSMutableArray *arrayM = [NSMutableArray array];
            //字典转模型
            for (NSDictionary *dict in responseObject) {
                
                FDGoodsModel *model = [[FDGoodsModel alloc] init];
                model.ID = dict[kGoodsidKey];
                model.name = dict[kGoodsnameKey];
                model.price = dict[kGoodspriceKey];
                model.subClass = dict[kGoodssubClassKey];
                model.sex = dict[kGoodssexKey];
                model.minImageUrl1 = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodsminImageUrl1Key]];
                model.minImageUrl2 = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodsminImageUrl2Key]];
                model.minImageUrl3 = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodsminImageUrl3Key]];
                model.descImageUrl1 = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodsdescImageUrl1Key]];
                model.descImageUrl2 = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodsdescImageUrl2Key]];
                model.descImageUrl3 = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodsdescImageUrl3Key]];
                model.descImageUrl4 = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodsdescImageUrl4Key]];
                model.descImageUrl5 = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodsdescImageUrl5Key]];
                model.aboutImageUrl = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodsaboutImageUrlKey]];
                model.sizeImageUrl = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodssizeImageUrlKey]];
                model.remarkImageUrl = [NSString stringWithFormat:@"%@%@", kServerHostAddr, dict[kGoodsremarkImageUrlKey]];
                if (direction) {
                    [arrayM insertObject:model atIndex:0];
                }else{
                    [arrayM addObject:model];
                }
            }
            
            if (requireSuccessBlock) {   //请求成功之后，执行block
                requireSuccessBlock(arrayM);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (requireFailureBlock) {
            requireFailureBlock(kUnknownNetwordStatusCode, kUnknownNetwordMessage);
        }
    }];
    
}





@end




