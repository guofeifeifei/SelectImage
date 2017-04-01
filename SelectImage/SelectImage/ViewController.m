//
//  ViewController.m
//  SelectImage
//
//  Created by ZZCN77 on 2017/4/1.
//  Copyright © 2017年 ZZCN77. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "LHPhotoList.h"
#import "PhotosCollectionViewCell.h"
#import "SelectPictureViewController.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PHPhotoLibraryChangeObserver>
@property (nonatomic,strong) NSMutableArray<LHPhotoAblumList *> *listArray;//all photos
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.collectionView registerClass:[PhotosCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
      _listArray = [NSMutableArray new];
    [self getPhotoData];
    self.navigationController.navigationBar.translucent = NO;
    
}
#pragma mark --- 获取所有图片资源
- (void)getPhotoData{
    
    [_listArray removeAllObjects];
    [_listArray addObjectsFromArray:[[LHPhotoList sharePhotoTool]getPhotoAblumList]];
    NSLog(@"%@", _listArray);
    [self createUI];
}
#pragma mark -delegate
-(void)photoLibraryDidChange:(PHChange *)changeInstance{
    __weak ViewController *weakSelf = self;
    dispatch_sync(dispatch_get_main_queue(), ^{
        __strong ViewController *strongSelf = weakSelf;
        [_listArray removeAllObjects];
        [_listArray addObjectsFromArray:[[LHPhotoList sharePhotoTool]getPhotoAblumList]];
        [strongSelf.collectionView reloadData];
    });
    
}
- (void)createUI{
    [self.view addSubview:self.collectionView];
}
#pragma mark ---------- UICollectionView代理方法

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat w = WIDTH/3;
    CGFloat h = WIDTH/3 + 10 * widthScale;
    return CGSizeMake(w, h);
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _listArray.count ;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotosCollectionViewCell *cell = (PhotosCollectionViewCell *)[collectionView  dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.row <=0) {
        LHPhotoAblumList *album = _listArray[indexPath.row];
        [cell configUi:album];
    }
    
   
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotosCollectionViewCell *cell = (PhotosCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    SelectPictureViewController *selectPictureVC = [[SelectPictureViewController alloc] init];
    selectPictureVC.photoName = cell.photosNameLable.text;
    selectPictureVC.album = _listArray[indexPath.row];
    [selectPictureVC returnSelectImageCountBlock:^(NSString *imagecount, NSString *allImageCount) {
        if (([imagecount isEqualToString:@"0"])) {
            cell.photosCountLable.text = [NSString stringWithFormat:@"%@", allImageCount];
            
        }else{
            cell.photosCountLable.text = [NSString stringWithFormat:@"%@(已选择%@)", allImageCount,imagecount];
        }
        
    }];
    
    [self.navigationController pushViewController:selectPictureVC animated:YES];
    
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * fl = [[UICollectionViewFlowLayout alloc]init];
        fl.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:fl];
        self.collectionView.backgroundColor= self.view.backgroundColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor =kcolor ;
    }
    return _collectionView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
