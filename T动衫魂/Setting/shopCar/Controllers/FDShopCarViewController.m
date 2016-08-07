//
//  FDShopCarViewController.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDShopCarViewController.h"
#import "FDShoppingCartModel.h"
#import "FDGoodsModel.h"
#import "FDShopCarViewCell.h"
#import "FDGoodsInfoController.h"
#import "FDCostBarView.h"




@interface FDShopCarViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//下单bar
@property (nonatomic, strong) FDCostBarView *costBarView;

//购物车所有商品，存放FDGoodsModel信息，单击商品跳转到对应的商品详情需要这个
//购物车所有商品，存放FDShoppingCartModel信息,购物车显示需要
@property (nonatomic, strong) NSArray *shopCarGoods;

//总价格
@property (nonatomic, assign) CGFloat allCost;

@end


@implementation FDShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //联网获取最新的数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadShoppingCartGoodsFromServer];
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //同步保存到服务器
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self saveShoppingCartGoodsToServer];
    });
  
}
- (void)setupNav
{
    self.navigationItem.title = @"购物车";
    
}

- (void)setupViews
{
    __weak typeof(self) _weakSelf = self;
    
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    
    _tableView.rowHeight = [FDShopCarViewCell height];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[FDShopCarViewCell class] forCellReuseIdentifier:@"reuseId"];
    
    
    _costBarView = [[FDCostBarView alloc] init];
    [self.view insertSubview:_costBarView aboveSubview:_tableView];
    _costBarView.selectDidClick = ^(BOOL selected){
        //全选box被选中
        [_weakSelf.shopCarGoods enumerateObjectsUsingBlock:^(FDShoppingCartModel *obj, NSUInteger idx, BOOL *stop) {
            obj.isSelect = selected;
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:_weakSelf.shopCarGoods];
            arrayM[idx] = obj;
            _weakSelf.shopCarGoods = [NSArray arrayWithArray:arrayM];
        }];
        [_weakSelf updateCostBarInfo]; //更新bar
        //更新cell
        [_weakSelf.tableView reloadData];
    };
    _costBarView.costSumDidClick = ^{
        //所有的商品,下单
        if (_weakSelf.allCost != 0) {
            FDLog(@"下单");
        } else {
            [FDMBProgressHUB showError:@"没有选择商品"];
        }
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
 *  从服务器获取购物车数据
 */
- (void)loadShoppingCartGoodsFromServer
{
     __weak typeof(self) _weakSelf = self;
    [FDHomeNetworkTool getShoppingCartGoodsWithName:[FDUserInfo shareFDUserInfo].name success:^(NSArray *results) {
        _weakSelf.shopCarGoods = results;
        [_weakSelf updateCostBarInfo];
        [_weakSelf.tableView reloadData];
    } failure:^(NSInteger statusCode, NSString *message) {
        [FDMBProgressHUB showError:@"你还没有选购商品，赶紧挑选吧"];
    }];

}

/**
 *  保存购物车数据到服务器
 */
- (void)saveShoppingCartGoodsToServer
{
    for (FDShoppingCartModel *newGoodsModel in self.shopCarGoods) {
        [FDHomeNetworkTool postShoppingCartGoodsWithName:[FDUserInfo shareFDUserInfo].name model:newGoodsModel operation:kOperationModifyKey success:nil failure:nil];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopCarGoods.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) _weakSelf = self;
    FDShopCarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseId" forIndexPath:indexPath];
    
    FDShoppingCartModel *goodsModel = self.shopCarGoods[indexPath.row];
    cell.goodsModel = goodsModel;
    cell.updateGoodsModelBlock = ^(FDShoppingCartModel *newGoodsModel){
        
        [_weakSelf updateCostBarInfo]; //更新bar显示
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FDGoodsInfoController *vc = [[FDGoodsInfoController alloc] init];
    FDShoppingCartModel *selectModel = self.shopCarGoods[indexPath.row];
    vc.model = selectModel.goodsInfoModel;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        __weak typeof(self) _weakSelf = self;
        [FDHomeNetworkTool postShoppingCartGoodsWithName:[FDUserInfo shareFDUserInfo].name model:self.shopCarGoods[indexPath.row] operation:kOperationDeleteKey success:^(NSArray *results) {
            
            //刷新
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:_weakSelf.shopCarGoods];
            [arrayM removeObjectAtIndex:indexPath.row];
            _weakSelf.shopCarGoods = [NSArray arrayWithArray:arrayM];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            });
            [_weakSelf updateCostBarInfo];//更新购物车bar显示信息
        } failure:nil];
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/**
 *  更新下单bar的显示
 */
- (void)updateCostBarInfo
{
    __weak typeof(self) _weakSelf = self;
    __block NSUInteger selectGoodsCount = 0;
    
    self.allCost = 0;
    [self.shopCarGoods enumerateObjectsUsingBlock:^(FDShoppingCartModel *obj, NSUInteger idx, BOOL *stop) {
        if (obj.isSelect) { //遍历，累加选中的商品
            _weakSelf.allCost += obj.sumPrice;
            selectGoodsCount ++;
        }

    }];
    
    //更新价钱
    self.costBarView.priceValueLab.text = [NSString stringWithFormat:@"￥%.02f", self.allCost];
    if (selectGoodsCount == self.shopCarGoods.count) {
        //购物车的goods数量和选中的数量相同
        self.costBarView.checkBoxBtn.selected = YES; //更新bar的全选框
    }else{
        self.costBarView.checkBoxBtn.selected = NO; //更新bar的全选框
    }
}



@end
