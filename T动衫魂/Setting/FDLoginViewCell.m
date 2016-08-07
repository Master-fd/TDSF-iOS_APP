//
//  FDLoginViewCell.m
//  T动衫魂
//
//  Created by asus on 16/8/5.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDLoginViewCell.h"

@interface FDLoginViewCell()

@property (nonatomic, strong) UIButton *loginBtn;

@end
@implementation FDLoginViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //btn
        _loginBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_loginBtn];
        _loginBtn.layer.cornerRadius = 4;
        [_loginBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kRoseColor forState:UIControlStateSelected];
        [_loginBtn setTitle:@"登      录" forState:UIControlStateNormal];
        [_loginBtn setTitle:@"退      出" forState:UIControlStateSelected];
        [_loginBtn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    
    return self;
}

- (void)btnDidClick:(UIButton *)btn
{
    if (self.btnDidClickBlock) {
        self.btnDidClickBlock(btn);
    }
}

- (void)setLoginStatus:(BOOL)loginStatus
{
    _loginStatus = loginStatus;
    _loginBtn.selected = loginStatus;
}
@end
