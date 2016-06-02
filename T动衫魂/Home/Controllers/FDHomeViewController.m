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
#import "FDHomeNetworkTool.h"
#import "FDSelectInfoView.h"


/**
 *  每次都向服务器尝试请求多少条数据，具体返回多少条数据需要服务器自己决定
 *  idPage=0&pageSize=10&sex=female&subClass=common
 */
//请求参数
#define kParamSexKey            @"sex"
#define kParamSubClassKey       @"subClass"

#define kParamidPageKey         @"idPage"                   //第几页，页数从0开始
#define kParamPageSizeKey       @"pageSize"                 //每次请求，页大小的key
#define kParampageSizeValue     @"20"                       //每页数量

@interface FDHomeViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  数据集，每个数据都是一个goodsmodel
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  当前的page
 */
@property (nonatomic, assign) NSInteger idPageNow;


/**
 *  当前的sex
 */
@property (nonatomic, copy) NSString *sexNow;

/**
 *  当前的subclass
 */
@property (nonatomic, copy) NSString *subClassNow;


@end



@implementation FDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNav];
    
    [self setupViews];
    
    /**
     *  刷新最新数据
     */
    [self dropDownLoadMoreGoods];
}

- (void)setupNav
{
    self.navigationItem.title = @"T动衫魂";
    
    //监听通知
    NSNotificationCenter *defaults = [NSNotificationCenter defaultCenter];
    [defaults addObserver:self selector:@selector(observerFromSelectGoods:) name:kSelectGoodsNotification object:nil];
}

- (void)dealloc
{
    //移除监听
    NSNotificationCenter *defaults = [NSNotificationCenter defaultCenter];
    [defaults removeObserver:self];
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
 *  下拉刷新最新数据
 */
- (void)dropDownLoadMoreGoods
{
    //封装请求参数
    self.idPageNow = 0;  //复位一下,从最新的开始查找
    NSDictionary *params = [self packageParam];  //封装请求参数

    __weak typeof(self) _weakSelf = self;
    [FDHomeNetworkTool getGoodsRequires:params dropUp:NO success:^(NSArray *results) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_weakSelf.dataSource removeAllObjects];  //先清空所有数据
            [_weakSelf.collectionView reloadData];
        });
        [_weakSelf addMoreItemForCollectionView:results dropUp:NO];
        _weakSelf.idPageNow++;
    } failure:^(NSArray *results) {
        
    }];
    
    [self.collectionView.mj_header endRefreshing];
}

/**
 *  上拉加载更多旧数据
 */
- (void)dropUpLoadMoreGoods
{
    //封装请求参数
    NSDictionary *params = [self packageParam];  //封装请求参数
    
    __weak typeof(self) _weakSelf = self;
    [FDHomeNetworkTool getGoodsRequires:params dropUp:YES success:^(NSArray *results) {
        [_weakSelf addMoreItemForCollectionView:results dropUp:YES];
        _weakSelf.idPageNow ++;;   //请求成功，page++
    } failure:^(NSArray *results) {
        //没有获取到数据，idStartNow和idEndNow不变

    }];
    
    [self.collectionView.mj_footer endRefreshing];
}
/**
 *  添加新的数据到collectionview显示
 *
 *  @param array     数据
 *  @param direction YES 上拉，NO，下拉
 */
- (void)addMoreItemForCollectionView:(NSArray *)array dropUp:(BOOL)direction
{

    __weak typeof(self) _weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableArray *indexPath = [[NSMutableArray alloc] init];

        for (int i=(int)array.count-1; i>=0; i--) {
            FDGoodsModel *model = array[i];
            if (direction) {  //上拉
                [_weakSelf.dataSource addObject:model];
            } else {//下拉
                [_weakSelf.dataSource insertObject:model atIndex:0];
            }
        }
        
        for (int i=0; i<array.count; i++) {   //查询每个model在datasource的位置
            FDGoodsModel *model = array[i];
            [indexPath addObject:[NSIndexPath indexPathForItem:[_weakSelf.dataSource indexOfObject:model] inSection:0]];
        }
        [_weakSelf.collectionView performBatchUpdates:^{
            //添加数据
            [_weakSelf.collectionView insertItemsAtIndexPaths:indexPath];
            
        } completion:nil];
        
    });
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



#pragma mark - 监听通知
/**
 *  监听筛选数据通知执行函数
 */
- (void)observerFromSelectGoods:(NSNotification *)userInfo
{
    NSDictionary *info = [userInfo userInfo];
    
    //改变当前的sex和subclass
    self.sexNow = info[kSexKey];
    self.subClassNow = info[kSubClassKey];
    self.idPageNow = 0;  //复位一下
    
    NSDictionary *params = [self packageParam];  //封装请求参数
   
    __weak typeof(self) _weakSelf = self;
    [FDHomeNetworkTool getGoodsRequires:params dropUp:NO success:^(NSArray *results) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_weakSelf.dataSource removeAllObjects];  //先清空所有数据
            [_weakSelf.collectionView reloadData];
        });
        //添加新的数据
        [_weakSelf addMoreItemForCollectionView:results dropUp:NO];
        _weakSelf.idPageNow ++;   //请求成功
    } failure:^(NSArray *results) {

    }];

}

/**
 *  封装请求参数
 */
- (NSDictionary *)packageParam
{
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[kParamPageSizeKey] = kParampageSizeValue;
    params[kParamidPageKey] = [NSString stringWithFormat:@"%ld", self.idPageNow];  //
    if (self.sexNow) {
        params[kParamSexKey] = self.sexNow;
    }
    if (self.subClassNow) {
        params[kParamSubClassKey] = self.subClassNow;
    }
    
    return params;
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
