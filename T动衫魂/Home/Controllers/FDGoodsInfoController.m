//
//  FDGoodsInfoController.m
//  T动衫魂
//
//  Created by asus on 16/5/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDGoodsInfoController.h"
#import "FDGoodsInfoHeadView.h"
#import "FDGoodsInfoView.h"
#import "FDGoodInfoBarView.h"
#import "FDGoodsRemarkView.h"



@interface FDGoodsInfoController (){
    
    UIScrollView *_bgScrollView;
    
    /**
     *  起到scrollview的中介作用，自动布局必须要有这个中介
     */
    UIView *_containerView;
    /**
     *  收藏
     */
    UIButton *_rightBarBtn;
    
    /**
     *  hearview
     */
    FDGoodsInfoHeadView *_infoHeadView;
    
    /**
     *  商品细节图
     */
    FDGoodsInfoView *_infoView;
    
    /**
     *  购买说明
     */
    FDGoodsRemarkView *_remarkView;
    
    /**
     *  info切换bar
     */
    FDGoodInfoBarView *_barView;
}

@end

@implementation FDGoodsInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    
    [self setupViews];
    
    [self setupContraints];
    
    [self infoView]; //默认进入info 界面
}


- (void)setupNav
{
    self.title = @"商品详情";
    
    _rightBarBtn = [[UIButton alloc] init];
    _rightBarBtn.frame = CGRectMake(0, 0, 23, 23);
    
    [_rightBarBtn setBackgroundImage:[UIImage imageNamed:@"icon_collect_nor"] forState:UIControlStateNormal];
    [_rightBarBtn setBackgroundImage:[UIImage imageNamed:@"icon_collect_pre"] forState:UIControlStateSelected];
    [_rightBarBtn addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

}


- (void)setupViews
{
    //scrollview
    _bgScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_bgScrollView];
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    _bgScrollView.showsVerticalScrollIndicator = NO;
    _bgScrollView.scrollEnabled = YES;
    _bgScrollView.directionalLockEnabled = YES;
    _bgScrollView.backgroundColor = [UIColor clearColor];
    
    
    _containerView = [[UIView alloc] init];
    [_bgScrollView addSubview:_containerView];
    
    _infoHeadView = [[FDGoodsInfoHeadView alloc] init];
    [_containerView addSubview:_infoHeadView];
    _infoHeadView.model = self.model;
    
  
    _barView = [[FDGoodInfoBarView alloc] init];
    [_containerView addSubview:_barView];
    
    __weak typeof(self) _weakView = self;
    _barView.infoBtnClickBlock = ^{
        //添加infoview,移除remarkview
        [_weakView infoView];
    };
    
    _barView.remarkBtnClickBlock = ^{
        //添加remarkview,移除infoview
        [_weakView remarkView];
    };
}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
    [_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_weakSelf.view);
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bgScrollView);
        make.width.equalTo(_bgScrollView);
    }];

    [_infoHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.left.and.right.equalTo(_containerView);
    }];
    
    [_barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_infoHeadView.mas_bottom);
        make.left.and.right.equalTo(_containerView);
    }];
    
    
}


#pragma mark - 公共方法
//添加infoview,移除remarkview
- (void)infoView
{
    if (_remarkView) {
        [_remarkView removeFromSuperview];
        _remarkView = nil;
    }
    _infoView = [[FDGoodsInfoView alloc] init];
    [_containerView addSubview:_infoView];
    _infoView.model = self.model;

    //添加约束
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_barView.mas_bottom);
        make.left.and.right.equalTo(_containerView);
        make.bottom.equalTo(_containerView.mas_bottom);
    }];
    
    //修改约束
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_infoView);  //约束底部
    }];
}

//添加remarkview,移除infoview
- (void)remarkView
{
    if (_infoView) {
        [_infoView removeFromSuperview];
        _infoView = nil;
    }
    
    _remarkView = [[FDGoodsRemarkView alloc] init];
    [_containerView addSubview:_remarkView];
    _remarkView.model = self.model;
    
    //添加约束
    [_remarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_barView.mas_bottom);
        make.left.and.right.equalTo(_containerView);
        make.bottom.equalTo(_containerView.mas_bottom);
    }];
    
    //修改约束
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_remarkView);  //约束底部
    }];
}

/**
 *  收藏
 */
- (void)collectClick
{
    _rightBarBtn.selected = !_rightBarBtn.selected;
    FDLog(@"收藏");
}
/**
 *  懒加载设置数据
 */
- (void)setModel:(FDGoodsModel *)model
{
    _model = model;
    
}
@end



