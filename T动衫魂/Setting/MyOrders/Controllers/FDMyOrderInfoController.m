//
//  FDMyOrderInfoController.m
//  T动衫魂
//
//  Created by asus on 16/8/8.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyOrderInfoController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FDOrderAddressCell.h"
#import "FDStatusBarView.h"
#import "FDOrderModel.h"
#import "FDOrderCell.h"
#import "FDShoppingCartModel.h"


#define addressReuseId  @"reuseAddressId"

@interface FDMyOrderInfoController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) FDStatusBarView *statusBarView;

@end

@implementation FDMyOrderInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    
}


- (void)setupNav
{
    self.navigationItem.title = @"订单详情";
    
}

- (void)setupViews
{
    __weak typeof(self) _weakSelf = self;
    
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[FDOrderAddressCell class] forCellReuseIdentifier:addressReuseId];
    
    _statusBarView = [[FDStatusBarView alloc] init];
    [self.view insertSubview:_statusBarView aboveSubview:_tableView];
    
    //添加约束
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_weakSelf.view);
        make.bottom.equalTo(_weakSelf.statusBarView.mas_top);
    }];
    
    //添加约束
    [_statusBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(_weakSelf.view);
        make.height.mas_equalTo(44);
    }];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //+1是因为有一个地址
    return self.order.shoppingCartModels.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        //显示地址
        FDOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressReuseId forIndexPath:indexPath];
        cell.address = self.order.address;
        return cell;
    }else{
        NSString * const reuseId = @"reuseorderId";
        FDOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (!cell) {
            cell = [[FDOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        FDShoppingCartModel *goodsModel = self.order.shoppingCartModels[indexPath.section-1];
        cell.goodsModel = goodsModel;
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        __weak typeof(self) _weakSelf = self;
        return [tableView fd_heightForCellWithIdentifier:addressReuseId cacheByIndexPath:indexPath configuration:^(FDOrderAddressCell *cell) {
            cell.address = _weakSelf.order.address;
        }];
    }else{
        height = [FDOrderCell height];
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)setOrder:(FDOrderModel *)order
{
    _order = order;
    if (!_tableView) {
        [self setupViews];
    }
    __block CGFloat sumPrice = 0;
    [self.order.shoppingCartModels enumerateObjectsUsingBlock:^(FDShoppingCartModel *obj, NSUInteger idx, BOOL *stop) {
        
        if (obj.isSelect) {
            sumPrice += obj.sumPrice;
        }
    }];
    _statusBarView.sumPrice = sumPrice;
    _statusBarView.status = self.order.status;
}
@end

