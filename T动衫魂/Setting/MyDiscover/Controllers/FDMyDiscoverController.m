//
//  FDMyDiscoverController.m
//  T动衫魂
//
//  Created by asus on 16/8/6.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyDiscoverController.h"
#import "FDDiscoverModel.h"
#import "FDMyDiscoverCell.h"
#import "FDMyDiscoverInfoController.h"


@interface FDMyDiscoverController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *discovers;
@end


@implementation FDMyDiscoverController

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
    self.navigationItem.title = @"我的买家秀";

    
}

- (void)setupViews
{
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    
    _tableView.rowHeight = 80;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
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
    return self.discovers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const reuseId = @"myDiscover";
    FDDiscoverModel *discover = self.discovers[indexPath.row];
    
    FDMyDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[FDMyDiscoverCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
        
    }
    
    cell.discover = discover;
 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FDMyDiscoverInfoController *vc = [[FDMyDiscoverInfoController alloc] init];
    vc.discover = self.discovers[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        __weak typeof(self) _weakSelf = self;
        FDDiscoverModel *discover = self.discovers[indexPath.row];
        [FDHomeNetworkTool postDeleteDiscoverWithName:[FDUserInfo shareFDUserInfo].name content:discover.content success:^(NSArray *results) {
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:_weakSelf.discovers];
            [arrayM removeObjectAtIndex:indexPath.row];
            _weakSelf.discovers = [NSArray arrayWithArray:arrayM];
            
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
    [FDHomeNetworkTool getDiscoversWithName:[FDUserInfo shareFDUserInfo].name success:^(NSArray *results) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _weakSelf.discovers = results;
            [_weakSelf.tableView reloadData];
        });
    } failure:^(NSInteger statusCode, NSString *message) {

    }];
}


@end
