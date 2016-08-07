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
#import "FDGoodsModel.h"
#import "FDCollectModel.h"

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
    
    [_rightBarBtn setBackgroundImage:[UIImage imageNamed:@"icon_collect_pre"] forState:UIControlStateNormal];
    [_rightBarBtn addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

}


- (void)setupViews
{
    //scrollview
    _bgScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_bgScrollView];
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
    
    if ([FDUserInfo shareFDUserInfo].isLogin) {
        
        __weak typeof(self) _weakSelf = self;
        FDCollectModel *collectModel = [[FDCollectModel alloc] init];
        collectModel.goodsInfoModel = _weakSelf.model;
        
        [FDHomeNetworkTool getCollectWithName:[FDUserInfo shareFDUserInfo].name success:^(NSArray *results) {
            
            __block BOOL isCollected = NO;
            
            [results enumerateObjectsUsingBlock:^(FDCollectModel *obj, NSUInteger idx, BOOL *stop) {
                
                FDGoodsModel *goodsInfoModel = obj.goodsInfoModel;
                
                if ([goodsInfoModel.name isEqualToString:_weakSelf.model.name]
                    && [goodsInfoModel.subClass isEqualToString:_weakSelf.model.subClass]
                    && [goodsInfoModel.sex isEqualToString:_weakSelf.model.sex]
                    && [goodsInfoModel.minImageUrl1 isEqualToString:_weakSelf.model.minImageUrl1]
                    && [goodsInfoModel.descImageUrl1 isEqualToString:_weakSelf.model.descImageUrl1])
                {
                    //已经收藏过了
                    isCollected = YES;
                    *stop = YES;
                }
            }];
            
            if (!isCollected) {
                //同步到网络
                [FDHomeNetworkTool postCollectWithName:[FDUserInfo shareFDUserInfo].name model:collectModel operation:kOperationAddKey success:^(NSArray *results) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [FDMBProgressHUB showSuccess:@"已收藏"];
                    });
                } failure:^(NSInteger statusCode, NSString *message) {
                    FDLog(@"收藏失败");
                }];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [FDMBProgressHUB showError:@"已经收藏过了"];
                });
            }
        } failure:^(NSInteger statusCode, NSString *message) {
            [FDHomeNetworkTool postCollectWithName:[FDUserInfo shareFDUserInfo].name model:collectModel operation:kOperationAddKey success:^(NSArray *results) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [FDMBProgressHUB showSuccess:@"已收藏"];
                });
            } failure:^(NSInteger statusCode, NSString *message) {
                FDLog(@"收藏失败");
            }];
        }];
        
        
        
    }else{
        FDLoginController *vc = [[FDLoginController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}
/**
 *  懒加载设置数据
 */
- (void)setModel:(FDGoodsModel *)model
{
    _model = model;
    
}
@end



