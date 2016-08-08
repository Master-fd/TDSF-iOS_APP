//
//  FDConfirmOrderBarView.h
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDConfirmOrderBarView : UIView

@property (nonatomic, copy) void(^costSumDidClick)();

@property (nonatomic, assign) CGFloat sumPrice;
@end
