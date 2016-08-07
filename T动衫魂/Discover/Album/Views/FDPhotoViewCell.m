//
//  FDPhotoViewCell.m
//  MSTVTool
//
//  Created by asus on 16/6/22.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDPhotoViewCell.h"

@interface FDPhotoViewCell(){
    
    UIImageView *_imageView;
    
}

@end

@implementation FDPhotoViewCell


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
    
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    
}

- (void)setupContraints
{

    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    dispatch_async(dispatch_get_main_queue(), ^{
        _imageView.image = image;
    });
    
}


@end
