//
//  FDInputView.m
//  School
//
//  Created by asus on 16/3/5.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDInputView.h"
#import "FDUserInfo.h"


@interface FDInputView()

//accountBgImg
@property (nonatomic, strong) UIImageView *accountBgImg;
//accountImg
@property (nonatomic, strong) UIImageView *accountImg;
//passwordBgImg
@property (nonatomic, strong) UIImageView *passwordBgImg;
//passwordImg
@property (nonatomic, strong) UIImageView *passwordImg;

@property (nonatomic, strong) UITextField *accountTxFeild;
@property (nonatomic, strong) UITextField *passwordTxFeild;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;

@end

@implementation FDInputView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];   //add 控件
        
        [self setupConstraint];  //设置约束
    }
    
    
    return self;
}


/**
 *  初始化views
 */
- (void)setupViews
{
    
    //accountBgImg
    _accountBgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_input_up"]];
    _accountBgImg.userInteractionEnabled = YES;
    [self addSubview:_accountBgImg];
    
    //accountImg
    _accountImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_username_select"]];
    _accountImg.userInteractionEnabled = YES;
    [_accountBgImg addSubview:_accountImg];

    //accountTxFeild
    self.accountTxFeild = [[UITextField alloc] init];
    [_accountBgImg addSubview:self.accountTxFeild];
    self.accountTxFeild.font = [UIFont systemFontOfSize:16];
    self.accountTxFeild.textColor = [UIColor whiteColor];
    self.accountTxFeild.placeholder = @"请输入账号";
    self.accountTxFeild.keyboardType = UIKeyboardTypeDefault;
    self.accountTxFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accountTxFeild.returnKeyType = UIReturnKeyJoin;

    //passwordBgImg
    _passwordBgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_input_down"]];
    [self addSubview:_passwordBgImg];
    _passwordBgImg.userInteractionEnabled = YES;
    
    //passwordImg
    _passwordImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password_select"]];
    _passwordImg.userInteractionEnabled = YES;
    [_passwordBgImg addSubview:_passwordImg];
    
    //passwordTxFeild
    self.passwordTxFeild = [[UITextField alloc] init];
    [_passwordBgImg addSubview:self.passwordTxFeild];
    self.passwordTxFeild.font = [UIFont systemFontOfSize:16];
    self.passwordTxFeild.textColor = [UIColor whiteColor];
    self.passwordTxFeild.placeholder = @"请输入密码";
    self.passwordTxFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTxFeild.keyboardType = UIKeyboardTypeDefault;
    self.passwordTxFeild.returnKeyType = UIReturnKeyJoin;
    self.passwordTxFeild.secureTextEntry = YES;
    
    //add 登录按钮
    UIImage *image = [UIImage imageNamed:@"UMS_shake__share_button"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 15, 10, 15) resizingMode:UIImageResizingModeStretch];
    self.loginBtn = [[UIButton alloc] init];
    [self addSubview:self.loginBtn];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    
    //add 注册按钮
    self.registerBtn = [[UIButton alloc] init];
    [self addSubview:self.registerBtn];
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 5;
    [self.registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [self.registerBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)setupConstraint
{
    __weak typeof(self) _weakSelf = self;
    CGFloat margin = 20;
    
    //accountBgImg
    [_accountBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_weakSelf).offset(margin);
        make.right.equalTo(_weakSelf).offset(-margin);
        make.height.mas_equalTo(40);
    }];
    
    //accountImg
    [_accountImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_weakSelf.accountBgImg).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    //accountTxFeild
    [_accountTxFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.accountImg.mas_right).offset(15);
        make.top.bottom.equalTo(_weakSelf.accountBgImg);
        make.right.equalTo(_weakSelf.accountBgImg).offset(-5);
    }];
    
    //passwordBgImg
    [_passwordBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf).offset(margin);
        make.top.equalTo(_weakSelf.accountBgImg.mas_bottom).offset(5);
        make.right.equalTo(_weakSelf).offset(-margin);
        make.height.mas_equalTo(40);
    }];
    
    //passwordImg
    [_passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_weakSelf.passwordBgImg).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    //passwordTxFeild
    [_passwordTxFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf.passwordImg.mas_right).offset(15);
        make.top.bottom.equalTo(_weakSelf.passwordBgImg);
        make.right.equalTo(_weakSelf.passwordBgImg).offset(-5);
    }];
    
    //add 登录图标
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf).offset(margin);
        make.top.equalTo(_weakSelf.passwordBgImg.mas_bottom).offset(50);
        make.right.equalTo(_weakSelf).offset(-margin);
        make.height.mas_equalTo(40);
    }];
    
    //add register图标
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weakSelf).offset(margin);
        make.top.equalTo(_weakSelf.loginBtn.mas_bottom).offset(15);
        make.right.equalTo(_weakSelf).offset(-margin);
        make.height.mas_equalTo(40);
    }];
}

/**
 *  检测输入的合法性
 */
- (BOOL)checkInputContent
{
    //退出第一响应者身份
    [self endEditing:YES];
    
    //验证账号和密码是否符合要求
    NSString *accountStr = self.accountTxFeild.text;
    NSString *passwordStr = self.passwordTxFeild.text;
    
    if ((accountStr.length >= 15) || (accountStr.length < 6)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"合法账号长度6-15个字符"];
        });
        
        [self.accountTxFeild becomeFirstResponder];
        return NO;
    }
    if (passwordStr.length >= 15 || (passwordStr.length < 6) ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"合法密码长度6-15个字符"];
        });
        [self.passwordTxFeild becomeFirstResponder];
        return NO;
    }
    
    return YES;
}
/**
 *  按钮单击事件
 */
- (void)loginClick
{
    if ([self checkInputContent]) {
        //传递账户和密码
        if (self.loginBtnClickBlock) {
            self.loginBtnClickBlock(self.accountTxFeild.text, self.passwordTxFeild.text);
        }
    }
    
}
/**
 *  单击了注册
 */
- (void)registerClick
{
    if ([self checkInputContent]) {
        //传递账户和密码
        if (self.registerBtnClickBlock) {
            self.registerBtnClickBlock(self.accountTxFeild.text, self.passwordTxFeild.text);
        }
    }
    
}



@end
