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


//获取商品地址
#define kGoodsRequireAddr          @"http://192.168.31.216:8080/MJServer/video"
//获取discover地址
#define kDiscoversRequireAddr      @"http://192.168.31.216:8080/MJServer/video"
//发布朋友圈地址
#define kAddDiscoverAddr           @"http://192.168.31.216:8080/MJServer/upload"


@implementation FDHomeNetworkTool




/**
 *  发送get请求，获取discover数据
 */
+ (void)getDiscoversRequires:(NSDictionary *)params dropUp:(BOOL)direction success:(getGoodsRequiresBlock)requireSuccessBlock failure:(getGoodsRequiresBlock)requireFailureBlock
{
       //发送get请求，返回json数据
    AFHTTPRequestOperationManager *maneger = [[AFHTTPRequestOperationManager alloc] init];
    maneger.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //发送请求
    [maneger GET:kGoodsRequireAddr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /**
         *  返回的就是dict， 保存到array, 开始刷新tableview
         */
        NSArray *array = responseObject[@"videos"];
        NSMutableArray *arrayM = [NSMutableArray array];
        //字典转模型
        FDLog(@"这里插入discover测试数据");
        for (NSDictionary *dict in array) {
            FDDiscoverModel *model = [FDDiscoverModel discoverWithDict:dict];
            
            model.content = @"你这不但是你撒旦是离开2";
            model.imageUrl = @"hettp";

            
            if (direction) {
                [arrayM insertObject:model atIndex:0];
            }else{
                [arrayM addObject:model];
            }
        }
        
        if (requireSuccessBlock) {   //请求成功之后，执行block
            requireSuccessBlock(arrayM);
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
    
    //发送请求
    [maneger GET:kDiscoversRequireAddr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /**
         *  返回的就是dict， 保存到array, 开始刷新collectionview
         */
        NSArray *array = responseObject[@"videos"];
        NSMutableArray *arrayM = [NSMutableArray array];
        //字典转模型
        FDLog(@"这里插入商品测试数据");
        int i=0;
        for (NSDictionary *dict in array) {
            FDGoodsModel *model = [FDGoodsModel goodsWithDict:dict];
            i++;
            model.ID = [NSString stringWithFormat:@"%d", i];
            model.name = @"卫衣卫衣卫衣";
            model.price = @"156.05";
            model.subClass = @"T";
            model.sex = @"male";
            model.minImageUrl1 = @"minImageUrl2";
            model.minImageUrl2 = @"minImageUrl2";
            model.minImageUrl3 = @"minImageUrl2";
            model.descImageUrl1 = @"minImageUrl2";
            model.descImageUrl2 = @"minImageUrl2";
            model.descImageUrl3 = @"minImageUrl2";
            model.descImageUrl4 = @"minImageUrl2";
            model.descImageUrl5 = @"minImageUrl2";
            model.aboutImageUrl = @"minImageUrl2";
            model.sizeImageUrl = @"minImageUrl2";
            model.remarkImageUrl = @"minImageUrl2";
            
            if (direction) {
                [arrayM insertObject:model atIndex:0];
            }else{
                [arrayM addObject:model];
            }
        }
        
        if (requireSuccessBlock) {   //请求成功之后，执行block
            requireSuccessBlock(arrayM);
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
    
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"kContentStr"] = str;  //文字内容,需要服务器配合
    
    [maneger POST:kAddDiscoverAddr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名，可以在上传时使用当前的系统时间作为文件名+随机数
        NSInteger random = arc4random()%1000;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        str = [NSString stringWithFormat:@"%@_%ld", str, random];  //日期+随机数
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
                 /*
                              此方法参数
                              1. 要上传的[二进制数据]
                              2. 对应网站上[upload.php中]处理文件的[字段"file"]
                              3. 要保存在服务器上的[文件名]
                              4. 上传文件的[mimeType]
                              */
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg"];

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




