//
//  Header.h
//  SelectImage
//
//  Created by ZZCN77 on 2017/4/1.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define widthScale WIDTH / 375.0
#define heightScale HEIGHT / 667.0
#define imageWidth  72
/////// 不建议设置太大，太大的话会导致图片加载过慢
#define kMaxImageWidth 500
#define kViewWidth      [[UIScreen mainScreen] bounds].size.width
//如果项目中设置了导航条为不透明，即[UINavigationBar appearance].translucent=NO，那么这里的kViewHeight需要-64
#define kViewHeight     [[UIScreen mainScreen] bounds].size.height
#define CollectionName [[NSBundle mainBundle].infoDictionary valueForKey:(__bridge NSString *)kCFBundleNameKey]
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define kcolor [UIColor colorWithRed:49.0/256.0f green:216.0/256.0f blue:255/256.0f alpha:1.0]

#endif /* Header_h */
