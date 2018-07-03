//
//  ViewController.m
//  TestDragHeaderCollectionView
//
//  Created by liangzhimy on 2018/7/2.
//  Copyright © 2018年 laig. All rights reserved.
//

#import "ViewController.h"
#import "ZLCollectionFlowLayout.h"
#import "ZLCollectionViewCell.h"
#import "ZLCollectionReusableView.h"

static NSString *const __ZLHeaderViewIdentification = @"ZLCollectionReusableView";
static NSString *const __ZLCollectionViewCellIdentification = @"ZLCollectionViewCell";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __configView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)__configView{
    ZLCollectionFlowLayout *collectionLayout = [[ZLCollectionFlowLayout alloc] init];
    collectionLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    collectionLayout.itemSize = CGSizeMake(width, 40);
    collectionLayout.headerReferenceSize = CGSizeMake(width, 60);
    _collectionView.collectionViewLayout = collectionLayout;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        ZLCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:__ZLHeaderViewIdentification forIndexPath:indexPath];
        headView.titleLabel.text = @"Title";
        return headView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:__ZLCollectionViewCellIdentification forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"Hello world %zi", indexPath.row];
    return cell;
}


@end
