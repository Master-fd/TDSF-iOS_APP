//
//  FDMyCollectViewController.m
//  T动衫魂
//
//  Created by asus on 16/5/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyCollectViewController.h"
#import "FDGoodsInfoController.h"
#import "FDMyCollectCell.h"
#import "FDCollectModel.h"



@interface FDMyCollectViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *collects;
@end

@implementation FDMyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];
}

- (void)setupNav
{
    self.navigationItem.title = @"我的收藏";
    
}

- (void)setupViews
{
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    
    _tableView.rowHeight = 65;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[FDMyCollectCell class] forCellReuseIdentifier:kcellID];
    
    //添加约束
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadMyCollectFromServer];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDCollectModel *model = self.collects[indexPath.row];

    FDMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellID forIndexPath:indexPath];
    
    cell.model = model.goodsInfoModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDCollectModel *model = self.collects[indexPath.row];
    FDGoodsInfoController *vc = [[FDGoodsInfoController alloc] init];
    vc.model = model.goodsInfoModel;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        __weak typeof(self) _weakSelf = self;
        FDCollectModel *model = self.collects[indexPath.row];
        [FDHomeNetworkTool postCollectWithName:[FDUserInfo shareFDUserInfo].name model:model operation:kOperationDeleteKey success:^(NSArray *results) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableArray *arrayM = [NSMutableArray arrayWithArray:_weakSelf.collects];
                [arrayM removeObjectAtIndex:indexPath.row];
                _weakSelf.collects = [NSArray arrayWithArray:arrayM];
                [_weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            });
        } failure:nil];
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/**
 *  从服务器获取信息
 */
- (void)loadMyCollectFromServer
{
    __weak typeof(self) _weakSelf = self;
    [FDHomeNetworkTool getCollectWithName:[FDUserInfo shareFDUserInfo].name success:^(NSArray *results) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _weakSelf.collects = results;
            [_weakSelf.tableView reloadData];
        });
        
    } failure:nil];
}


@end
