//
//  WYWPraciseLoopView.m
//  WWCollection
//
//  Created by WYW on 2018/3/29.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWPraciseLoopView.h"

#import "WYWPractiseLoopCollectionViewCell.h"

#import "WYWPractiseLoopViewFlowLayout.h"

static NSString *const kLoopCollectionViewCellReuseIDString = @"kLoopCollectionViewCellReuseIDString";
@interface WYWPraciseLoopView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@end

@implementation WYWPraciseLoopView{
    UICollectionViewFlowLayout *_flowLayout;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareData];
        [self setupUI];
    }
    return self;
}

- (void)prepareData{
    
}
- (void)setupUI{
    [self setupLoopCollectionView];
   
}

- (void)layoutSubviews{
    _flowLayout.itemSize = self.bounds.size;
}

- (void)setupLoopCollectionView{
//    WYWPractiseLoopViewFlowLayout
     WYWPractiseLoopViewFlowLayout *flowLayout = [WYWPractiseLoopViewFlowLayout new];
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout = flowLayout;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = self.bounds.size;
    
//    flowLayout.itemSize = CGSizeMake(self.frame.size.width / 3.0f, self.frame.size.height); ceilf
//    flowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width / 3.0f), self.frame.size.height);
    flowLayout.itemSize = self.bounds.size;
    
    
    
    _loopCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _loopCollectionView.pagingEnabled = YES;
    _loopCollectionView.delegate = self;
    _loopCollectionView.dataSource = self;
    
    [_loopCollectionView registerClass:[WYWPractiseLoopCollectionViewCell class] forCellWithReuseIdentifier:kLoopCollectionViewCellReuseIDString];
    
    [self addSubview:_loopCollectionView];
    
    
    UIImageView *imageView = [UIImageView new];
    [self insertSubview:imageView belowSubview:_loopCollectionView];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIColor purpleColor];
    imageView.frame = self.bounds;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //目前考虑一组轮播图的情况
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return _imageURLStringArray.count;
    return self.loopViewModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WYWPractiseLoopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLoopCollectionViewCellReuseIDString forIndexPath:indexPath];
    
    WYWPractiseLoopViewCellViewModel *loopViewCellViewModel = [WYWPractiseLoopViewCellViewModel new];
    loopViewCellViewModel.loopViewmodel = self.loopViewModelArray[indexPath.row];
    cell.loopViewCellViewModel = loopViewCellViewModel;
    
    return cell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 0;
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//- (UICollectionView *)loopCollectionView{
//    if (_loopCollectionView) {
//        //懒加载目前没想到写的方式 因为要用到相应的flowLayout的尺寸
//    }
//    return _loopCollectionView;
//}

@end
