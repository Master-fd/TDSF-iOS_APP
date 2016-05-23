//
//  FDSettingViewController.m
//  T动衫魂
//
//  Created by asus on 16/5/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDSettingViewController.h"
#import "FDMyCollectViewController.h"
#import "FDAboutMeViewController.h"



@interface FDSettingViewController ()<UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FDSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];
}

- (void)setupNav
{
    self.navigationItem.title = @"设置";
    
}

- (void)setupViews
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.rowHeight = 50;
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //添加约束
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.section==0) {
        cell.imageView.image = [UIImage imageNamed:@"icon_collect_pre"];
        cell.textLabel.text = @"我的收藏";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  //显示小箭头
    }else if (indexPath.section==1) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"icon_AboutMe"];
            cell.textLabel.text = @"关于我们";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  //显示小箭头
            
        }else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"clearMem"];
            cell.textLabel.text = @"清除缓存";
            
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        FDMyCollectViewController *vc = [[FDMyCollectViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            FDAboutMeViewController *vc = [[FDAboutMeViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            //清空缓存
            UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alerView show];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            //清空收藏和数据库等等缓存
            [self clearDiskAllData];
            break;
            
        default:
            break;
    }
}

- (void)clearDiskAllData
{
    //先读取文件里面的内容
    NSArray *arrayM = [NSArray arrayWithContentsOfFile:kMyCollectPlistPath];
    NSMutableArray *data = [NSMutableArray arrayWithArray:arrayM];
    
    //删除所有
    [data removeAllObjects];
    
    [data writeToFile:kMyCollectPlistPath atomically:YES];
}



@end
