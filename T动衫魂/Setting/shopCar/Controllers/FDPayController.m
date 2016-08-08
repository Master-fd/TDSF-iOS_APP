//
//  FDPayController.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDPayController.h"
#import "FDConfirmOrderBarView.h"
#import "FDOrderCell.h"
#import "FDShoppingCartModel.h"
#import "FDOrderAddressCell.h"
#import "FDAddressModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FDOrderModel.h"

#define addressReuseId  @"reuseAddressId"
@interface FDPayController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//下单bar
@property (nonatomic, strong) FDConfirmOrderBarView *costBarView;

@end

@implementation FDPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //显示地址，单击可以选择地址
    
    //显示商品详情
    
    //确定提交
    
    [self setupNav];
    
    
}


- (void)setupNav
{
    self.navigationItem.title = @"确认订单";
    
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
    
    _costBarView = [[FDConfirmOrderBarView alloc] init];
    [self.view insertSubview:_costBarView aboveSubview:_tableView];
    
    _costBarView.costSumDidClick = ^{
        //所有的商品,下单
        [_weakSelf saveOrderInfoToServer]; //保存信息到服务器
        //界面跳转到成功
    };
    
    //添加约束
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_weakSelf.view);
        make.bottom.equalTo(_weakSelf.costBarView.mas_top);
    }];
    
    //添加约束
    [_costBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(_weakSelf.view);
        make.height.mas_equalTo(44);
    }];
    
    
}

/**
 *  保存商品数据到order服务器
 */
- (void)saveOrderInfoToServer
{
    __weak typeof(self) _weakSelf = self;
    FDOrderModel *order = [[FDOrderModel alloc] init];
    order.address = self.address;
    order.shoppingCartModels = self.OrderGoodses;
    [FDHomeNetworkTool postOrderWithName:[FDUserInfo shareFDUserInfo].name model:order status:@"已下单" operation:kOperationAddKey success:^(NSArray *results) {
        //删除购物车数据
        
        //已下单,删除购物车对应的数据,返回
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showSuccess:@"已下单"];
        });
        [order.shoppingCartModels enumerateObjectsUsingBlock:^(FDShoppingCartModel *obj, NSUInteger idx, BOOL *stop) {
            
            [FDHomeNetworkTool postShoppingCartGoodsWithName:[FDUserInfo shareFDUserInfo].name model:obj operation:kOperationDeleteKey success:nil failure:nil];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.8*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [_weakSelf.navigationController popViewControllerAnimated:YES];  //返回
        });
        
        
    } failure:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.OrderGoodses.count+1;
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
        cell.address = self.address;
        return cell;
    }else{
        NSString * const reuseId = @"reuseorderId";
        FDOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (!cell) {
            cell = [[FDOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        FDShoppingCartModel *goodsModel = self.OrderGoodses[indexPath.section-1];
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
            cell.address = _weakSelf.address;
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
- (void)setOrderGoodses:(NSArray *)OrderGoodses
{
    _OrderGoodses = OrderGoodses;
    if (!_tableView) {
        [self setupViews];
    }
    __block CGFloat sumPrice = 0;
    [self.OrderGoodses enumerateObjectsUsingBlock:^(FDShoppingCartModel *obj, NSUInteger idx, BOOL *stop) {
        
        if (obj.isSelect) {
            sumPrice += obj.sumPrice;
        }
    }];
    _costBarView.sumPrice = sumPrice;
}

@end
