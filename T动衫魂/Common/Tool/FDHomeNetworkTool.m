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


//获取商品地址请求格式http://119.29.202.162/TDBF/uploads/getGoods.php?idPage=0&pageSize=10&sex=female&subClass=common
#define kGoodsRequireAddr          @"http://119.29.202.162/TDBF/uploads/getGoods.php"
//获取discover地址  请求格式http://119.29.202.162/TDBF/discover/getDiscover.php?idPage=0&pageSize=10
#define kDiscoversRequireAddr      @"http://119.29.202.162/TDBF/discover/getDiscover.php"
//发布朋友圈地址  请求格式http://119.29.202.162/TDBF/discover/addDiscover.php
#define kAddDiscoverAddr           @"http://119.29.202.162/TDBF/discover/addDiscover.php"





@implementation FDHomeNetworkTool




/**
 *  发送get请求，获取discover数据
 */
+ (void)getDiscoversRequires:(NSDictionary *)params dropUp:(BOOL)direction success:(getGoodsRequiresBlock)requireSuccessBlock failure:(getGoodsRequiresBlock)requireFailureBlock
{
       //发送get请求，返回json数据
    AFHTTPRequestOperationManager *maneger = [[AFHTTPRequestOperationManager alloc] init];
    maneger.responseSerializer = [AFJSONResponseSerializer serializer];
    maneger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];  //可接受text/html格式
    //发送请求
    [maneger GET:kDiscoversRequireAddr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /**
         *  返回的就是dict， 保存到array, 开始刷新tableview
         */
        if (responseObject) {
            NSMutableArray *arrayM = [NSMutableArray array];
            //字典转模型
            for (NSDictionary *dict in responseObject) {
                
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
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (requireFailureBlock) {
            requireFailureBlock(nil);
        }
    }];
    
}


/**
 *  发送get请求，获取goods数据
 */
+ (void)getGoodsRequires:(NSDictionary *)params dropUp:(BOOL)direction success:(getGoodsRequiresBlock)requireSuccessBlock failure:(getGoodsRequiresBlock)requireFailureBlock
{
    //发送get请求，返回json数据
    AFHTTPRequestOperationManager *maneger = [[AFHTTPRequestOperationManager alloc] init];
    maneger.responseSerializer = [AFJSONResponseSerializer serializer];
    maneger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];  //可接受text/html格式
    //发送请求//idPage=0&pageSize=10&sex=female&subClass=common
    [maneger GET:kGoodsRequireAddr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            requireFailureBlock(nil);
        }
    }];
    
}

/**
 *  发送post请求，上传JPG格式的图片，发布朋友圈数据, 传入jpg图片和文字内容
 */
+ (void)addDiscoverWithImage:(UIImage *)image content:(NSString *)str success:(addDiscoverBlock)addDiscoverSuccessBlock failure:(addDiscoverBlock)addDiscoverFaildBlock
{
    if (!image) {
        return;
    }
    if (!str) {
        return;
    }
    //发送get请求，返回json数据
    AFHTTPRequestOperationManager *maneger = [[AFHTTPRequestOperationManager alloc] init];
    maneger.responseSerializer = [AFJSONResponseSerializer serializer];
    maneger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];  //可接受text/html格式
    
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"content"] = str;  //文字内容,需要服务器配合
    
    [maneger POST:kAddDiscoverAddr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
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
    
        if (addDiscoverSuccessBlock) {
            addDiscoverSuccessBlock();
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
        if (addDiscoverFaildBlock) {
            addDiscoverFaildBlock();
        }
    }];
    
}




@end




