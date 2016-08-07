//
//  FDAddressModel.h
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FDAddressModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) BOOL defaults;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)addressWithDict:(NSDictionary *)dict;

@end
