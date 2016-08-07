//
//  FDGoodsModel.m
//  T动衫魂
//
//  Created by asus on 16/5/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDGoodsModel.h"

@interface FDGoodsModel()<NSCoding>

@end
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

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.ID forKey:kGoodsidKey];
    [aCoder encodeObject:self.name forKey:kGoodsnameKey];
    [aCoder encodeObject:self.price forKey:kGoodspriceKey];
    [aCoder encodeObject:self.subClass forKey:kGoodssubClassKey];
    [aCoder encodeObject:self.sex forKey:kGoodssexKey];
    [aCoder encodeObject:self.minImageUrl1 forKey:kGoodsminImageUrl1Key];
    [aCoder encodeObject:self.minImageUrl2 forKey:kGoodsminImageUrl2Key];
    [aCoder encodeObject:self.minImageUrl3 forKey:kGoodsminImageUrl3Key];
    [aCoder encodeObject:self.descImageUrl1 forKey:kGoodsdescImageUrl1Key];
    [aCoder encodeObject:self.descImageUrl2 forKey:kGoodsdescImageUrl2Key];
    [aCoder encodeObject:self.descImageUrl3 forKey:kGoodsdescImageUrl3Key];
    [aCoder encodeObject:self.descImageUrl4 forKey:kGoodsdescImageUrl4Key];
    [aCoder encodeObject:self.descImageUrl5 forKey:kGoodsdescImageUrl5Key];
    [aCoder encodeObject:self.aboutImageUrl forKey:kGoodsaboutImageUrlKey];
    [aCoder encodeObject:self.sizeImageUrl forKey:kGoodssizeImageUrlKey];
    [aCoder encodeObject:self.remarkImageUrl forKey:kGoodsremarkImageUrlKey];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.ID = [aDecoder decodeObjectForKey:kGoodsidKey];
        self.name = [aDecoder decodeObjectForKey:kGoodsnameKey];
        self.price = [aDecoder decodeObjectForKey:kGoodspriceKey];
        self.subClass = [aDecoder decodeObjectForKey:kGoodssubClassKey];
        self.sex = [aDecoder decodeObjectForKey:kGoodssexKey];
        self.minImageUrl1 = [aDecoder decodeObjectForKey:kGoodsminImageUrl1Key];
        self.minImageUrl2 = [aDecoder decodeObjectForKey:kGoodsminImageUrl2Key];
        self.minImageUrl3 = [aDecoder decodeObjectForKey:kGoodsminImageUrl3Key];
        self.descImageUrl1 = [aDecoder decodeObjectForKey:kGoodsdescImageUrl1Key];
        self.descImageUrl2 = [aDecoder decodeObjectForKey:kGoodsdescImageUrl2Key];
        self.descImageUrl3 = [aDecoder decodeObjectForKey:kGoodsdescImageUrl3Key];
        self.descImageUrl4 = [aDecoder decodeObjectForKey:kGoodsdescImageUrl4Key];
        self.descImageUrl5 = [aDecoder decodeObjectForKey:kGoodsdescImageUrl5Key];
        self.aboutImageUrl = [aDecoder decodeObjectForKey:kGoodsaboutImageUrlKey];
        self.sizeImageUrl = [aDecoder decodeObjectForKey:kGoodssizeImageUrlKey];
        self.remarkImageUrl = [aDecoder decodeObjectForKey:kGoodsremarkImageUrlKey];
    }
    return self;
}


@end
