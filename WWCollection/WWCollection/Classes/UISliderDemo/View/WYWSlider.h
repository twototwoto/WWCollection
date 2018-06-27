//
//  WYWSlider.h
//  WWCollection
//
//  Created by WYW on 2018/6/27.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYWSlider;
@protocol WYWSliderTapDelegate<NSObject>;

@optional
- (void)sliderTapDelgateGesture:(UITapGestureRecognizer *_Nullable)tapGes;
@end
@interface WYWSlider : UISlider
@property (nonatomic,weak) id _Nullable tapSliderDelegate;
@end
