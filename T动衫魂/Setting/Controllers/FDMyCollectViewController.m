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
#import "FDGoodsModel.h"



@interface FDMyCollectViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FDGoodsModel *model = self.dataSource[indexPath.row];
   
    FDMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellID forIndexPath:indexPath];
    
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FDGoodsInfoController *vc = [[FDGoodsInfoController alloc] init];
    vc.model = self.dataSource[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteGoodsWithPlist:indexPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/**
 *  删除一条应聘信息
 */
- (void)deleteGoodsWithPlist:(NSIndexPath *)indexPath
{
    //删除一条数据
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.dataSource];
    [arrayM removeObjectAtIndex:indexPath.row];
    self.dataSource = arrayM;
    //先读取数据
    NSMutableArray *data = [NSMutableArray arrayWithContentsOfFile:kMyCollectPlistPath];
    [data removeObjectAtIndex:indexPath.row];
    //重新写入
    [data writeToFile:kMyCollectPlistPath atomically:YES];
}

/**
 *  懒加载
 *
 *  @return datasource
 */
- (NSArray *)dataSource
{
    if (!_dataSource) {
        //从plist里面加载所有数据
        NSArray *data = [NSArray arrayWithContentsOfFile:kMyCollectPlistPath];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            FDGoodsModel *model = [FDGoodsModel goodsWithDict:dic];
            [arrayM addObject:model];
        }
        _dataSource = arrayM;
    }

    return _dataSource;
}

/**
 *  收藏
 */
- (void)collectBtnDidClick
{
    
}
@end
