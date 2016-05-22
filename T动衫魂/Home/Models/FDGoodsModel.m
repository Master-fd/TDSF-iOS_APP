//
//  FDGoodsModel.m
//  T动衫魂
//
//  Created by asus on 16/5/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDGoodsModel.h"

@implementation FDGoodsModel


- (instancetype)initWithDict:(NSDictionary *)dict;
{
    self.ID = dict[kGoodsidKey];
    self.name = dict[kGoodsnameKey];
    self.price = dict[kGoodspriceKey];
    self.subClass = dict[kGoodssubClassKey];
    self.sex = dict[kGoodssexKey];
    self.minImageUrl1 = dict[kGoodsminImageUrl1Key];
    self.minImageUrl2 = dict[kGoodsminImageUrl2Key];
    self.minImageUrl3 = dict[kGoodsminImageUrl3Key];
    self.descImageUrl1 = dict[kGoodsdescImageUrl1Key];
    self.descImageUrl2 = dict[kGoodsdescImageUrl2Key];
    self.descImageUrl3 = dict[kGoodsdescImageUrl3Key];
    self.descImageUrl4 = dict[kGoodsdescImageUrl4Key];
    self.descImageUrl5 = dict[kGoodsdescImageUrl5Key];
    self.aboutImageUrl = dict[kGoodsaboutImageUrlKey];
    self.sizeImageUrl = dict[kGoodssizeImageUrlKey];
    self.remarkImageUrl = dict[kGoodsremarkImageUrlKey];
    
    return self;
}

+ (instancetype)goodsWithDict:(NSDictionary *)dict;
{
    return [[self alloc] initWithDict:dict];
}
@end
