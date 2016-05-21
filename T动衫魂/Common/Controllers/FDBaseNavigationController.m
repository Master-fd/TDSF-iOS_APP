//
//  FDBaseNavigationController.m
//  T动衫魂
//
//  Created by asus on 16/5/15.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseNavigationController.h"

@interface FDBaseNavigationController ()

@end

@implementation FDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  设置导航栏主题
 */
+ (void)initialize
{
    UINavigationBar *navbar = [UINavigationBar appearance];
    
    navbar.barTintColor = kBlackColor;
    navbar.tintColor = kWhiteColor;
    
    NSMutableDictionary *titilAttrs = [NSMutableDictionary dictionary];
    titilAttrs[NSForegroundColorAttributeName] = kWhiteColor;
    [navbar setTitleTextAttributes:titilAttrs];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = kWhiteColor;
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    
}

/**
 *  修改状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
