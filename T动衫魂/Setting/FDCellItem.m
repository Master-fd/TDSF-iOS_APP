//
//  FDCellItem.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDCellItem.h"

@implementation FDCellItem

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image indicator:(BOOL)showIndicator didSelectBlock:(didSelectBlock)optionBlock
{
    FDCellItem *item = [[FDCellItem alloc] init];
    item.title = title;
    item.image = image;
    item.showIndicator = showIndicator;
    item.optionBlock = optionBlock;
    return item;
}
@end
