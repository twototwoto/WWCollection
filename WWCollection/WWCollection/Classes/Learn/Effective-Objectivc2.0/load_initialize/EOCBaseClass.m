//
//  EOCBaseClass.m
//  WWCollection
//
//  Created by WYW on 2018/3/31.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "EOCBaseClass.h"

@implementation EOCBaseClass
+ (void)load{
    WWLog(@"%@",[self class]);
}

+ (void)initialize{
    WWLog(@"%@",[self class]);
}
@end
