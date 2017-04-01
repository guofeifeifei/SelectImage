//
//  PhotoSingleton.h
//  DaGuanYun
//
//  Created by ZZCN77 on 16/10/10.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoSingleton : NSObject
@property (nonatomic, strong) NSMutableArray *sendImageArray;
@property (nonatomic, strong) NSMutableArray *sendCrameImageArray;
@property (nonatomic, strong) NSMutableArray *photoSetArray;
@property (nonatomic, strong) NSMutableArray *sendPhotoPathArray;

@property (nonatomic, assign) NSInteger isFirstUpload;

@property (nonatomic, assign) NSInteger linkPhoteBool;
+ (PhotoSingleton *)sharedSingleton;
@end
