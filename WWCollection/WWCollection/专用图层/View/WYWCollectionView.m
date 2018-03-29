//
//  WYWCollectionView.m
//  WWCollection
//
//  Created by WYW on 2018/3/28.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWCollectionView.h"
#import "WYWCollectionViewCell.h"

@interface WYWCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end
@implementation WYWCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self prepareData];
        [self setupUI];
    }
    return self;
}

- (void)prepareData{
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[WYWCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCellReuseID"];
}

- (void)setupUI{
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WYWCollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"collectionViewCellReuseID" forIndexPath:indexPath];
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor yellowColor];
    }
    return cell;
}



//- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    WYWCollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"collectionViewCellReuseID" forIndexPath:indexPath];
//    if (indexPath.row % 2) {
//        cell.backgroundColor = [UIColor blueColor];
//    }else{
//        cell.backgroundColor = [UIColor yellowColor];
//    }
//    return cell;
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15.f;
}



@end
