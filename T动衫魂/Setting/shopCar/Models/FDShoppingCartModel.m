//
//  FDGoodModel.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDShoppingCartModel.h"
#import "FDGoodsModel.h"
@implementation FDShoppingCartModel


- (instancetype)initWithDict:(NSDictionary *)dict
{
   
    
    self.ID = [dict[@"id"] integerValue];
    self.goodsName = dict[@"goodsName"];
    self.sumPrice = [dict[@"sumPrice"] floatValue];
    self.count = [dict[@"count"] integerValue];
    self.size = dict[@"size"];
    self.isSelect = [dict[@"isSelect"] boolValue];
    NSString *utf8Str = dict[@"goodsModel"];
    NSData *base64Data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [[NSData alloc] initWithBase64EncodedData:base64Data options:0];
    self.goodsInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return self;
}

+ (instancetype)shoppingCartWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
