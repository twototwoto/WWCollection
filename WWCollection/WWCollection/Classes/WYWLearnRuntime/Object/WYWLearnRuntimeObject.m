//
//  WYWLearnRuntimeObject.m
//  WWCollection
//
//  Created by WYW on 2018/7/3.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "WYWLearnRuntimeObject.h"
@interface WYWLearnRuntimeObject()
{
    NSString *_stringVariable1;
    BOOL _boolVariable2;
}
@property (nonatomic,copy) NSString *privateProperty;

@end

@implementation WYWLearnRuntimeObject
{
    NSInteger *_intergerVariable;
}

+ (void)classMethod:(NSString *)param{
    WWLog(@"");
}

- (void)publicInstanceMethod:(NSString *)param{
    WWLog(@"");
}

- (void)privateMethod{
    WWLog(@"");
}
@end
