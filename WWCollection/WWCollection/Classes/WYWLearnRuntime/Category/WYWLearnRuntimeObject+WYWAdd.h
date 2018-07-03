//
//  WYWLearnRuntimeObject+WYWAdd.h
//  WWCollection
//
//  Created by WYW on 2018/7/3.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWLearnRuntimeObject.h"

@interface WYWLearnRuntimeObject (WYWAdd)
@property (nonatomic,copy) NSString *categoryString;

+ (void)categoryClassMethod;
- (void)categoryPublicInstanceMethod;

@end
