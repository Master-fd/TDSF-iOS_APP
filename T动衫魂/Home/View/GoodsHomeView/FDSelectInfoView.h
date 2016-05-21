//
//  FDSelectInfoView.h
//  T动衫魂
//
//  Created by asus on 16/5/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClickBlock)(NSString *btnTitle);

@interface FDSelectInfoView : UIView

/**
 *  所有按键的名字
 */
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, copy) btnClickBlock btnDidClickBlock;


@end
