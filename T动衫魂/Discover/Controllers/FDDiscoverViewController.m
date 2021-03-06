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
#import "FDHomeNetworkTool.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FDAblumViewController.h"
#import "FDAssetsModel.h"

#define kParamidPageKey         @"idPage"                   //第几页，页数从0开始
#define kParamPageSizeKey       @"pageSize"                 //每次请求，页大小的key
#define kParampageSizeValue     @"15"                       //每页数量

@interface FDDiscoverViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**
 *  数据源，每个都是FDDiscoverModel
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  当前的IDstart
 */
@property (nonatomic, assign) NSInteger idPageNow;


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
    rightBarBtn.frame = CGRectMake(0, 0, 25, 25);
    rightBarBtn.imageView.tintColor = [UIColor whiteColor];
    [rightBarBtn setImage:[[UIImage imageNamed:@"Fav_Note_ToolBar_Camera_HL"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [rightBarBtn setImage:[[UIImage imageNamed:@"Fav_Note_ToolBar_Camera"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
    [rightBarBtn addTarget:self action:@selector(addDiscoverClick) forControlEvents:UIControlEventTouchUpInside];

    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)setupViews
{
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[FDDiscoverViewCell class] forCellReuseIdentifier:kcellID];
    
    //添加约束
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //添加下拉刷新控件
    __weak typeof(self) _weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_weakSelf dropDownLoadMoreDiscovers];
    }];
    
    /**
     *  添加上拉刷新
     */
    _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [_weakSelf dropUpLoadMoreDiscovers];
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self dropDownLoadMoreDiscovers];
}
/**
 *  下拉刷新最新数据
 */
- (void)dropDownLoadMoreDiscovers
{
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[kParamidPageKey] = @0;
    params[kParamPageSizeKey] = kParampageSizeValue;

    self.idPageNow = 0;
    __weak typeof(self) _weakSelf = self;
    [FDHomeNetworkTool getDiscoversWithParams:params dropUp:NO success:^(NSArray *results) {
        FDDiscoverModel *newModelTop = [results firstObject];
        FDDiscoverModel *newModelBotton = [results lastObject];
        FDDiscoverModel *oldModelTop = [_weakSelf.dataSource firstObject];
        FDDiscoverModel *oldModelBotton = [_weakSelf.dataSource lastObject];
        
        if ([oldModelTop.ID isEqualToString:newModelTop.ID]
            && [oldModelBotton.ID isEqualToString:newModelBotton.ID]
            && (results.count == _weakSelf.dataSource.count)) {
            //说明没有更新,不变
        } else {
            [_weakSelf.dataSource removeAllObjects];
            [_weakSelf.tableView reloadData];
            [_weakSelf addMoreRowForTableView:results dropUp:NO];
            _weakSelf.idPageNow ++;   //页数增加
        }
        
    } failure:^(NSInteger statusCode, NSString *message) {
        

    }];
    
    [self.tableView.mj_header endRefreshing];
}

/**
 *  上拉加载更多旧数据
 */
- (void)dropUpLoadMoreDiscovers
{
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[kParamidPageKey] = [NSString stringWithFormat:@"%d", self.idPageNow];
    params[kParamPageSizeKey] = kParampageSizeValue;

    __weak typeof(self) _weakSelf = self;
    [FDHomeNetworkTool getDiscoversWithParams:params dropUp:YES success:^(NSArray *results) {
        //获取成功
        [_weakSelf addMoreRowForTableView:results dropUp:YES];
        _weakSelf.idPageNow ++;   //页数增加
    } failure:^(NSInteger statusCode, NSString *message) {
        
    }];
    
    [self.tableView.mj_footer endRefreshing];
}

/**
 *  添加新的数据到tableview显示
 *
 *  @param array     数据
 *  @param direction YES 上拉，NO，下拉
 */
- (void)addMoreRowForTableView:(NSArray *)array dropUp:(BOOL)direction
{
    __weak typeof(self) _weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableArray *indexRows = [[NSMutableArray alloc] init];
        
        for (int i=(int)array.count-1; i>=0; i--) {
            
            FDDiscoverModel *model = array[i];
            if (direction) {  //上拉
                [_weakSelf.dataSource addObject:model];
            } else {//下拉
                [_weakSelf.dataSource insertObject:model atIndex:0];
            }

        }
        for (int i=0; i<array.count; i++) {
            FDDiscoverModel *model = array[i];
            [indexRows addObject:[NSIndexPath indexPathForRow:[_weakSelf.dataSource indexOfObject:model] inSection:0]];
        }
        [_weakSelf.tableView beginUpdates];
            //添加数据
        [_weakSelf.tableView insertRowsAtIndexPaths:indexRows withRowAnimation:UITableViewRowAnimationFade];
        
        [_weakSelf.tableView endUpdates];
    });
}


#pragma mark - uitableviewdelegate

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

    FDDiscoverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellID forIndexPath:indexPath];
    
    [self configDataForCell:cell atIndexPath:indexPath];
    return cell;
}
/**
 *  自适应高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) _weakSelf = self;
    return [tableView fd_heightForCellWithIdentifier:kcellID cacheByIndexPath:indexPath configuration:^(id cell) {
        [_weakSelf configDataForCell:cell atIndexPath:indexPath];
    }];
}

- (void)configDataForCell:(FDDiscoverViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    FDDiscoverModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  懒加载
 *
 *  @return datasource
 */
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
    }
    return _dataSource;
}

/**
 *  发布自己的秀
 */
- (void)addDiscoverClick
{
    //检测是否登录了
    if ([FDUserInfo shareFDUserInfo].isLogin) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"发布自己的买家秀" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
        
        __weak typeof(self) _weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [sheet showInView:_weakSelf.tableView];  //获取相片
        });
    }else{
        //提示登录
        FDLoginController *vc = [[FDLoginController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
   
}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.allowsEditing = NO;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    __weak typeof(self) _weakSelf = self;
    FDAblumViewController *picker = [[FDAblumViewController alloc] init];
    picker.didSelectImageBlock = ^(FDAssetsModel *asset){
        
        __strong typeof(_weakSelf) _strongSelf = _weakSelf;
        UIImage *image = [asset fullScreenImage];//取出全屏图
        //前往发布朋友圈
        [_strongSelf gotoAddDiscoverWithImage:image];
    };
    
    [self.navigationController pushViewController:picker animated:YES];
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //打开相机
            [self openCamera];
            break;
            
        case 1:
            //打开相册
            [self openAlbum];
            break;
            
            
        default:
            break;
    }
}

/**
 *  前往发布朋友圈
 */
- (void)gotoAddDiscoverWithImage:(UIImage *)image
{
    __weak typeof(self) _weakSelf = self;
    
    FDAddDiscoverViewController *vc = [[FDAddDiscoverViewController alloc] init];
    vc.didSendDiscoverBlock = ^(UIImage *image, NSString *content){
        //发布成功
        [_weakSelf dropDownLoadMoreDiscovers];
    };
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.image = image; //直接全屏图
    //前往发布朋友圈
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UIImagePickerController delegate
//选择了图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *image = [originalImage imageWithSize:[UIScreen mainScreen].bounds.size equal:NO]; //全屏图
    
    //前往发布朋友圈
    [self gotoAddDiscoverWithImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
