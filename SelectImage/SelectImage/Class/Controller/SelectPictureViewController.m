//
//  SelectPictureViewController.m
//  DaGuanYun
//
//  Created by ZZCN77 on 16/9/28.
//  Copyright © 2016年 ZZCN77. All rights reserved.
//

#import "SelectPictureViewController.h"
#import "SelectPictureCollectionViewCell.h"
#import <Photos/Photos.h>
#import "BrowserViewController.h"
#import "LHPhotoList.h"
#import "PhotoSingleton.h"
@interface SelectPictureViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSUInteger _imagecountFetchResult;
    NSUInteger _imagecountAssetCollection;
    
}


@property (nonatomic,strong) NSArray<PHAsset *>*assetArray;//相册集里面的所有图片

@property (nonatomic, strong) NSMutableArray *selectPictureArray;
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation SelectPictureViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (self.selectPictureArray.count != 0) {
        [self.selectPictureArray removeAllObjects];
    }
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.assetArray = [NSMutableArray new];
    self.assetArray =  [[LHPhotoList sharePhotoTool]getAssetsInAssetCollection:self.album.assetCollection ascending:NO];
    
    [self.collectionView registerClass:[SelectPictureCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
    
}

- (void)returnSelectImageCountBlock:(ReturnSelectImageCountBlock)block{
    self.returnSelectImageCountBlock = block;
}




- (void)aDDselectData{

    [[PhotoSingleton sharedSingleton].sendImageArray addObjectsFromArray:self.selectPictureArray];
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
    
    //    }
}

#pragma mark ---- cv协议
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH-8)/3, (WIDTH-8)/3-20*widthScale);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.assetArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SelectPictureCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectBtn.selected = NO;
    
    if (!cell) {
        cell = [SelectPictureCollectionViewCell new];
    }
    
    //第一张图的资源
    PHAsset *asset = self.assetArray[indexPath.row];
    cell.selectBtn.selected = NO;
    if (asset.mediaType == PHAssetMediaTypeImage) {
       
    
        
        //添加的
        if ([PhotoSingleton sharedSingleton].sendImageArray.count >= 1) {
            for (int i = 0; i < [PhotoSingleton sharedSingleton].sendImageArray.count; i++) {
                if ([[[PhotoSingleton sharedSingleton].sendImageArray[i] localIdentifier ] isEqualToString:asset.localIdentifier]){
                    [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"Select"] forState:UIControlStateNormal];
                    
                    cell.selectBtn.selected = YES;
                    [self.selectPictureArray addObject:asset];
                }
                
                
            }
        }else{
                      cell.selectBtn.selected = NO;
            
        }
   
    
       //资源转图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake((WIDTH-2)/3, (WIDTH-2)/3) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        cell.pictureImageView.image = result;
        
        
    }];
       
    }
    [cell.selectBtn addTarget:self action:@selector(touchBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (void)touchBtn:(UIButton *)sender event:(UIEvent *)event{
    
    
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    SelectPictureCollectionViewCell *cell =(SelectPictureCollectionViewCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
    if (cell.selectBtn.selected == NO) {
        
        if (self.assetArray.count > indexPath.row) {
            [self.selectPictureArray addObject:self.assetArray[indexPath.row]];
        }
        [self aDDselectData];
        
        [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"Select"] forState:UIControlStateNormal];
        cell.selectBtn.selected = YES;
           }else{
        if (self.assetArray.count > indexPath.row) {
            [self.selectPictureArray removeObject:self.assetArray[indexPath.row]];
        }
        [[PhotoSingleton sharedSingleton].sendImageArray removeObject:self.assetArray[indexPath.row]];
        [self aDDselectData];
        
        [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"noSelect"] forState:UIControlStateNormal];
               cell.selectBtn.selected = NO;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BrowserViewController *browserVC = [[BrowserViewController alloc] init];
    browserVC.dataArray = self.assetArray;
    browserVC.selectIndex = indexPath.row;
    [self.navigationController pushViewController:browserVC animated:YES];
}
#pragma mark  ------------ 懒加载
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * fl = [[UICollectionViewFlowLayout alloc]init];
        fl.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:fl];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = kcolor;
        
        
    }
    return _collectionView;
    
}



- (NSMutableArray *)selectPictureArray{
    if (_selectPictureArray == nil) {
        self.selectPictureArray = [NSMutableArray new];
        
    }
    return _selectPictureArray;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if (self.returnSelectImageCountBlock != nil) {
        self.returnSelectImageCountBlock([NSString stringWithFormat:@"%lu", (unsigned long)self.selectPictureArray.count],[NSString stringWithFormat:@"%lu", self.assetArray.count]);
    }
    
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
