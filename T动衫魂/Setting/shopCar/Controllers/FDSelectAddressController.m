//
//  FDSelectAddressController.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDSelectAddressController.h"
#import "FDOrderAddressCell.h"
#import "UITableView+FDTemplateLayoutCell.h"


#define addressReuseId  @"reuseAddressId"
@interface FDSelectAddressController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FDSelectAddressController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    
}


- (void)setupNav
{
    self.navigationItem.title = @"选择地址";
    
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
    
    //添加约束
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(_weakSelf.view);
    }];
   
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.addresses.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //显示地址
    FDOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressReuseId forIndexPath:indexPath];
    [self configWithCell:cell forRowAtIndexPath:indexPath];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) _weakSelf = self;
    return [tableView fd_heightForCellWithIdentifier:addressReuseId cacheByIndexPath:indexPath configuration:^(FDOrderAddressCell *cell) {
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
    if (self.didSelectAddressBlck) {
        FDAddressModel *address = self.addresses[indexPath.section];
        self.didSelectAddressBlck(address);
    }
}

/**
 *  配置cell
 */
- (void)configWithCell:(FDOrderAddressCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDAddressModel *address = self.addresses[indexPath.section];
    
    cell.address = address;
}
#pragma mark - 公共方法
- (void)setAddresses:(NSArray *)addresses
{
    _addresses = addresses;
    if (!_tableView) {
        [self setupViews];
    }
    
}
@end
