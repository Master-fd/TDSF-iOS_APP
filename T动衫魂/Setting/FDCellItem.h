//
//  FDCellItem.h
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^didSelectBlock)();
@interface FDCellItem : NSObject


@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL showIndicator;
@property (nonatomic, copy) didSelectBlock optionBlock;

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image indicator:(BOOL)showIndicator didSelectBlock:(didSelectBlock )optionBlock;

@end
