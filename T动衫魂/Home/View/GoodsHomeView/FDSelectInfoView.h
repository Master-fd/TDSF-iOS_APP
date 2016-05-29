//
//  FDSelectInfoView.h
//  T动衫魂
//
//  Created by asus on 16/5/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>



#define sexCommon   @"common"   //不分
#define sexMale     @"male"   //男
#define sexFemale   @"female"     //女


#define subClassCommon          @"common"   //不分
#define subClassChenshan        @"chenshan"   //衬衫
#define subClassQinglv          @"qinglv"   //情侣
#define subClassWeiyi           @"weiyi"   //卫衣



typedef void(^btnClickBlock)(NSString *btnTitle);

@interface FDSelectInfoView : UIView

/**
 *  所有按键的名字
 */
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, copy) btnClickBlock btnDidClickBlock;


@end
