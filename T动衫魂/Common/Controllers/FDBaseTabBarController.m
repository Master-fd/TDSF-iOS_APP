//
//  FDBaseTabBarController.m
//  T动衫魂
//
//  Created by asus on 16/5/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseTabBarController.h"

@interface FDBaseTabBarController ()

@end

@implementation FDBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(void)initialize
{
//修改tabbar主题
    UITabBar *tabBar = [UITabBar appearance];
    
    tabBar.tintColor = kRoseColor;

}

@end
