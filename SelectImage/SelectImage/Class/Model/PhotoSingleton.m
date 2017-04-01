//
//  PhotoSingleton.m
//  DaGuanYun
//
//  Created by ZZCN77 on 16/10/10.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import "PhotoSingleton.h"

@implementation PhotoSingleton
+ (PhotoSingleton *)sharedSingleton{
    static PhotoSingleton *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        _sharedInstance = [[PhotoSingleton alloc] init];
       
        
    });
    
    return _sharedInstance;
}
- (id)init{
    if (self = [super init])
    {
        self.sendImageArray= [[NSMutableArray alloc] init];
        self.sendCrameImageArray = [[NSMutableArray alloc] init];
        self.photoSetArray = [[NSMutableArray alloc] init];
        self.sendPhotoPathArray = [[NSMutableArray alloc] init];
        self.linkPhoteBool = NO;
        self.isFirstUpload = YES;
    }
    
    return self;
}

@end
