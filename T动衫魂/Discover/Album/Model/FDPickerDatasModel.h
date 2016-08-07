//
//  FDPickerDatasModel.h
//  MSTVTool
//
//  Created by asus on 16/6/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  回调block
 */
typedef void(^callBackBlock)(id obj);

@class FDGroupModel;

@interface FDPickerDatasModel : NSObject


/**
 *  相册
 */
+ (instancetype)defaultPicker;

/**
 *  获取所有相片组
 */
- (void)getAllGroupWithPhoto:(callBackBlock)backBlock;

/**
*  传入一个组，获取对应的组的所有Asset
*/
- (void)getAssetWithGroup:(FDGroupModel *)group finished:(callBackBlock)backBlock;

/**
*  传入一个AssetsURL获取对应全屏图
*/
- (void)getAssetWithUrl:(NSURL *)url finished:(callBackBlock)backBlock;


@end
