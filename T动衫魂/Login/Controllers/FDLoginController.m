//
//  FDLoginController.m
//  School
//   登录和注册界面控制器
//  Created by asus on 16/3/5.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDLoginController.h"
#import "FDInputView.h"


@interface FDLoginController ()

@property (nonatomic, strong) UIImageView *bgImg;  //背景

@property (nonatomic, strong) FDInputView *inputView;   //inputview

@property (nonatomic, strong) UIButton *backBtn;  //返回Btn

@end

@implementation FDLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews]; //初始化控件
    [self setupContraint];
   
}

- (void)setupViews
{
    __weak typeof(self) _weakSelf = self;
    //设置导航栏标题
    [self.navigationItem setTitle:@"欢迎"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sky0.jpg" ofType:nil];
    //add  背景
    _bgImg = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
    [self.view addSubview:_bgImg];
    _bgImg.alpha = 1.0;
    _bgImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureReturnKeyboard)];
    [_bgImg addGestureRecognizer:tapGesture];
    
    //返回btn
    _backBtn = [[UIButton alloc] init];
    [_bgImg addSubview:_backBtn];
    [_backBtn setImage:[UIImage imageNamed:@"UMS_shake_close_tap"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"UMS_shake_close"] forState:UIControlStateHighlighted];
    [_backBtn addTarget:self action:@selector(backBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //add 输入框view
    _inputView = [[FDInputView alloc] init];
    [_bgImg addSubview:_inputView];
    _inputView.loginBtnClickBlock = ^(NSString *account, NSString *password){
        [_weakSelf userLoginWithAccount:account password:password];
    };
    
    _inputView.registerBtnClickBlock = ^(NSString *account, NSString *password){
        [_weakSelf userRegisterWithAccount:account password:password];
    };
    
}

/**
 *  添加约束
 */
- (void)setupContraint
{
    __weak typeof(self) _weakSelf = self;
    //_bgImg
    [_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //backbtn
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(_weakSelf.bgImg.mas_top).offset(20);
        make.right.equalTo(_weakSelf.bgImg.mas_right).offset(-10);
    }];
    
    //inputView
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.bottom.equalTo(_weakSelf.view);
        make.leading.trailing.mas_equalTo(_weakSelf.view);
        
    }];
    
}


- (void)userLoginWithAccount:(NSString *)account password:(NSString *)password
{
    __weak typeof(self) _weakSelf = self;
    [FDMBProgressHUB showMessage:@"正在登录..."];
    [FDHomeNetworkTool userLoginWithName:account password:password success:^(NSArray *results) {
        [FDMBProgressHUB hideHUD];
        [NSThread sleepForTimeInterval:0.5];
        //保存账户数据到sabox
        [[FDUserInfo shareFDUserInfo] saveUserInfoToSabox];
        //登录成功,跳转
        [_weakSelf backBtnDidClick:nil];
    } failure:^(NSInteger statusCode, NSString *message) {
        [FDMBProgressHUB hideHUD];
        [FDMBProgressHUB showError:@"登录失败"];
    }];
}
- (void)userRegisterWithAccount:(NSString *)account password:(NSString *)password
{
    __weak typeof(self) _weakSelf = self;
    [FDHomeNetworkTool userRegisterWithName:account password:password success:^(NSArray *results) {
        //注册成功，直接登录
        [_weakSelf userLoginWithAccount:account password:password];
    } failure:^(NSInteger statusCode, NSString *message) {
        
        if (statusCode == networdStatusExist) {
            [FDMBProgressHUB showError:@"用户名已存在"];
        } else {
            [FDMBProgressHUB showError:@"注册失败"];
        }
    }];
}

/**
 *  单击退出
 */
- (void)backBtnDidClick:(UIButton *)btn
{
 
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  单击界面，收回键盘
 */
- (void)tapGestureReturnKeyboard
{
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
