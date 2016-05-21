//
//  FDGoodsInfoHeadView.m
//  T动衫魂
//
//  Created by asus on 16/5/18.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDGoodsInfoHeadView.h"
#import "FDGoodsModel.h"



@interface FDGoodsInfoHeadView()<UIScrollViewDelegate>{
    UIScrollView *_headerScrollView;
    UIView *_containerView;
    UIImageView *_minImageView1;
    UIImageView *_minImageView2;
    UIImageView *_minImageView3;
    
    UIPageControl *_pageControl;
    UIView *_lineGapView1;
    UILabel *_nameLab;
    UILabel *_priceLab;
    UILabel *_priceValue;
    UIView *_lineGapView2;
    UILabel *_tagLab;
    UILabel *_subClassLab;
    
    
}

@end


@implementation FDGoodsInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        
        [self setupContraints];
    }
    
    return self;
}

- (void)setupViews
{
    self.backgroundColor = kWhiteColor;
    
    _headerScrollView = [[UIScrollView alloc] init];
    [self addSubview:_headerScrollView];
    _headerScrollView.backgroundColor = kFrenchGreyColor;
    _headerScrollView.pagingEnabled = YES;
    _headerScrollView.delegate = self;
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    _headerScrollView.showsVerticalScrollIndicator = NO;
    
    _containerView = [[UIView alloc] init];
    [_headerScrollView addSubview:_containerView];
    _containerView.backgroundColor = [UIColor clearColor];
    
    _minImageView1 = [[UIImageView alloc] init];
    [_containerView addSubview:_minImageView1];
    _minImageView1.backgroundColor = [UIColor clearColor];
    
    _minImageView2 = [[UIImageView alloc] init];
    [_containerView addSubview:_minImageView2];
    _minImageView2.backgroundColor = [UIColor clearColor];
    
    _minImageView3 = [[UIImageView alloc] init];
    [_containerView addSubview:_minImageView3];
    _minImageView3.backgroundColor = [UIColor clearColor];
    
    _pageControl = [[UIPageControl alloc] init];
    [self addSubview:_pageControl];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 3;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.currentPageIndicatorTintColor = kBlackColor;
    _pageControl.pageIndicatorTintColor = kFrenchGreyColor;
    
    _priceLab = [[UILabel alloc] init];
    [self addSubview:_priceLab];
    _priceLab.text = @"￥";
    _priceLab.backgroundColor = [UIColor clearColor];
    _priceLab.textColor = kRoseColor;
    _priceLab.font = [UIFont systemFontOfSize:13];
    
    _priceValue = [[UILabel alloc] init];
    [self addSubview:_priceValue];
    _priceValue.backgroundColor = [UIColor clearColor];
    _priceValue.textColor = kRoseColor;
    _priceValue.font = [UIFont boldSystemFontOfSize:20];
    
    _nameLab = [[UILabel alloc] init];
    [self addSubview:_nameLab];
    _nameLab.numberOfLines = 0;
    _nameLab.font = [UIFont systemFontOfSize:17];
    _nameLab.textColor = kBlackColor;

    _lineGapView1 = [[UIView alloc] init];
    [self addSubview:_lineGapView1];
    _lineGapView1.backgroundColor = kFrenchGreyColor;
  
    _tagLab = [[UILabel alloc] init];
    [self addSubview:_tagLab];
    _tagLab.text = @"分类:";
    _tagLab.textColor = kDeepGreyColor;
    _tagLab.font = [UIFont systemFontOfSize:17];
    
    _subClassLab = [[UILabel alloc] init];
    [self addSubview:_subClassLab];
    _subClassLab.textColor = kDeepGreyColor;
    _subClassLab.font = [UIFont systemFontOfSize:17];
    
    _lineGapView2 = [[UIView alloc] init];
    [self addSubview:_lineGapView2];
    _lineGapView2.backgroundColor = kFrenchGreyColor;

}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
    NSNumber *height = [NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width];
    [_headerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf);
        make.left.equalTo(_weakSelf);
        make.right.equalTo(_weakSelf);
        make.height.equalTo(height);
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_headerScrollView);
        make.height.equalTo(_headerScrollView);
        make.right.equalTo(_minImageView3.mas_right);
    }];
    
    [_minImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.bottom.equalTo(_containerView);
        make.left.equalTo(_containerView);
        make.width.equalTo(_minImageView1.mas_height);
    }];
    
    [_minImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.bottom.equalTo(_containerView);
        make.left.equalTo(_minImageView1.mas_right);
        make.width.equalTo(_minImageView2.mas_height);
    }];
    
    [_minImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.bottom.equalTo(_containerView);
        make.left.equalTo(_minImageView2.mas_right);
        make.width.equalTo(_minImageView3.mas_height);
    }];

    //pagecontrol   price
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_weakSelf);
        make.bottom.equalTo(_headerScrollView.mas_bottom).with.offset(-2);
    }];

    [_nameLab sizeToFit];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_weakSelf).with.offset(12);
        make.top.equalTo(_headerScrollView.mas_bottom).with.offset(7);
    }];
    
    [_priceLab sizeToFit];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLab);
        make.bottom.equalTo(_priceValue.mas_bottom);
    }];
    
    [_priceValue sizeToFit];
    [_priceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLab.mas_right).with.offset(3);
        make.top.equalTo(_nameLab.mas_bottom).with.offset(10);
    }];
    //分割线
    [_lineGapView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo([NSNumber numberWithFloat:1]);
        make.left.and.right.equalTo(_weakSelf);
        make.top.equalTo(_priceValue.mas_bottom).with.offset(5);
    }];
    
    //tag
    [_tagLab sizeToFit];
    [_tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLab);
        make.top.equalTo(_lineGapView1.mas_bottom).with.offset(10);
    }];
    
    [_subClassLab sizeToFit];
    [_subClassLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_tagLab);
        make.left.equalTo(_tagLab.mas_right).with.offset(10);
    }];
    
    //分割线
    [_lineGapView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo([NSNumber numberWithFloat:1]);
        make.left.and.right.equalTo(_weakSelf);
        make.top.equalTo(_subClassLab.mas_bottom).with.offset(10);
    }];
    
    //约束自身底部
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerScrollView);
        make.bottom.equalTo(_lineGapView2);
    }];
}

#pragma mark - UIScrollViewDelegate
/**
 *  scrollview在滚动
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (NSInteger)((scrollView.contentOffset.x+[UIScreen mainScreen].bounds.size.width/2) / [UIScreen mainScreen].bounds.size.width) ;
}

/**
 *  懒加载设置数据
 */
- (void)setModel:(FDGoodsModel *)model
{
    _model = model;
    
    [_minImageView1 sd_setImageWithURL:[NSURL URLWithString:model.minImageUrl1] placeholderImage:[UIImage imageNamed:@"defult_placeholder"]];
    [_minImageView2 sd_setImageWithURL:[NSURL URLWithString:model.minImageUrl2] placeholderImage:[UIImage imageNamed:@"defult_placeholder"]];
    [_minImageView3 sd_setImageWithURL:[NSURL URLWithString:model.minImageUrl3] placeholderImage:[UIImage imageNamed:@"defult_placeholder"]];
    
    _priceValue.text = model.price ? model.price:@"00.00";
    _nameLab.text = model.name ? model.name:@"衬衫";
    _subClassLab.text = model.subClass ? model.subClass:@"衬衫";

}

@end
