//
//  FDGoodsSelectBarView.m
//  T动衫魂
//
//  Created by asus on 16/5/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDGoodsSelectBarView.h"
#import "FDSelectInfoView.h"

@interface FDGoodsSelectBarView()
/**
 *  筛选性别
 */
@property (nonatomic, strong) UIButton *selectSexBtn;

/**
 *  筛选分类
 */
@property (nonatomic, strong) UIButton *selectSubClassBtn;

/**
 *  性别bar
 */
@property (nonatomic, strong) FDSelectInfoView *sexSelectBarView;

/**
 *  分类bar
 */
@property (nonatomic, strong) FDSelectInfoView *subClassSelectBarView;
@end


@implementation FDGoodsSelectBarView


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
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClick)];
    [self addGestureRecognizer:tapGesture];
    
    _selectSexBtn = [[UIButton alloc] init];
    [self addSubview:_selectSexBtn];
    _selectSexBtn.layer.borderColor = kFrenchGreyColor.CGColor;
    _selectSexBtn.layer.borderWidth = 1;
    _selectSexBtn.selected = NO;
    _selectSexBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_selectSexBtn setBackgroundColor:kWhiteColor];
    [_selectSexBtn setTitle:@"性别" forState:UIControlStateNormal];
    [_selectSexBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_selectSexBtn setTitleColor:kRoseColor forState:UIControlStateSelected];
    [_selectSexBtn addTarget:self action:@selector(sexSelectClick) forControlEvents:UIControlEventTouchUpInside];
    
    _selectSubClassBtn = [[UIButton alloc] init];
    [self addSubview:_selectSubClassBtn];
    _selectSubClassBtn.layer.borderColor = kFrenchGreyColor.CGColor;
    _selectSubClassBtn.layer.borderWidth = 1;
    _selectSubClassBtn.selected = NO;
    _selectSubClassBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_selectSubClassBtn setBackgroundColor:kWhiteColor];
    [_selectSubClassBtn setTitle:@"分类" forState:UIControlStateNormal];
    [_selectSubClassBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_selectSubClassBtn setTitleColor:kRoseColor forState:UIControlStateSelected];
    [_selectSubClassBtn addTarget:self action:@selector(subClassSelectClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupContraints
{
    __weak typeof(self) _weakSelf = self;
    [_selectSexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf);
        make.left.equalTo(_weakSelf);
        make.height.equalTo(@40);
        make.width.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/2]);
    }];
    
    [_selectSubClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weakSelf);
        make.left.equalTo(_selectSexBtn.mas_right);
        make.height.equalTo(@40);
        make.width.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/2]);
    }];
    
    /**
     *  添加自身默认约束
     */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
    }];

}


- (void)sexSelectClick
{
    
    if ([_selectSexBtn.titleLabel.text isEqualToString:@"性别"]) {
        _selectSexBtn.selected = NO;
    }
    if ([_selectSubClassBtn.titleLabel.text isEqualToString:@"分类"]) {
        _selectSubClassBtn.selected = NO;
    }
    
    if (_subClassSelectBarView) {
        [_subClassSelectBarView removeFromSuperview];
        _subClassSelectBarView = nil;
    }
    if (_sexSelectBarView) {
        [_sexSelectBarView removeFromSuperview];
        _sexSelectBarView = nil;
        //更新约束
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
        }];
        return;
    }
    //更新约束
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.height]);
    }];
    _selectSexBtn.selected = YES;
    
   
    NSArray *titleArray = @[@"重置", @"男", @"女"];
    _sexSelectBarView = [[FDSelectInfoView alloc] init];
    [self addSubview:_sexSelectBarView];
    _sexSelectBarView.titleArray = titleArray;
    
    __weak typeof(self) _weakSelf = self;
    _sexSelectBarView.btnDidClickBlock =^(NSString *btnTitle){
        [_weakSelf.sexSelectBarView removeFromSuperview];
        _weakSelf.sexSelectBarView = nil;

        if ([btnTitle isEqualToString:titleArray[0]]) {
            [_weakSelf.selectSexBtn setTitle:@"性别" forState:UIControlStateNormal];
            _weakSelf.selectSexBtn.selected = NO;
        }else{
            [_weakSelf.selectSexBtn setTitle:btnTitle forState:UIControlStateNormal];
            _weakSelf.selectSexBtn.selected = YES;

        }
        
        //更新自身约束
        [_weakSelf mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
        }];
    };
    
    //添加约束
    [_sexSelectBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectSexBtn.mas_bottom);
        make.left.and.right.equalTo(_selectSexBtn);
    }];
    
    

}

- (void)subClassSelectClick
{
    if ([_selectSexBtn.titleLabel.text isEqualToString:@"性别"]) {
        _selectSexBtn.selected = NO;
    }
    if ([_selectSubClassBtn.titleLabel.text isEqualToString:@"分类"]) {
        _selectSubClassBtn.selected = NO;
    }

    if (_sexSelectBarView) {
        [_sexSelectBarView removeFromSuperview];
        _sexSelectBarView = nil;
    }
    if (_subClassSelectBarView) {
        [_subClassSelectBarView removeFromSuperview];
        _subClassSelectBarView = nil;
        
        
        //更新约束
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
        }];
        return;
    }
    //更新约束
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.height]);
    }];
    
    _selectSubClassBtn.selected = YES;
    
    NSArray *titleArray = @[@"重置", @"衬衫", @"长袖", @"卫衣"];
    
    _subClassSelectBarView = [[FDSelectInfoView alloc] init];
    [self addSubview:_subClassSelectBarView];
    _subClassSelectBarView.titleArray = titleArray;
    
    __weak typeof(self) _weakSelf = self;
    _subClassSelectBarView.btnDidClickBlock =^(NSString *btnTitle){
        [_weakSelf.subClassSelectBarView removeFromSuperview];
        _weakSelf.subClassSelectBarView = nil;
        
        if ([btnTitle isEqualToString:titleArray[0]]) {
            [_weakSelf.selectSubClassBtn setTitle:@"分类" forState:UIControlStateNormal];
            _weakSelf.selectSubClassBtn.selected = NO;
        }else{
            [_weakSelf.selectSubClassBtn setTitle:btnTitle forState:UIControlStateNormal];
            _weakSelf.selectSubClassBtn.selected = YES;
            
        }
        
        
        //更新约束
        [_weakSelf mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
        }];
    };
    
    //添加约束
    [_subClassSelectBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectSubClassBtn.mas_bottom);
        make.left.and.right.equalTo(_selectSubClassBtn);
    }];
    
    
}

/**
 *  手势识别器，收回bar
 */
- (void)tapGestureClick
{
    if (_sexSelectBarView) {
        [self sexSelectClick];   //单击一次就可以收回
    }
    
    if (_subClassSelectBarView){
        [self subClassSelectClick];     //单击一次就可以收回
    }}
@end
