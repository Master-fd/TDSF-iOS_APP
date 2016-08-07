//
//  FDAblumViewController.m
//  MSTVTool
//
//  Created by asus on 16/6/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAblumViewController.h"
#import "FDAblumCollectionViewCell.h"
#import "FDGroupModel.h"
#import "FDPickerDatasModel.h"
#import "FDPhotoViewController.h"



//collectionview  距离边缘距离
#define ksectionInsetMargin        10
//重用ID
#define kReuseId             @"reuseCellId"



@interface FDAblumViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) NSArray *dataSource;   //数据源


@end


@implementation FDAblumViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    //获取所有相片组
    [self getAllImageGroup];
    
    [self setupViews];
}

- (void)setupViews
{
    self.view.backgroundColor = kFrenchGreyColor;
    self.title = @"相册";
    
    //添加collectionview
    [self collectionView];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width-ksectionInsetMargin*3)/2;
        CGFloat itemHeight = itemWidth*1.1;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(ksectionInsetMargin, ksectionInsetMargin, ksectionInsetMargin, ksectionInsetMargin);
        flowLayout.minimumInteritemSpacing = ksectionInsetMargin;
        flowLayout.minimumLineSpacing = ksectionInsetMargin;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.view addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[FDAblumCollectionViewCell class] forCellWithReuseIdentifier:kReuseId];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        
    }
    
    return _collectionView;
}

- (void)getAllImageGroup
{
    __weak typeof(self) _weakSelf = self;
    
    [[FDPickerDatasModel defaultPicker] getAllGroupWithPhoto:^(id obj) {
        _weakSelf.dataSource = [[obj reverseObjectEnumerator] allObjects];
        
        //必须刷新一下数据，否则会出现无法显示，因为获取相册需要一定的时间，但是collectionview已经显示了。
        dispatch_async(dispatch_get_main_queue(), ^{
            [_weakSelf.collectionView reloadData];
        });
    }];
    
}
/**
 *  懒加载
 */
- (NSArray *)dataSource
{
    if (!_dataSource) {
        
        _dataSource = [[NSArray alloc] init];
    }
    
    return _dataSource;
}

#pragma mark - UICollectionView delegate
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
    FDAblumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseId forIndexPath:indexPath];
    FDGroupModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取组
    FDGroupModel *groupModel = self.dataSource[indexPath.row];
    
    FDPhotoViewController *VC = [[FDPhotoViewController alloc] init];
    VC.group = groupModel;
    VC.title = groupModel.groupName;
    VC.hidesBottomBarWhenPushed = YES;
    VC.didSelectImageBlock = self.didSelectImageBlock;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}


@end
