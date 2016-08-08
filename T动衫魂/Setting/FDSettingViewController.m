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
#import "FDAddressViewController.h"
#import "FDShopCarViewController.h"
#import "FDMyDiscoverController.h"
#import "FDLoginController.h"
#import "FDCellItem.h"
#import "FDLoginViewCell.h"
#import "FDMyOrdersController.h"


@interface FDSettingViewController ()<UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *groups;

@property (nonatomic, strong) UIAlertView *alerView;
@end

@implementation FDSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setupViews
{
    self.navigationItem.title = @"我";
    
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

- (NSArray *)groups
{
    
    if (!_groups) {
        
        __weak typeof(self) _weakSelf = self;
        
        FDCellItem *group1item1 = [FDCellItem itemWithTitle:@"我的收藏" image:[UIImage imageNamed:@"icon_collect_pre"] indicator:YES didSelectBlock:^{
            if ([FDUserInfo shareFDUserInfo].isLogin) {
                FDMyCollectViewController *vc = [[FDMyCollectViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [_weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                FDLoginController *vc = [[FDLoginController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            }

        }];
        FDCellItem *group1item2 = [FDCellItem itemWithTitle:@"我的买家秀" image:[UIImage imageNamed:@"icon_find_pre"] indicator:YES didSelectBlock:^{
            
            if ([FDUserInfo shareFDUserInfo].isLogin) {
                FDMyDiscoverController *vc = [[FDMyDiscoverController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [_weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                FDLoginController *vc = [[FDLoginController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            }
            
        }];
        FDCellItem *group1item3 = [FDCellItem itemWithTitle:@"我的订单" image:[UIImage imageNamed:@"LLTakeoutFlowFirstEnabled"] indicator:YES didSelectBlock:^{
            
            if ([FDUserInfo shareFDUserInfo].isLogin) {
                FDMyOrdersController *vc = [[FDMyOrdersController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [_weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                FDLoginController *vc = [[FDLoginController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            }
            
        }];
        FDCellItem *group1item4 = [FDCellItem itemWithTitle:@"收货地址" image:[UIImage imageNamed:@"LLStorePin"] indicator:YES didSelectBlock:^{
            
            if ([FDUserInfo shareFDUserInfo].isLogin) {
                FDAddressViewController *vc = [[FDAddressViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [_weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                FDLoginController *vc = [[FDLoginController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            }
            
        }];
        FDCellItem *group1Item5 = [FDCellItem itemWithTitle:@"购物车" image:[UIImage imageNamed:@"icon_shopCar_nor"] indicator:YES didSelectBlock:^{
            
            if ([FDUserInfo shareFDUserInfo].isLogin) {
                FDShopCarViewController *vc = [[FDShopCarViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [_weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                FDLoginController *vc = [[FDLoginController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            }

            
        }];

        
        
        FDCellItem *group2item1 = [FDCellItem itemWithTitle:@"清空缓存" image:[UIImage imageNamed:@"clearMem"] indicator:NO didSelectBlock:^{
            //清空缓存
            _weakSelf.alerView = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [_weakSelf.alerView show];
            
        }];
        FDCellItem *group2item2 = [FDCellItem itemWithTitle:@"关于我们" image:[UIImage imageNamed:@"icon_AboutMe"] indicator:YES didSelectBlock:^{
            FDAboutMeViewController *vc = [[FDAboutMeViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [_weakSelf.navigationController pushViewController:vc animated:YES];
            
        }];
        
        //登录cell，这里只是为了添加一个项目而已
        FDCellItem *group3item1 = [[FDCellItem alloc] init];
        
        
        NSArray *group1 = @[group1item1, group1item2, group1item3, group1item4, group1Item5];
        NSArray *group2 = @[group2item1, group2item2];
        NSArray *group3 = @[group3item1];
        
        _groups = @[group1, group2, group3];
    }
    
    return _groups;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *group = self.groups[section];
    
    return group.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == self.groups.count-1) {
        //最后一组，最后一个为loginbtn
        NSString * const cellID = @"logincellID";
        FDLoginViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            __weak typeof(self) _weakSelf = self;
            cell = [[FDLoginViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.btnDidClickBlock = ^(UIButton *btn){
                
                if ([FDUserInfo shareFDUserInfo].isLogin) {
                    //注销
                    [FDUserInfo shareFDUserInfo].isLogin = NO;
                    [FDUserInfo shareFDUserInfo].name = nil;
                    [FDUserInfo shareFDUserInfo].password = nil;
                    [[FDUserInfo shareFDUserInfo] saveUserInfoToSabox];
                    btn.selected = [FDUserInfo shareFDUserInfo].isLogin;
                    //注销之后，进去登录界面
                    FDLoginController *vc = [[FDLoginController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [_weakSelf presentViewController:vc animated:YES completion:nil];
                } else {
                    
                    //进去登录界面
                    FDLoginController *vc = [[FDLoginController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [_weakSelf presentViewController:vc animated:YES completion:nil];
                }
            };
        }
        cell.loginStatus = [FDUserInfo shareFDUserInfo].isLogin;

        return cell;
    }else{
        NSString * const cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *group = self.groups[indexPath.section];
        FDCellItem *item = group[indexPath.row];
        cell.imageView.image = item.image;
        cell.textLabel.text = item.title;
        
        if (item.showIndicator) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  //显示小箭头
        }
        
        return cell;
    }

    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *group = self.groups[indexPath.section];
    FDCellItem *item = group[indexPath.row];
    if (item.optionBlock) {
        item.optionBlock();
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
    FDLog(@"清空缓存");

}



@end
