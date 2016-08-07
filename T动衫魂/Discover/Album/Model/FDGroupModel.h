//
//  FDGroupModel.h
//  MSTVTool
//
//  Created by asus on 16/6/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface FDGroupModel : NSObject


/**
 *  组名
 */
@property (nonatomic, copy) NSString *groupName;

/**
*  缩略图
*/
@property (nonatomic, strong) UIImage *thumbImage;

/**
*  组里面的图片个数
*/
@property (nonatomic, assign) NSUInteger assetsCount;

/**
*  类型
*/
@property (nonatomic, copy) NSString *type;

/**
 *  组的ALAssetsGroup
 */
@property (nonatomic, strong) ALAssetsGroup *group;

@end
