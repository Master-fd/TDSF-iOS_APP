//
//  FDPhotoViewController.m
//  MSTVTool
//
//  Created by asus on 16/6/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDPhotoViewController.h"
#import "FDPhotoViewCell.h"
#import "FDGroupModel.h"
#import "FDPickerDatasModel.h"
#import "FDAssetsModel.h"


//collectionview  距离边缘距离
#define ksectionInsetMargin        3
#define kBoardMargin               10
//重用ID
#define kReuseId             @"reuseCellId"



@interface FDPhotoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataSource;   //相片数据源


@end


@implementation FDPhotoViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews
{
    self.view.backgroundColor = kFrenchGreyColor;

    //添加collectionview
    [self collectionView];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width-ksectionInsetMargin*3-kBoardMargin*2)/4;
        CGFloat itemHeight = itemWidth;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(kBoardMargin, kBoardMargin, kBoardMargin, kBoardMargin);
        flowLayout.minimumInteritemSpacing = ksectionInsetMargin;
        flowLayout.minimumLineSpacing = ksectionInsetMargin;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.view addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[FDPhotoViewCell class] forCellWithReuseIdentifier:kReuseId];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        
    }
    
    return _collectionView;
}


/**
 *  懒加载
 */
- (NSArray *)dataSource
{
    if (!_dataSource) {
        
        _dataSource = [NSArray array];
        
    }
    
    return _dataSource;
}


/**
 *  懒加载,获取相片组的FDAssetsModel信息
 */
- (void)setGroup:(FDGroupModel *)group
{
    _group = group;
    __block NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    __weak typeof(self) _weakSelf = self;
    [[FDPickerDatasModel defaultPicker] getAssetWithGroup:group finished:^(id obj) {

        [obj enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL *stop) {
            FDAssetsModel *assetsModel = [[FDAssetsModel alloc] init];
            assetsModel.asset = asset;
            [arrayM addObject:assetsModel];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _weakSelf.dataSource = arrayM;
            [_weakSelf.collectionView reloadData];

        });
        
    }];
    
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
    FDPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseId forIndexPath:indexPath];
    
    FDAssetsModel *asset = self.dataSource[indexPath.row];
    
    if ([asset isKindOfClass:[FDAssetsModel class]]) {
        cell.image = [asset thumbImage];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    FDAssetsModel *asset = self.dataSource[indexPath.row];
    if (self.didSelectImageBlock) {
        self.didSelectImageBlock(asset);
    }
}


@end
