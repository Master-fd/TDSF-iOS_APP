//
//  FDAddressViewController.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAddressViewController.h"
#import "FDAddressModel.h"
#import "FDAddressCell.h"
#import "FDAddressEditController.h"

@interface FDAddressViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *addresses;
@end


@implementation FDAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadAddressesFromServer];
}

- (void)setupNav
{
    self.navigationItem.title = @"收货地址";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addAddress)];
    self.navigationItem.rightBarButtonItem = item;
    

}

- (void)setupViews
{
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    
    _tableView.rowHeight = 65;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[FDAddressCell class] forCellReuseIdentifier:kcellID];
    
    //添加约束
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addresses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) _weakSelf = self;
    FDAddressModel *model = self.addresses[indexPath.row];
    
    FDAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellID forIndexPath:indexPath];
    cell.defaultsDidClickBlock = ^(FDAddressModel *address){
        
        for (FDAddressModel *model in _weakSelf.addresses) {
            if (model.defaults && model!=address) {
                //修改默认地址
                model.defaults = NO;
                [FDHomeNetworkTool postAddressesWithName:[FDUserInfo shareFDUserInfo].name model:model operation:kOperationModifyKey success:nil failure:nil];
            }
        }
        //修改默认地址
        [FDHomeNetworkTool postAddressesWithName:[FDUserInfo shareFDUserInfo].name model:address operation:kOperationModifyKey success:nil failure:nil];
        [_weakSelf.tableView reloadData];
    };
    
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FDAddressEditController *vc = [[FDAddressEditController alloc] init];
    vc.model = self.addresses[indexPath.row];
    vc.isAddAddress = NO;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        __weak typeof(self) _weakSelf = self;
        [FDHomeNetworkTool postAddressesWithName:[FDUserInfo shareFDUserInfo].name model:self.addresses[indexPath.row] operation:kOperationDeleteKey success:^(NSArray *results) {
            //刷新
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:_weakSelf.addresses];
            [arrayM removeObjectAtIndex:indexPath.row];
            _weakSelf.addresses = [NSArray arrayWithArray:arrayM];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            });
        } failure:nil];
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
/**
 *  从网络中获取地址数据
 */
- (void)loadAddressesFromServer
{
    __weak typeof(self) _weakSelf = self;
    [FDHomeNetworkTool getAddressesWithName:[FDUserInfo shareFDUserInfo].name success:^(NSArray *results) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _weakSelf.addresses = results;
            [_weakSelf.tableView reloadData];
        });
    } failure:^(NSInteger statusCode, NSString *message) {
    }];
}
/**
 *  新增地址
 */
- (void)addAddress
{
    FDAddressEditController *editVc = [[FDAddressEditController alloc] init];
    editVc.isAddAddress = YES;
    editVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editVc animated:YES];
}
@end
