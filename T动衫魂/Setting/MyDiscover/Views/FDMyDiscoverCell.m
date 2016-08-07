//
//  FDMyDiscoverCell.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyDiscoverCell.h"
#import "FDDiscoverModel.h"



@interface FDMyDiscoverCell()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *contentLab;


@end
@implementation FDMyDiscoverCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        __weak typeof(self) _weakSelf = self;
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.top.left.equalTo(_weakSelf.contentView).offset(10);
        }];
        
        _titleLab = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font = [UIFont systemFontOfSize:17];
        _titleLab.textColor = kRoseColor;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_weakSelf.iconView.mas_top).offset(7);
            make.left.equalTo(_weakSelf.iconView.mas_right).offset(15);
            make.right.equalTo(_weakSelf.contentView).offset(-20);
        }];

        _contentLab = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLab];
        _contentLab.font = [UIFont systemFontOfSize:12];
        _contentLab.numberOfLines = 2;
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_weakSelf.titleLab.mas_bottom).offset(5);
            make.left.equalTo(_weakSelf.iconView.mas_right).offset(15);
            make.right.equalTo(_weakSelf.contentView).offset(-20);
        }];
    }
    
    return self;
}

- (void)setDiscover:(FDDiscoverModel *)discover
{
    _discover = discover;
    _titleLab.text = [FDUserInfo shareFDUserInfo].name;
    _contentLab.text = discover.content;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:discover.contentImageUrl] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
}

@end
