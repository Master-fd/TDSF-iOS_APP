//
//  FDUserInfo.m
//  T动衫魂
//
//  Created by asus on 16/8/4.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDUserInfo.h"

#define kNamgeKey    @"name"
#define kPasswordKey    @"password"


@implementation FDUserInfo

static FDUserInfo *_instance=nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t once_taken;
    dispatch_once(&once_taken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

+ (instancetype)shareFDUserInfo
{
    if (!_instance) {
        _instance = [[FDUserInfo alloc] init];
    }
    
    return _instance;
}


- (void)saveUserInfoToSabox
{
    [[NSUserDefaults standardUserDefaults] setObject:self.name forKey:kNamgeKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.password forKey:kPasswordKey];
}

- (void)readUserInfoFromSabox
{
    self.name = [[NSUserDefaults standardUserDefaults] objectForKey:kNamgeKey];
    self.password = [[NSUserDefaults standardUserDefaults] objectForKey:kPasswordKey];
}


@end
