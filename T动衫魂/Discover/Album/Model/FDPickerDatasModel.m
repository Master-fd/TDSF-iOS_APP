//
//  FDPickerDatasModel.m
//  MSTVTool
//
//  Created by asus on 16/6/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDPickerDatasModel.h"
#import "FDGroupModel.h"
#import <AssetsLibrary/AssetsLibrary.h>




@interface FDPickerDatasModel()

@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation FDPickerDatasModel


+ (ALAssetsLibrary *)defaultAssetsLirary
{
    static dispatch_once_t once_taken=0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&once_taken, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    
    return library;
}

/**
 *  懒加载
 */
- (ALAssetsLibrary *)library
{
    if (!_library) {
        _library = [self.class defaultAssetsLirary];
    }
    
    return _library;
}

/**
 *  相册
 */
+ (instancetype)defaultPicker
{
    return [[self alloc] init];
}

/**
 *  获取所有组,返回FDGroupModel的数组
 */
- (void)getAllGroupWithPhoto:(callBackBlock)backBlock
{
    NSMutableArray *groups = [NSMutableArray array];
    ALAssetsLibraryGroupsEnumerationResultsBlock result = ^(ALAssetsGroup *group, BOOL *stop){
        
        if (group) {
            
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            FDGroupModel *groupModel = [[FDGroupModel alloc] init];
            groupModel.group = group;
            groupModel.groupName = [group valueForProperty:@"ALAssetsGroupPropertyName"];
            groupModel.thumbImage = [UIImage imageWithCGImage:[group posterImage]];
            groupModel.assetsCount = [group numberOfAssets];
            
            [groups addObject:groupModel];
        }else{
            if (backBlock) {   //遍历完成，传出groups
                backBlock(groups);
            }
        }
    };
    //遍历,其实对于数组内部的enumer的遍历，自带了autoreleasepool，所以我们不需要添加
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:result failureBlock:nil];
}

/**
 *  传入一个组，获取对应的组的所有Asset
 */
- (void)getAssetWithGroup:(FDGroupModel *)group finished:(callBackBlock)backBlock
{
    NSMutableArray *assets = [NSMutableArray array];
    ALAssetsGroupEnumerationResultsBlock result = ^(ALAsset *asset , NSUInteger index , BOOL *stop){
        if (asset) {
            [assets addObject:asset];
        }else{
            if (backBlock) {//遍历完成，传出assets;
                backBlock(assets);
            }
        }
        
    };
    //遍历
    [group.group enumerateAssetsUsingBlock:result];
    

}

/**
 *  传入一个AssetsURL获取对应全屏图
 */
- (void)getAssetWithUrl:(NSURL *)url finished:(callBackBlock)backBlock
{
    [self.library assetForURL:url resultBlock:^(ALAsset *asset){
        if (backBlock) {   //回调block，返回全屏图
            backBlock([UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]);
        }
    }failureBlock:nil];
}


@end
