//
//  FDAddrEditView.m
//  T动衫魂
//
//  Created by asus on 16/8/2.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAddrEditView.h"

@interface FDAddrEditView ()

@property (nonatomic, strong) UIView *gapView1;
@end

@implementation FDAddrEditView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = kWhiteColor;
        __weak typeof(self) _weakSelf = self;

        _gapView1 = [[UIView alloc] init];
        [self addSubview:_gapView1];
        _gapView1.backgroundColor = [UIColor colorWithRed:222/255.0 green:224/255.0 blue:227/255.0 alpha:1];
        [_gapView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.leading.trailing.mas_equalTo(_weakSelf);
            make.bottom.mas_equalTo(_weakSelf.mas_bottom);
        }];

        _nameLab = [[UILabel alloc] init];
        [self addSubview:_nameLab];
        _nameLab.backgroundColor = [UIColor whiteColor];
        _nameLab.font = [UIFont systemFontOfSize:16];
        _nameLab.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _nameLab.text = @"联系人:";
        _nameLab.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_weakSelf.mas_leading).with.offset(10);
            make.width.mas_equalTo(80);
            make.top.equalTo(_weakSelf.mas_top).with.offset(10);
        }];

        _nameTextView = [[UITextView alloc] init];
        [self addSubview:_nameTextView];
        _nameTextView.backgroundColor = [UIColor whiteColor];
        _nameTextView.font = [UIFont systemFontOfSize:16];
        _nameTextView.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        [_nameTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLab.mas_right);
            make.right.equalTo(_weakSelf.mas_right).offset(-10);
            make.top.equalTo(_weakSelf.mas_top).offset(1.5);
            make.bottom.mas_equalTo(_gapView1.mas_top);
        }];
        
        
    }
    
    return self;
}


@end
