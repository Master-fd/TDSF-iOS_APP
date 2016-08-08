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

@interface FDAddressModel()<NSCoding>

@end

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

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[@(self.ID) stringValue] forKey:kIdKey];
    [aCoder encodeObject:self.contact forKey:kContactKey];
    [aCoder encodeObject:self.number forKey:kNumberKey];
    [aCoder encodeObject:self.address forKey:kAddressKey];
    [aCoder encodeObject:[@(self.defaults) stringValue] forKey:kDefaultsKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.ID = [[aDecoder decodeObjectForKey:kIdKey] integerValue];
        self.contact = [aDecoder decodeObjectForKey:kContactKey];
        self.number = [aDecoder decodeObjectForKey:kNumberKey];
        self.address = [aDecoder decodeObjectForKey:kAddressKey];
        self.defaults = [[aDecoder decodeObjectForKey:kDefaultsKey] boolValue];
    }
    return self;

}

@end
