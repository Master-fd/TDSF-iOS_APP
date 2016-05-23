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
        for (NSDictionary *dict in array) {
            FDGoodsModel *model = [FDGoodsModel goodsWithDict:dict];
            
            model.ID = @"2";
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
@end
