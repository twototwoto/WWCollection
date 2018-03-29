//
//  WYWPractiseLoopCollectionViewCell.h
//  WWCollection
//
//  Created by WYW on 2018/3/29.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WYWPractiseLoopViewCellViewModel.h"

@interface WYWPractiseLoopCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) WYWPractiseLoopViewCellViewModel *loopViewCellViewModel;
/**背景图片*/
@property (nonatomic,strong) UIImageView *backgroundImageView;

/**文字说明*/
@property (nonatomic,strong) UILabel *titleLabel;




@end
