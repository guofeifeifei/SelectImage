//
//  BrowserViewController.h
//  DaGuanYun
//
//  Created by ZZCN77 on 16/9/29.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BrowserViewController : UIViewController
@property (nonatomic, strong) UICollectionView *collectionView;
/**
 *  数据源
 */
@property (nonatomic, copy) NSArray *dataArray;
/**
 *  当前显示的item下标
 */
@property (nonatomic, assign) NSInteger selectIndex;





@end
