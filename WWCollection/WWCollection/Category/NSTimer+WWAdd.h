//
//  NSTimer+WWAdd.h
//  WWPractise
//
//  Created by WYW on 2018/1/26.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WWAdd)
+ (NSTimer *)eoc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)(void))block
                                        repeats:(BOOL)repeats;

@end
