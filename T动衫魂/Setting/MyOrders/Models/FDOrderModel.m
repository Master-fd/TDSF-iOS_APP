//
//  FDOrderModel.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDOrderModel.h"
#import "FDShoppingCartModel.h"
#import "FDAddressModel.h"

@interface FDOrderModel()

@end
@implementation FDOrderModel


- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    if (self = [super init]) {
        self.ID = [dict[@"id"] integerValue];
        self.status = dict[@"status"];  //状态
        
        //地址
        NSString *utf8Str = dict[@"addressModel"];
        NSData *base64Data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
        NSData *data = [[NSData alloc] initWithBase64EncodedData:base64Data options:0];
        self.address = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        //shoppingcartS  订单所有商品
        NSString *string = dict[@"shoppingCartModels"];
        NSArray *goodses = [string componentsSeparatedByString:@","];  //放的是编码之后的字符串
        __block NSMutableArray *arrayM = [NSMutableArray array];
        [goodses enumerateObjectsUsingBlock:^(NSString *goodsUtf8Str, NSUInteger idx, BOOL *stop) {
            //解码
            NSData *goodsBase64Data = [goodsUtf8Str dataUsingEncoding:NSUTF8StringEncoding];
            NSData *goodsData = [[NSData alloc] initWithBase64EncodedData:goodsBase64Data options:0];
            FDShoppingCartModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:goodsData];
            //保存
            [arrayM addObject:model];
        }];
        self.shoppingCartModels = [NSArray arrayWithArray:arrayM];
    }
    
    
    return self;
}

+ (instancetype)orderWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
