//
//  PhotoDetailItemCollectionViewCell.m
//  DaGuanYun
//
//  Created by ZZCN77 on 16/9/29.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import "PhotoDetailItemCollectionViewCell.h"

@implementation PhotoDetailItemCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatView];
        
    }
    return self;
}
- (void)creatView{
    [self.contentView addSubview:self.detailImageView];
    [self.contentView addSubview:self.selectImageBtn];
    [self.contentView addSubview:self.selectImageLable];

  

}
- (UIImageView *)detailImageView{
    if (_detailImageView == nil) {
        self.detailImageView = [UIImageView new];
        
        self.detailImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.detailImageView.userInteractionEnabled = YES;

    }
    return _detailImageView;
    
}
- (UIButton *)selectImageBtn{
    if (_selectImageBtn == nil) {
        self.selectImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH - 40 * widthScale, self.bounds.size.height  - 95, 20 , 20 )];
        [self.selectImageBtn setBackgroundImage:[UIImage imageNamed:@"noSelect"] forState:UIControlStateNormal];

        
    }
    return _selectImageBtn;
}
- (UILabel *)selectImageLable{
    if (_selectImageLable == nil) {
        self.selectImageLable = [[UILabel alloc] initWithFrame:CGRectMake(20 * widthScale, self.frame.size.height - 100 , 200 * widthScale, 30)];
        self.selectImageLable.textAlignment = NSTextAlignmentLeft;
        self.selectImageLable.textColor = [UIColor whiteColor];
        self.selectImageLable.font = [UIFont systemFontOfSize:18.0f];
        self.selectImageLable.text =@"选中";

    }
    return _selectImageLable;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.detailImageView.frame = CGRectMake(0, 0, WIDTH, self.frame.size.height -100);
}

@end
