//
//  FDDiscoverModel.m
//  T动衫魂
//
//  Created by asus on 16/5/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDiscoverModel.h"


@implementation FDDiscoverModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self.content = dict[kContentKey];
    self.name = dict[kNameKey];
    self.contentImageUrl = [NSString stringWithFormat:@"%@%@", kServerHostAddr, [dict objectForKey:kImageUrlKey]];
    
    return self;
}

+ (instancetype)discoverWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
