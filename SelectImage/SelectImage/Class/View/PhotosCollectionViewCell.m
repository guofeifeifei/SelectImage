//
//  PhotosCollectionViewCell.m
//  DaGuanYun
//
//  Created by ZZCN77 on 16/9/28.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import "PhotosCollectionViewCell.h"

@implementation PhotosCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    
    return self;
    
}

- (void)createUI{

    [self.contentView addSubview:self.photoimageView];
     [self.contentView addSubview:self.photosNameLable];
     [self.contentView addSubview:self.photosCountLable];
    [self.contentView addSubview:self.photosNameLable1];

    
}
- (UIImageView *)photoimageView{
    if (_photoimageView == nil) {
        self.photoimageView= [[UIImageView alloc]initWithFrame:CGRectMake(10 * widthScale, 10 * widthScale, self.contentView.frame.size.width - 20 * widthScale, self.contentView.frame.size.height - 50 * widthScale)];
        self.photoimageView.backgroundColor = [UIColor grayColor];
        self.photoimageView.contentMode = UIViewContentModeScaleAspectFill;
        self.photoimageView.clipsToBounds = YES;
    }
    return _photoimageView;
    
}

- (UILabel *)photosNameLable{
    if (_photosNameLable == nil) {
        self.photosNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 30 * widthScale, self.contentView.frame.size.width, 15 * widthScale)];
        self.photosNameLable.textAlignment = NSTextAlignmentCenter;
        self.photosNameLable.textColor = [UIColor whiteColor];
        self.photosNameLable.font = [UIFont systemFontOfSize:15.0f * widthScale];

        
    }
    return _photosNameLable;
}
- (UILabel *)photosCountLable{
    if (_photosCountLable == nil) {
        self.photosCountLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 15 * widthScale, self.contentView.frame.size.width, 15 * widthScale)];
        self.photosCountLable.textAlignment = NSTextAlignmentCenter;
        self.photosCountLable.textColor = [UIColor whiteColor];
        self.photosCountLable.font = [UIFont systemFontOfSize:12.0f * widthScale];
        
    }
    return _photosCountLable;
    
}

- (UILabel *)photosNameLable1{
    if (_photosNameLable1 == nil) {
        
    self.photosNameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 30 * widthScale, self.contentView.frame.size.width, 18 * widthScale)];
    self.photosNameLable1.textAlignment = NSTextAlignmentCenter;
    self.photosNameLable1.textColor = [UIColor whiteColor];
    self.photosNameLable1.font = [UIFont systemFontOfSize:18.0f * widthScale];
    }
    return _photosNameLable1;
}
#pragma mark -show ui
-(void)configUi:(LHPhotoAblumList *)album{
    if (album.headImageAsset.mediaType == PHAssetMediaTypeImage) {
        
    
    [[LHPhotoList sharePhotoTool] requestImageForAsset:album.headImageAsset size:CGSizeMake(72*3, 72*3) resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
        self.photoimageView.image = image;
    }];
    self.photosNameLable1.text = @"";
    self.photosNameLable.text = [NSString stringWithFormat:@"%@",album.title];
    self.photosCountLable.text =[NSString stringWithFormat:@"%ld",album.count];
    }
}
@end
