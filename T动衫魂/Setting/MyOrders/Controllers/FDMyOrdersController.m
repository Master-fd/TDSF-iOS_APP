//
//  FDMyOrdersController.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyOrdersController.h"
#import "FDMyOrderCell.h"
#import "FDOrderModel.h"
#import "FDMyOrderInfoController.h"
#import "UITableView+FDTemplateLayoutCell.h"

#define kReuseId  @"reuseorderId"
@interface FDMyOrdersController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *OrderGoodses;
@end

@implementation FDMyOrdersController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setupNav];
    
    [self setupViews];
    
    //载入所有订单
    [self loadOrderInfoFromServer];
    
}
- (void)setupNav
{
    self.navigationItem.title = @"我的订单";
    
}

- (void)setupViews
{
    __weak typeof(self) _weakSelf = self;
    
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[FDMyOrderCell class] forCellReuseIdentifier:kReuseId];
    //添加约束
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(_weakSelf.view);
    }];
    
    
}

/**
 *  获取order 从服务器
 */
- (void)loadOrderInfoFromServer
{
    __weak typeof(self) _weakSelf = self;
    [FDHomeNetworkTool getOrderWithName:[FDUserInfo shareFDUserInfo].name success:^(NSArray *results) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _weakSelf.OrderGoodses = results;
            [_weakSelf.tableView reloadData];
        });
    } failure:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.OrderGoodses.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    FDMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseId forIndexPath:indexPath];
    
    [self configWithCell:cell forRowAtIndexPath:indexPath];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除一个订单
        __weak typeof(self) _weakSelf = self;
        NSString *status = @"已下单";  //这个在删除的时候没有实际意义，只是为了不保存，因为不能给字典插入nil对象
        [FDHomeNetworkTool postOrderWithName:[FDUserInfo shareFDUserInfo].name model:self.OrderGoodses[indexPath.section] status:status operation:kOperationDeleteKey success:^(NSArray *results) {
            //刷新
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:_weakSelf.OrderGoodses];
            [arrayM removeObjectAtIndex:indexPath.section];
            _weakSelf.OrderGoodses = [NSArray arrayWithArray:arrayM];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            });

        } failure:nil];
            
            
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) _weakSelf = self;
    return [tableView fd_heightForCellWithIdentifier:kReuseId cacheByIndexPath:indexPath configuration:^(id cell) {
        [_weakSelf configWithCell:cell forRowAtIndexPath:indexPath];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FDMyOrderInfoController *vc = [[FDMyOrderInfoController alloc] init];
    vc.order = self.OrderGoodses[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  配置cell数据
 */
- (void)configWithCell:(FDMyOrderCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDOrderModel *orderModel = self.OrderGoodses[indexPath.section];
    cell.orderModel = orderModel;
}

@end
