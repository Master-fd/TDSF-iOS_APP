//
//  FDAddDiscoverViewController.m
//  T动衫魂
//
//  Created by asus on 16/5/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAddDiscoverViewController.h"
#import "FDAddDiscoverView.h"


@interface FDAddDiscoverViewController()

@property (nonatomic, strong) FDAddDiscoverView *addDiscoverView;
@end

@implementation FDAddDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    [self setupViews];
}

- (void)setupNav
{
    self.navigationItem.title = @"添加买家秀";
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(sendDiscoverBtnDidClick)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}


- (void)setupViews
{
    _addDiscoverView = [[FDAddDiscoverView alloc] init];
    [self.view addSubview:_addDiscoverView];
    _addDiscoverView.image = self.image;
    
    //添加约束
    [_addDiscoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


/**
 *  发布买家秀
 */
- (void)sendDiscoverBtnDidClick
{
    FDLog(@"联网发布");
    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _addDiscoverView.image = image;
}

@end
