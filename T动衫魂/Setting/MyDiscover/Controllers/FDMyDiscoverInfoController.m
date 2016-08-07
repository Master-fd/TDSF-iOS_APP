//
//  FDMyDiscoverInfoController.m
//  T动衫魂
//
//  Created by asus on 16/8/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyDiscoverInfoController.h"
#import "FDDiscoverModel.h"



@interface FDMyDiscoverInfoController(){
    //logo和名字
    UIImageView *_iconImageView;
    UILabel *_nameLab;
    
    //左边的线条和标签
    UIView *_lineUpView;
    UIView *_bgTagView;
    UILabel *_tagLab;
    UIView *_lineDownView;
    
    //图片和文字内容背景
    UIView *_bgContentView;
    UIImageView *_contentImageView;
    
    //底部分割线条
    UIView *_lineGap;
    UITextView *_contentTextView;
}

@end


@implementation FDMyDiscoverInfoController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.title = @"买家秀";
}

- (void)setupViews
{
    self.view.backgroundColor = kWhiteColor;
    
    //logo和名字
    _iconImageView = [[UIImageView alloc] init];
    [self.view addSubview:_iconImageView];
    _iconImageView.image = [UIImage imageNamed:@"default_minIMage"];
    
    _nameLab = [[UILabel alloc] init];
    [self.view addSubview:_nameLab];
    _nameLab.text = [FDUserInfo shareFDUserInfo].name;
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.textColor = kRoseColor;
    _nameLab.backgroundColor = [UIColor clearColor];
    
    //左边的线条和标签
    _lineUpView = [[UIView alloc] init];
    [self.view addSubview:_lineUpView];
    _lineUpView.backgroundColor = kDeepGreyColor;
    
    _bgTagView = [[UIView alloc] init];
    [self.view addSubview:_bgTagView];
    _bgTagView.backgroundColor = [UIColor clearColor];
    _bgTagView.layer.borderColor = kDeepGreyColor.CGColor;
    _bgTagView.layer.borderWidth = 1;
    //    _bgTagView.layer.masksToBounds = YES; //这条会离屏渲染
    _bgTagView.layer.cornerRadius = 11;
    
    _tagLab = [[UILabel alloc] init];
    [_bgTagView addSubview:_tagLab];
    _tagLab.backgroundColor = [UIColor clearColor];
    _tagLab.textColor = kBlackColor;
    _tagLab.font = [UIFont systemFontOfSize:13];
    _tagLab.numberOfLines = 0;
    _tagLab.textAlignment = NSTextAlignmentCenter;
    _tagLab.text = @"T动衫魂，活力四射";
    _lineDownView = [[UIView alloc] init];
    [self.view addSubview:_lineDownView];
    _lineDownView.backgroundColor = kDeepGreyColor;
    
    //图片和文字内容
    
    _contentTextView = [[UITextView alloc] init];
    [self.view addSubview:_contentTextView];
    _contentTextView.textColor = kBlackColor;
    _contentTextView.backgroundColor = kFrenchGreyColor;
    _contentTextView.font = [UIFont systemFontOfSize:16];
    _contentTextView.userInteractionEnabled = NO;
    _contentTextView.scrollEnabled = NO;
    _contentTextView.text = @"dsafdfasdfafdasffasdfadfadsfasdfafdfadsfdafsadafdafadsfdasfasdfdsfasfsadffafafdsfddsaf";
    _contentTextView.layer.borderColor = [UIColor colorWithRed:206/255.0 green:237/255.0 blue:232/255.0 alpha:1].CGColor;
    _contentTextView.layer.borderWidth = 1;
    _contentTextView.layer.cornerRadius = 4;
    
    _bgContentView = [[UIView alloc] init];
    [self.view addSubview:_bgContentView];
    _bgContentView.backgroundColor = [UIColor clearColor];
    _bgContentView.layer.borderColor = [UIColor colorWithRed:206/255.0 green:237/255.0 blue:232/255.0 alpha:1].CGColor;
    _bgContentView.layer.borderWidth = 1;
    
    _contentImageView = [[UIImageView alloc] init];
    [_bgContentView addSubview:_contentImageView];
    _contentImageView.backgroundColor = [UIColor clearColor];
    
    //底部分割线条
    _lineGap = [[UIView alloc] init];
    [self.view addSubview:_lineGap];
    _lineGap.backgroundColor = kFrenchGreyColor;
}

- (void)setupContraints
{
    CGFloat marginMin = 2;
    CGFloat marginMax = 10;
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    __weak typeof(self) _weakSelf = self;
    //logo和名字
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.top.equalTo(_weakSelf.view).with.offset(marginMin);
        make.left.equalTo(_weakSelf.view).with.offset(marginMin);
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
        make.bottom.equalTo(_weakSelf.view.mas_bottom);
    }];
    
    //图片和文字内容
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.mas_baseline).with.offset(10);
        make.left.and.right.equalTo(_bgContentView);
        make.height.equalTo([NSNumber numberWithFloat:_contentTextView.font.lineHeight*5]);
    }];
    
    [_bgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentTextView.mas_bottom).with.offset(10);
        make.left.equalTo(_nameLab.mas_left);
        make.right.equalTo(_weakSelf.view.mas_right).with.offset(-8);
        make.bottom.equalTo(_lineGap.mas_top).with.offset(-20);
    }];
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    //分割线条
    [_lineGap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(_bgContentView);
        make.right.equalTo(_weakSelf.view.mas_right);
        make.bottom.equalTo(_weakSelf.view.mas_bottom).with.offset(-(screenHeight/25));
    }];
    
}

- (void)setDiscover:(FDDiscoverModel *)discover
{
    if (!_nameLab || !_contentTextView || !_contentImageView) {
        [self setupViews];
        
        [self setupContraints];
    }
    _discover = discover;
    _nameLab.text = [FDUserInfo shareFDUserInfo].name;
    _contentTextView.text = discover.content;
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:discover.contentImageUrl] placeholderImage:[UIImage imageNamed:@"defult_placeholder"] options:SDWebImageProgressiveDownload];
}



@end
