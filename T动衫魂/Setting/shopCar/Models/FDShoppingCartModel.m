//
//  FDGoodModel.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDShoppingCartModel.h"
#import "FDGoodsModel.h"

#define kIdKey            @"id"
#define kGoodsNameKey     @"goodsName"
#define kSumPriceKey      @"sumPrice"
#define kCountKey         @"count"
#define kSizeKey          @"size"
#define kIsSelectKey      @"isSelect"
#define kGoodsModelKey    @"goodsModel"

@interface FDShoppingCartModel()<NSCoding>

@end
@implementation FDShoppingCartModel


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
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

    }
    return self;
}

+ (instancetype)shoppingCartWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:[@(self.ID) stringValue] forKey:kIdKey];
    [aCoder encodeObject:self.goodsName forKey:kGoodsNameKey];
    [aCoder encodeObject:[@(self.sumPrice) stringValue] forKey:kSumPriceKey];
    [aCoder encodeObject:[@(self.count) stringValue] forKey:kCountKey];
    [aCoder encodeObject:self.size forKey:kSizeKey];
    [aCoder encodeObject:[@(self.isSelect) stringValue] forKey:kIsSelectKey];
    [aCoder encodeObject:self.goodsInfoModel forKey:kGoodsModelKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.ID = [[aDecoder decodeObjectForKey:kIdKey] integerValue];
        self.goodsName = [aDecoder decodeObjectForKey:kGoodsNameKey];
        self.sumPrice = [[aDecoder decodeObjectForKey:kSumPriceKey] floatValue];
        self.count = [[aDecoder decodeObjectForKey:kCountKey] integerValue];
        self.size = [aDecoder decodeObjectForKey:kSizeKey];
        self.isSelect = [[aDecoder decodeObjectForKey:kIsSelectKey] boolValue];
        self.goodsInfoModel = [aDecoder decodeObjectForKey:kGoodsModelKey];
    }
    return self;
}


@end
