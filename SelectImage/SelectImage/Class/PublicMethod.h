//
//  PublicMethod.h
//  XZPhotoBrowser
//
//  Created by 徐洋 on 16/8/6.
//  Copyright © 2016年 徐洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PublicMethod : NSObject

/**
 *  根据宽高比例获得高
 *
 *  @param size  图片size
 *  @param width 实际宽度
 *
 *  @return 实际高度
 */
+ (CGFloat)getImageHeight:(CGSize)size width:(CGFloat)width;

@end
