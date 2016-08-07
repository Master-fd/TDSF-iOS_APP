//
//  FDAddressModel.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAddressModel.h"

#define kIdKey       @"id"
#define kContactKey  @"contact"
#define kNumberKey   @"number"
#define kAddressKey  @"address"
#define kDefaultsKey     @"defaults"


@implementation FDAddressModel


- (instancetype)initWithDict:(NSDictionary *)dict
{
    self.ID = [[dict objectForKey:kIdKey] integerValue];
    self.number = [dict objectForKey:kNumberKey];
    self.contact = [dict objectForKey:kContactKey];
    self.address = [dict objectForKey:kAddressKey];
    self.defaults = [[dict objectForKey:kDefaultsKey] boolValue];
    
    return self;
}
+ (instancetype)addressWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
