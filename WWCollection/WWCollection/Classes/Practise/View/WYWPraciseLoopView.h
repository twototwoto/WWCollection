//
//  WYWPraciseLoopView.h
//  WWCollection
//
//  Created by WYW on 2018/3/29.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYWPractiseLoopViewModel.h"

@interface WYWPraciseLoopView : UIView

/**滚动collectionView*/
@property (nonatomic,strong) UICollectionView *loopCollectionView;


///**图片URLString数组*/
//@property (nonatomic,copy) NSArray *imageURLStringArray;
//
///**显示的文字的数组*/
//@property (nonatomic,copy) NSArray *titleStringArray;


/**
 关于cell的图片和文字的数据
 */
@property (nonatomic,copy) NSArray <WYWPractiseLoopViewModel *> *loopViewModelArray;

@end
