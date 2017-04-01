//
//  PublicMethod.m
//  XZPhotoBrowser
//
//  Created by 徐洋 on 16/8/6.
//  Copyright © 2016年 徐洋. All rights reserved.
//

#import "PublicMethod.h"

@implementation PublicMethod

+ (CGFloat)getImageHeight:(CGSize)size width:(CGFloat)width
{
    float integerW = size.width;
    float integerH = size.height;
    float scale = width / integerW;
    NSNumber *number = [NSNumber numberWithFloat:scale * integerH];
    return [number floatValue];
}

@end
