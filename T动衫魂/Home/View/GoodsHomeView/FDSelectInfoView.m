//
//  FDSelectInfoView.m
//  T动衫魂
//
//  Created by asus on 16/5/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDSelectInfoView.h"


@implementation FDSelectInfoView


- (void)setupViews
{
    self.backgroundColor = kWhiteColor;

    if (self.titleArray) {
        NSInteger i=0;
        UIButton *lastBtn = nil;
        for (NSString *title in self.titleArray) {
            //添加btn
            UIButton *btn = [[UIButton alloc] init];
            [self addSubview:btn];
            btn.tag = i;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:kRoseColor forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

            //添加约束
            __weak typeof(self) _weakSelf = self;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_weakSelf);
                make.width.equalTo(_weakSelf.mas_width);
                make.height.equalTo(@30);
                if (i==0) {
                    //第一个
                    make.top.equalTo(_weakSelf);
                } else{//中间的
                    make.top.equalTo(lastBtn.mas_bottom);
                }
            }];
            
            lastBtn = btn;
            i++;
        }
        
        //增加自身约束
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastBtn.mas_bottom);
        }];
    }

}

- (void)btnClick:(UIButton *)btn
{
    if (self.btnDidClickBlock) {
        self.btnDidClickBlock(btn.titleLabel.text);
    }
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;

    [self setupViews];
}

@end
