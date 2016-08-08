//
//  FDGoodsInfoOrderBar.h
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClickBlock)();

@interface FDGoodsInfoOrderBar : UIView

@property (nonatomic, copy) btnClickBlock payBtnDidClickBlock;

@property (nonatomic, copy) btnClickBlock gotoBtnDidClickBlock;
@end
