//
//  FDImageBarView.m
//  T动衫魂
//
//  Created by asus on 16/8/8.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDImageBarView.h"

@interface FDImageBarView()

@property (nonatomic, strong) NSMutableArray *arrayM;

@end
@implementation FDImageBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat margin = 10;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - margin*5) / 4.0;
        CGFloat height = width;
        __weak typeof(self) _weakSelf = self;
        if (!self.arrayM) {
            self.arrayM = [NSMutableArray array];
        }
        UIImageView *lastView = nil;
        for (int i=0; i<4; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_weakSelf.mas_top).offset(margin);
                make.size.mas_equalTo(CGSizeMake(width, height));
                if (lastView) {
                    make.left.mas_equalTo(lastView.mas_right).offset(margin);

                } else {
                    make.left.mas_equalTo(_weakSelf.mas_left).offset(margin);
                }
            }];
            lastView = imageView;
            [self.arrayM addObject:imageView];
        }
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.mas_bottom).offset(margin);
        }];

    }
    
    return self;
}

- (void)setIconArray:(NSArray *)iconArray
{
    _iconArray = iconArray;
    
    //限制最多只能显示4个
    NSUInteger count = iconArray.count;

    for (int i=0; i<4; i++) {
        
        UIImageView *imageView = self.arrayM[i];
        if (i<count) {
            NSString *url = iconArray[i];
            imageView.hidden = NO;
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_AboutMeMax"] options:SDWebImageProgressiveDownload];
        }else{  //对没有的商品，要隐藏这个view，否则会出现cell重用导致问题
            imageView.hidden = YES;
        }
        
    }
}

@end
