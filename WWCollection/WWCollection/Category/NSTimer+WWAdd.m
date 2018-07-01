//
//  NSTimer+WWAdd.m
//  WWPractise
//
//  Created by WYW on 2018/1/26.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import "NSTimer+WWAdd.h"

@implementation NSTimer (WWAdd)
+ (NSTimer *)eoc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)(void))block
                                        repeats:(BOOL)repeats{
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(eoc_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)eoc_blockInvoke:(NSTimer *)timer{
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}
@end
