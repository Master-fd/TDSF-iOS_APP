//
//  FDSelectInfoView.h
//  T动衫魂
//
//  Created by asus on 16/5/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, sex){
    sexAll   = 0,   //不分
    sexMale  = 1,   //男
    sexFemale= 2     //女
};

typedef NS_ENUM(NSInteger, subClass){
    subClassAll           = 0,   //不分
    subClassShirt     = 1,   //衬衫
    subClassLongSleeve    = 2,   //长袖
    subClassCoat          = 3,   //卫衣
};


typedef void(^btnClickBlock)(NSString *btnTitle);

@interface FDSelectInfoView : UIView

/**
 *  所有按键的名字
 */
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, copy) btnClickBlock btnDidClickBlock;


@end
