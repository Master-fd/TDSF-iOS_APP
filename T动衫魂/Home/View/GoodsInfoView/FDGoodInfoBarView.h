//
//  FDGoodInfoBarView.h
//  T动衫魂
//
//  Created by asus on 16/5/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClickBlock)();

@interface FDGoodInfoBarView : UIView


@property (nonatomic, copy) btnClickBlock infoBtnClickBlock;
@property (nonatomic, copy) btnClickBlock remarkBtnClickBlock;

@end
