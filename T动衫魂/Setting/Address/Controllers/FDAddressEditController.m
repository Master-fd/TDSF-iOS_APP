//
//  FDAddressEditController.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAddressEditController.h"
#import "FDAddressModel.h"
#import "FDAddrEditView.h"


@interface FDAddressEditController ()

@property (nonatomic, strong) FDAddrEditView *nameView;
@property (nonatomic, strong) FDAddrEditView *numberView;
@property (nonatomic, strong) FDAddrEditView *addressView;


@end

@implementation FDAddressEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self setupContraints];
}


- (void)setupViews
{
    self.navigationItem.title = @"编辑地址";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDidClick)];
    [self.view addGestureRecognizer:tapGesture];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.nameView = [[FDAddrEditView alloc] init];
    [self.view addSubview:self.nameView];
    self.nameView.nameLab.text = @"联 系 人:";
    
    self.numberView = [[FDAddrEditView alloc] init];
    [self.view addSubview:self.numberView];
    self.numberView.nameLab.text = @"手机号码:";
    
    self.addressView = [[FDAddrEditView alloc] init];
    [self.view addSubview:self.addressView];
    self.addressView.nameLab.text = @"详细地址:";
    
    
}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
    
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.view.mas_top);
        make.leading.trailing.mas_equalTo(_weakSelf.view);
        make.height.mas_equalTo(44);
    }];
    
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.nameView.mas_bottom);
        make.leading.trailing.mas_equalTo(_weakSelf.view);
        make.height.mas_equalTo(44);
    }];
    
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_weakSelf.numberView.mas_bottom);
        make.leading.trailing.mas_equalTo(_weakSelf.view);
        make.height.mas_equalTo(120);
    }];
}

- (void)save
{
    [self.view endEditing:YES];
    __weak typeof(self) _weakSelf = self;
    if (self.isAddAddress) { //添加地址
        FDAddressModel *address = [[FDAddressModel alloc] init];
        address.contact = self.nameView.nameTextView.text;
        address.number = self.numberView.nameTextView.text;
        address.address = self.addressView.nameTextView.text;
        [FDHomeNetworkTool postAddressesWithName:[FDUserInfo shareFDUserInfo].name model:address operation:kOperationAddKey success:^(NSArray *results) {
            [_weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSInteger statusCode, NSString *message) {
            [_weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        
    }else{  //修改地址
        self.model.contact = self.nameView.nameTextView.text;
        self.model.number = self.numberView.nameTextView.text;
        self.model.address = self.addressView.nameTextView.text;
        [FDHomeNetworkTool postAddressesWithName:[FDUserInfo shareFDUserInfo].name model:self.model operation:kOperationModifyKey success:^(NSArray *results) {
            [_weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(NSInteger statusCode, NSString *message) {
            [_weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    
}

- (void)tapGestureDidClick
{
    [self.view endEditing:YES];
}

- (void)setModel:(FDAddressModel *)model
{
    _model = model;
    
    if (!_nameView) {
        [self setupViews];
        
        [self setupContraints];
    }
    self.nameView.nameTextView.text = model.contact;
    self.numberView.nameTextView.text = model.number;
    self.addressView.nameTextView.text = model.address;

}


@end
