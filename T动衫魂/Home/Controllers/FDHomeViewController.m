//
//  FDViewController.m
//  T动衫魂
//
//  Created by asus on 16/5/15.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDHomeViewController.h"
#import "FDHomeCollectionViewCell.h"
#import "FDGoodsModel.h"
#import "FDGoodsInfoController.h"
#import "FDGoodsSelectBarView.h"


@interface FDHomeViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  数据集，每个数据都是一个goodsmodel
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end



@implementation FDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNav];
    
    [self setupViews];
}

- (void)setupNav
{
    self.navigationItem.title = @"T动班魂";
}

- (void)setupViews
{
    
    __weak typeof(self) _weakSelf = self;
    
    //添加筛选框
    FDGoodsSelectBarView *selectBar = [[FDGoodsSelectBarView alloc] init];
    [self.view addSubview:selectBar];
    [selectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf.view);
        make.left.and.right.equalTo(_weakSelf.view);
    }];
    
    //添加collectionView
    [self.view insertSubview:self.collectionView belowSubview:selectBar];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectBar.mas_top).with.offset(40);
        make.left.and.right.equalTo(_weakSelf.view);
        make.bottom.equalTo(_weakSelf.view);
    }];
    
    //添加下拉刷新控件
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_weakSelf dropDownLoadMoreGoods];
    }];
    
    /**
     *  添加上拉刷新
     */
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [_weakSelf dropUpLoadMoreGoods];
    }];
    
    
}


/**
 *  view即将显示
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     *  刷新最新数据
     */
    [self dropUpLoadMoreGoods];
}


/**
 *  下拉刷新最新数据
 */
- (void)dropDownLoadMoreGoods
{
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    
    [self getGoodsRequires:params dropUp:NO];
    
    [self.collectionView.mj_header endRefreshing];
}

/**
 *  上拉加载更多旧数据
 */
- (void)dropUpLoadMoreGoods
{
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"123";
    params[@"pwd"] = @"123";
    
    [self getGoodsRequires:params dropUp:NO];
    
    [self.collectionView.mj_footer endRefreshing];
}

/**
 *  发送get请求，获取数据
 */
- (void)getGoodsRequires:(NSDictionary *)params dropUp:(BOOL)direction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (direction) {
            [self.collectionView.mj_footer endRefreshing];
        }else{
            [self.collectionView.mj_header endRefreshing];
        }
    });
    
    //发送get请求，返回json数据
    AFHTTPRequestOperationManager *maneger = [[AFHTTPRequestOperationManager alloc] init];
    maneger.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //发送请求
    [maneger GET:goodsRequireAddr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        /**
         *  返回的就是dict， 保存到array, 开始刷新collectionview
         */
        NSArray *array = responseObject[@"videos"];
        NSMutableArray *arrayM = [NSMutableArray array];
        //字典转模型
        for (NSDictionary *dict in array) {
            FDGoodsModel *model = [FDGoodsModel goodsWithDict:dict];
            [arrayM addObject:model];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addMoreItemForCollectionView:arrayM dropUp:direction];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FDMBProgressHUB showError:@"获取数据失败"];
    }];
}

/**
 *  添加新的数据到collectionview显示
 *
 *  @param array     数据
 *  @param direction YES 上拉，NO，下拉
 */
- (void)addMoreItemForCollectionView:(NSArray *)array dropUp:(BOOL)direction
{
    NSMutableArray *indexPath = [[NSMutableArray alloc] init];

    for (NSObject *model in array) {
        if (direction) {  //上拉
            [self.dataSource addObject:model];
        } else {//下拉
            [self.dataSource insertObject:model atIndex:0];
        }
        
        [indexPath addObject:[NSIndexPath indexPathForItem:[self.dataSource indexOfObject:model] inSection:0]];
    }
    
    [self.collectionView performBatchUpdates:^{
        //添加数据
        [self.collectionView insertItemsAtIndexPaths:indexPath];
        
    } completion:nil];

}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    FDGoodsModel *model = self.dataSource[indexPath.row];
    FDHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    FDGoodsInfoController *vc = [[FDGoodsInfoController alloc] init];
    vc.model = self.dataSource[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}





/**
 *  懒加载datasource
 */
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}
/**
 *  懒加载uicollectionview
 */
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);   //每个item之间的间距
        layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width / 2.0 - 10), [UIScreen mainScreen].bounds.size.height / 2.4);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        //注册cell
        [_collectionView registerClass:[FDHomeCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
    }
    
    
    return _collectionView;
}




@end
