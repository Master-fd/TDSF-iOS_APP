//
//  FDAboutMeViewController.m
//  T动衫魂
//
//  Created by asus on 16/5/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAboutMeViewController.h"

@interface FDAboutMeViewController ()

@end

@implementation FDAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];
}

- (void)setupNav
{
    self.navigationItem.title = @"关于我们";
}


- (void)setupViews
{
    self.view.backgroundColor = kWhiteColor;
    //头像
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_AboutMeMax"]];
    imageView.layer.cornerRadius = 35;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    __weak typeof(self) _weakSelf = self;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@70);
        make.width.equalTo(@70);
        make.centerX.equalTo(_weakSelf.view.mas_centerX);
        make.top.equalTo(_weakSelf.view).with.offset(10);
    }];
    
    //版本
    UILabel *versionLab = [[UILabel alloc] init];
    [self.view addSubview:versionLab];
    versionLab.textColor = kDeepGreyColor;
    versionLab.text = @"Version:1.0.0";
    versionLab.backgroundColor = [UIColor clearColor];
    versionLab.font = [UIFont systemFontOfSize:14];
    
    [versionLab sizeToFit];
    [versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).with.offset(10);
        make.centerX.equalTo(imageView);
    }];
    
    //关于我们
    UILabel *contentLab = [[UILabel alloc] init];
    [self.view addSubview:contentLab];
    contentLab.text = @"T动班魂成立于2012年惠州市惠城区马庄，是一家集设计生产于一体的正规商家，主要以个性定制班服、情侣服、卫衣等服装";
    contentLab.textColor = kDeepGreyColor;
    contentLab.font = [UIFont systemFontOfSize:14];
    contentLab.backgroundColor = [UIColor clearColor];
    contentLab.numberOfLines = 0;
    
    [contentLab sizeToFit];
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(versionLab.mas_bottom).with.offset(10);
        make.left.equalTo(_weakSelf.view).with.offset(12);
        make.right.equalTo(_weakSelf.view.mas_right).with.offset(-12);
        
    }];
    
}


@end
