//
//  WYWLearnRuntimeObject.h
//  WWCollection
//
//  Created by WYW on 2018/7/3.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYWLearnRuntimeObject : NSObject

@property (nonatomic,copy) NSString *publicProperty;

+ (void)classMethod:(NSString *)param;
- (void)publicInstanceMethod:(NSString *)param;

@end
