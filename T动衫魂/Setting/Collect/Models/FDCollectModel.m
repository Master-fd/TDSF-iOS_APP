//
//  FDCollectModel.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDCollectModel.h"

@implementation FDCollectModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    
    self.ID = [dict[@"id"] integerValue];
    NSString *utf8Str = dict[@"goodsModel"];
    NSData *base64Data = [utf8Str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [[NSData alloc] initWithBase64EncodedData:base64Data options:0];
    self.goodsInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return self;
}

+ (instancetype)collectWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
