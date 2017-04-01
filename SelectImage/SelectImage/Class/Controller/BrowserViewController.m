//
//  BrowserViewController.m
//  DaGuanYun
//
//  Created by ZZCN77 on 16/9/29.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import "BrowserViewController.h"
#import "PhotoDetailItemCollectionViewCell.h"
#import "PublicMethod.h"
#import <Photos/Photos.h>
#import "PhotoSingleton.h"
@interface BrowserViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, NSStreamDelegate>{
//    UITapGestureRecognizer *_recognizerTap;
    NSInputStream *_inputStream;//对应输入流
    NSOutputStream *_outputStream;//对应输出流
    BOOL _linkStatus;
    
}
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) NSString *host;

@property (nonatomic, strong) UIView *projectionView;
@property (nonatomic, strong) UIButton *projectionBtn1;
@property (nonatomic, strong) UIButton *projectionBtn2;
@property (nonatomic, strong) NSString *sendProjectionStr;

@end

@implementation BrowserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:self.sendBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    //注册
    [self.collectionView registerClass:[PhotoDetailItemCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    //将集合视图添加到view上
    [self.view addSubview:self.collectionView];
    //设置集合视图偏移量
    self.collectionView.contentOffset = CGPointMake(self.view.frame.size.width * self.selectIndex, 0);
    
   }












// 设置分区内视图个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
// 设置视图cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoDetailItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    [cell.selectImageBtn setBackgroundImage:[UIImage imageNamed:@"noSelect"] forState:UIControlStateNormal];
    cell.selectImageBtn.selected = NO;
    //添加的
    if ([PhotoSingleton sharedSingleton].sendImageArray.count >= 1) {
        for (int i = 0; i < [PhotoSingleton sharedSingleton].sendImageArray.count; i++) {
            if ([[[PhotoSingleton sharedSingleton].sendImageArray[i] localIdentifier ] isEqualToString:[self.dataArray[indexPath.row] localIdentifier]]){
                [cell.selectImageBtn setBackgroundImage:[UIImage imageNamed:@"Select"] forState:UIControlStateNormal];
                cell.selectImageBtn.selected = YES;
                
            }
            
        }
    }
    //显示一个不清楚的图片
    [[PHImageManager defaultManager] requestImageForAsset:self.dataArray[indexPath.row] targetSize:CGSizeMake(0, 0) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.detailImageView.image = result;
        
        //资源转图片
        [[PHImageManager defaultManager] requestImageDataForAsset:self.dataArray[indexPath.row] options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            cell.detailImageView.image = [UIImage imageWithData:imageData];
            
        }];
        
    }];
    
    [cell.selectImageBtn addTarget:self action:@selector(selectAction:event:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectImageLable.text = [NSString stringWithFormat:@"选中(%lu)",[PhotoSingleton sharedSingleton].sendImageArray.count];
    
    cell.backgroundColor = kcolor;
    return cell;
}
- (void)selectAction:(UIButton *)btn event:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    PhotoDetailItemCollectionViewCell *cell = (PhotoDetailItemCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (cell.selectImageBtn.selected == NO) {
        
      
        
        [cell.selectImageBtn setBackgroundImage:[UIImage imageNamed:@"Select"] forState:UIControlStateNormal];
        cell.selectImageBtn.selected = YES;
        
        [[PhotoSingleton sharedSingleton].sendImageArray addObject:self.dataArray[indexPath.row]];
        
    }else{
        [cell.selectImageBtn setBackgroundImage:[UIImage imageNamed:@"noSelect"] forState:UIControlStateNormal];
        [[PhotoSingleton sharedSingleton].sendImageArray removeObject: self.dataArray[indexPath.row]];
        cell.selectImageBtn.selected = NO;
        
        
    }
    [self removeDuplicatesData];
    cell.selectImageLable.text = [NSString stringWithFormat:@"选中(%lu)",[PhotoSingleton sharedSingleton].sendImageArray.count];
}
- (void)removeDuplicatesData{
    //去除重复的
    if ([PhotoSingleton sharedSingleton].sendImageArray.count > 1) {
        for (int i = 0; i < [PhotoSingleton sharedSingleton].sendImageArray.count; i++) {
            for (int j = i+1; j < [PhotoSingleton sharedSingleton].sendImageArray.count; j++) {
                
                if ([[[PhotoSingleton sharedSingleton].sendImageArray[i] localIdentifier ] isEqualToString:[[PhotoSingleton sharedSingleton].sendImageArray[j] localIdentifier ]]) {
                    [[PhotoSingleton sharedSingleton].sendImageArray removeObjectAtIndex:j];
                }
                
            }
        }
    }
    
    
}

// 设置分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
/**
 *  点击事件
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
}


#pragma mark ---- 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // item尺寸
        flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor =  kcolor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

//数据源
- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSArray new];
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
