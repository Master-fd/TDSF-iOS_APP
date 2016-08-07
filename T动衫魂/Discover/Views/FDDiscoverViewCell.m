//
//  FDDiscoverViewCell.m
//  T动衫魂
//
//  Created by asus on 16/5/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDiscoverViewCell.h"
#import "FDDiscoverModel.h"




@interface FDDiscoverViewCell(){
    //logo和名字
    UIImageView *_iconImageView;
    UILabel *_nameLab;
    
    //左边的线条和标签
    UIView *_lineUpView;
    UIView *_bgTagView;
    UILabel *_tagLab;
    UIView *_lineDownView;
    
    //图片和文字内容
    UIView *_bgContentView;
    UIImageView *_contentImageView;
    UILabel *_contentLab;
    
    //底部分割线条
    UIView *_lineGap;
}

@end


@implementation FDDiscoverViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupViews];
        
        [self setupContraints];
    }
    
    return self;
}
- (void)setupViews
{
    self.contentView.backgroundColor = kWhiteColor;
    
    
    //logo和名字
    _iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImageView];
    _iconImageView.image = [UIImage imageNamed:@"default_minIMage"];
    
    _nameLab = [[UILabel alloc] init];
    [self.contentView addSubview:_nameLab];
    _nameLab.text = @"T动衫服";
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.textColor = kRoseColor;
    _nameLab.backgroundColor = [UIColor clearColor];
    
    //左边的线条和标签
    _lineUpView = [[UIView alloc] init];
    [self.contentView addSubview:_lineUpView];
    _lineUpView.backgroundColor = kDeepGreyColor;
    
    _bgTagView = [[UIView alloc] init];
    [self.contentView addSubview:_bgTagView];
    _bgTagView.backgroundColor = [UIColor clearColor];
    _bgTagView.layer.borderColor = kDeepGreyColor.CGColor;
    _bgTagView.layer.borderWidth = 1;
//    _bgTagView.layer.masksToBounds = YES; //这条会离屏渲染
    _bgTagView.layer.cornerRadius = 11;
    
    _tagLab = [[UILabel alloc] init];
    [_bgTagView addSubview:_tagLab];
    _tagLab.backgroundColor = [UIColor clearColor];
    _tagLab.textColor = kBlackColor;
    _tagLab.font = [UIFont systemFontOfSize:15];
    _tagLab.numberOfLines = 0;
    _tagLab.textAlignment = NSTextAlignmentCenter;
    _tagLab.text = @"T动衫魂，活力四射";
    _lineDownView = [[UIView alloc] init];
    [self.contentView addSubview:_lineDownView];
    _lineDownView.backgroundColor = kDeepGreyColor;
    
    //图片和文字内容
    _bgContentView = [[UIView alloc] init];
    [self.contentView addSubview:_bgContentView];
    _bgContentView.backgroundColor = [UIColor clearColor];
    _bgContentView.layer.borderColor = [UIColor colorWithRed:206/255.0 green:237/255.0 blue:232/255.0 alpha:1].CGColor;
    _bgContentView.layer.borderWidth = 1;
    
    _contentImageView = [[UIImageView alloc] init];
    [_bgContentView addSubview:_contentImageView];
    _contentImageView.backgroundColor = [UIColor clearColor];
    
    _contentLab = [[UILabel alloc] init];
    [self.contentView addSubview:_contentLab];
    _contentLab.numberOfLines = 0;
    _contentLab.textColor = kBlackColor;
    _contentLab.backgroundColor = [UIColor clearColor];
    _contentLab.font = [UIFont systemFontOfSize:16];
    
    //底部分割线条
    _lineGap = [[UIView alloc] init];
    [self.contentView addSubview:_lineGap];
    _lineGap.backgroundColor = kFrenchGreyColor;
}

- (void)setupContraints
{
    CGFloat marginMin = 2;
    CGFloat marginMax = 10;
    __weak typeof(self) _weakSelf = self;
    //logo和名字
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.top.equalTo(_weakSelf.contentView).with.offset(marginMin);
        make.left.equalTo(_weakSelf.contentView).with.offset(marginMin);
    }];
    
    [_nameLab sizeToFit];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).with.offset(marginMax);
        make.centerY.equalTo(_iconImageView.mas_centerY);
    }];
    
    //左边线条
    [_lineUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.height.equalTo(@15);
        make.centerX.equalTo(_iconImageView.mas_centerX);
        make.top.equalTo(_iconImageView.mas_bottom);
    }];

    [_bgTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineUpView.mas_bottom);
        make.centerX.equalTo(_lineUpView.mas_centerX);
        make.width.equalTo(_tagLab).with.offset(2);
        make.bottom.equalTo(_tagLab.mas_bottom).with.offset(10);
    }];
    
    [_tagLab sizeToFit];
    [_tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgTagView).with.offset(10);
        make.width.equalTo([NSNumber numberWithFloat:_tagLab.font.lineHeight]);
        make.centerX.equalTo(_bgTagView.mas_centerX);
    }];

    [_lineDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.centerX.equalTo(_bgTagView.mas_centerX);
        make.top.equalTo(_bgTagView.mas_bottom);
        make.bottom.equalTo(_weakSelf.contentView.mas_bottom).with.offset(marginMin);
    }];
    
    //图片和文字内容
    [_bgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_bottom);
        make.left.equalTo(_nameLab.mas_left);
        make.right.equalTo(_weakSelf.contentView.mas_right).with.offset(-8);
        make.height.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width]);
    }];
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [_contentLab sizeToFit];  //
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgContentView.mas_bottom).with.offset(15);
        make.left.and.right.equalTo(_bgContentView);
    }];
    
    

    //分割线条
    [_lineGap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(_bgContentView);
        make.right.equalTo(_weakSelf.contentView.mas_right);
        make.top.equalTo(_contentLab.mas_bottom).with.offset(15);
        make.bottom.equalTo(_weakSelf.contentView.mas_bottom).with.offset(-5);   //一定要有这一句，相对于contentview/bottom来布局，否则无法自动计算高度
    }];

}

/**
 *  设置数据
 */
- (void)setModel:(FDDiscoverModel *)model
{
    _model = model;
    
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:model.contentImageUrl] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
    _contentLab.text = model.content;
    _nameLab.text = model.name;
}

@end






















