//
//  FDCostBarView.h
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnDidClick)();

@interface FDCostBarView : UIView

@property (nonatomic, copy) void(^selectDidClick)(BOOL selected);   //全选

@property (nonatomic, copy) btnDidClick costSumDidClick;  //下单

@property (nonatomic, strong) UIButton *checkBoxBtn;   //选择框

@property (nonatomic, strong) UILabel *priceValueLab;  //价格值

@end
