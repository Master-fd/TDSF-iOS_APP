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
#import "FDDiscoverViewController.h"


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
    __weak typeof(self) _weakSelf = self;
    if (!self.image) {
        [FDMBProgressHUB showError:@"请添加图片"];
        return;
    }
    if (!_addDiscoverView.contentTextView.text.length) {
        [FDMBProgressHUB showError:@"请编辑文字"];
        return;
    }

    [FDHomeNetworkTool addDiscoverWithName:[FDUserInfo shareFDUserInfo].name image:self.image content:_addDiscoverView.contentTextView.text success:^(NSArray *results) {
        if (_weakSelf.didSendDiscoverBlock) {
            _weakSelf.didSendDiscoverBlock(_weakSelf.image, _weakSelf.addDiscoverView.contentTextView.text);
        }
    } failure:^(NSInteger statusCode, NSString *message) {
        //发布失败，提示
        [FDMBProgressHUB showError:@"发布失败,请稍后重发"];

    }];
    
    //返回
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[FDDiscoverViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _addDiscoverView.image = image;
}

@end
