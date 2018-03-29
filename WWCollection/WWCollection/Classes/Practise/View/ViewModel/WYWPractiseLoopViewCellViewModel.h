//
//  WYWPractiseLoopViewCellViewModel.h
//  WWCollection
//
//  Created by WYW on 2018/3/29.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "WYWPractiseLoopViewModel.h"

@interface WYWPractiseLoopViewCellViewModel : NSObject

@property (nonatomic,strong) WYWPractiseLoopViewModel *loopViewmodel;

@property (nonatomic,strong) UIImage* backgroundImage;
@property (nonatomic,strong) NSString *titleString;

@end
