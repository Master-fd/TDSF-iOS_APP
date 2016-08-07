//
//  FDUserInfo.h
//  T动衫魂
//
//  Created by asus on 16/8/4.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDUserInfo : NSObject

+ (instancetype)shareFDUserInfo;

/**
 *  账户
 */
@property (nonatomic, copy) NSString *name;

/**
 *  密码
 */
@property (nonatomic, copy) NSString *password;

/**
 *  是否已经登录
 */
@property (nonatomic, assign) BOOL isLogin;


- (void)saveUserInfoToSabox;

- (void)readUserInfoFromSabox;
@end
