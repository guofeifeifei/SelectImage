//
//  SelectPictureViewController.h
//  DaGuanYun
//
//  Created by ZZCN77 on 16/9/28.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHPhotoList.h"
typedef void (^ReturnSelectImageCountBlock)(NSString *imagecount ,NSString *allImageCount);
@interface SelectPictureViewController : UIViewController
@property (nonatomic,strong) LHPhotoAblumList *album;

@property (nonatomic, strong) NSArray *pictureArray;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSString *dataType;

@property (nonatomic, copy) ReturnSelectImageCountBlock returnSelectImageCountBlock;
- (void)returnSelectImageCountBlock:(ReturnSelectImageCountBlock)block;
@end
