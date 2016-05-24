//
//  FDAddDiscoverViewController.m
//  T动衫魂
//  编辑自己将要发布的秀
//  Created by asus on 16/5/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAddDiscoverViewController.h"
#import "FDAddDiscoverView.h"
#import "FDHomeNetworkTool.h"

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
 *  联网发布买家秀,post方式上传图片
 */
- (void)sendDiscoverBtnDidClick
{
    if (!self.image) {
        [FDMBProgressHUB showError:@"请添加图片"];
        return;
    }
    if (!_addDiscoverView.contentTextView.text.length) {
        [FDMBProgressHUB showError:@"请编辑文字"];
        return;
    }

    [FDHomeNetworkTool addDiscoverWithImage:self.image content:_addDiscoverView.contentTextView.text success:^{
        FDLog(@"发布成功");
        
    } failure:^{
        //发布失败，提示
        [FDMBProgressHUB showError:@"发布失败,请稍后重发"];
    }];
    
    //返回
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _addDiscoverView.image = image;
}

@end
