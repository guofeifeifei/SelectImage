//
//  PhotosCollectionViewCell.h
//  DaGuanYun
//
//  Created by ZZCN77 on 16/9/28.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHPhotoList.h"
@interface PhotosCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * photoimageView;
@property (nonatomic, strong) UILabel * photosNameLable;
@property (nonatomic, strong) UILabel * photosCountLable;
@property (nonatomic, strong) UILabel * photosNameLable1;
-(void)configUi:(LHPhotoAblumList *)album;

@end
