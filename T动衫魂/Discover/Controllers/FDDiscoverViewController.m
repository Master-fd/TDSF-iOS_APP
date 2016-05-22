//
//  FDDiscoverViewController.m
//  T动衫魂
//
//  Created by asus on 16/5/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDiscoverViewController.h"
#import "FDDiscoverViewCell.h"
#import "FDDiscoverModel.h"
#import "FDAddDiscoverViewController.h"

@interface FDDiscoverViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**
 *  数据源，每个都是FDDiscoverModel
 */
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation FDDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];
}

- (void)setupNav
{
    self.navigationItem.title = @"买家秀";
    
    
    //添加买家秀按钮
    UIButton *rightBarBtn = [[UIButton alloc] init];
    rightBarBtn.frame = CGRectMake(0, 0, 23, 23);
    
    [rightBarBtn setBackgroundImage:[UIImage imageNamed:@"Fav_Note_ToolBar_Camera_HL"] forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(addDiscoverClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)setupViews
{
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    
    _tableView.rowHeight = [UIScreen mainScreen].bounds.size.width*4/3;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[FDDiscoverViewCell class] forCellReuseIdentifier:kcellID];
    
    //添加约束
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDDiscoverModel *model = self.dataSource[indexPath.row];
    
    FDDiscoverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellID forIndexPath:indexPath];
        
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


/**
 *  懒加载
 *
 *  @return datasource
 */
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray array];
        
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i =0; i<5; i++) {
            FDDiscoverModel *model = [[FDDiscoverModel alloc] init];
            [arrayM addObject:model];
        }
        
        _dataSource = arrayM;
    }
    return _dataSource;
}

/**
 *  发布自己的秀
 */
- (void)addDiscoverClick
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"发布自己的买家秀" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [sheet showInView:self.view];
    });
    
   
}


/**
 *  打开相册,或则相机
 *  yes  打开相册，  no 打开相机
 */
- (void)openAlbum:(BOOL)Album
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;   //系统自带的编辑框

    if (Album) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.showsCameraControls = YES;
    }

    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //打开相机
            [self openAlbum:NO];
            break;
            
        case 1:
            //打开相册
            [self openAlbum:YES];
            break;
            
            
        default:
            break;
    }
}


#pragma mark - UIImagePickerController delegate
//选择了图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    image = [image imageWithSize:CGSizeMake(320, 480) equal:NO];
    
    FDAddDiscoverViewController *vc = [[FDAddDiscoverViewController alloc] init];
 
    vc.hidesBottomBarWhenPushed = YES;
    vc.image = [image imageWithSize:CGSizeMake(960, 1280) equal:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    Method method = class_getInstanceMethod([self class], @selector(drawRect:));
//    UIViewController *vc = [navigationController viewControllers][0];
//    
//    class_replaceMethod([[[vc.view subviews][0] subviews][0] class],@selector(drawRect:),method_getImplementation(method),method_getTypeEncoding(method));
//}
@end
