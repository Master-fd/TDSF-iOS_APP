//
//  FDInputView.h
//  School
//
//  Created by asus on 16/3/5.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnDidClickBlock)(NSString *account, NSString *password);

@interface FDInputView : UIView


@property (nonatomic, copy) btnDidClickBlock loginBtnClickBlock;

@property (nonatomic, copy) btnDidClickBlock registerBtnClickBlock;
@end
