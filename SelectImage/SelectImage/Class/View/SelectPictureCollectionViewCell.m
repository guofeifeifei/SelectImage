//
//  SelectPictureCollectionViewCell.m
//  DaGuanYun
//
//  Created by ZZCN77 on 16/9/28.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import "SelectPictureCollectionViewCell.h"

@implementation SelectPictureCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI{
    [self.contentView addSubview:self.pictureImageView];
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.videoImageView];
    
}
- (UIImageView *)pictureImageView{
    if (_pictureImageView == nil) {
        
        self.pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WIDTH-2)/3,(WIDTH-2)/3- 20 * widthScale)];
        self.pictureImageView.backgroundColor = [UIColor grayColor];
        self.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.pictureImageView.clipsToBounds = YES;

    }
    return _pictureImageView;
    
}

- (UIButton *)selectBtn{
    if (_selectBtn == nil) {
        CGFloat ivX = self.pictureImageView.frame.size.width;
        
        
        self.selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(ivX*3/4 - 2, 2, ivX/4,ivX/4)];
        
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"noSelect"] forState:UIControlStateNormal];
        
//        [self.selectBtn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        

    }
    return _selectBtn;
}
- (UIImageView *)videoImageView{
    if (_videoImageView == nil) {
        self.videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (WIDTH-2)/3 - 40 * widthScale, 20, 20)];
     
    }
    return _videoImageView;
}
//- (void)touchBtn:(UIButton *)sender{
//    
//    
//    self.btnAction();
//}
@end
