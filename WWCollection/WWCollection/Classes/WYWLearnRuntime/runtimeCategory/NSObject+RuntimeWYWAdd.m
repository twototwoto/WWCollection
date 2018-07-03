//
//  NSObject+RuntimeWYWAdd.m
//  WWCollection
//
//  Created by WYW on 2018/7/3.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "NSObject+RuntimeWYWAdd.h"
#import <objc/runtime.h>

@implementation NSObject (RuntimeWYWAdd)

+ (NSArray *)wyw_fetchIvarList{
    unsigned int count = 0;
    /**
     * Ivar  _Nonnull * class_copyIvarList(Class cls, unsigned int *outCount);
     - 传入的count的地址 接下来 count的值将会是 类里边的属性的变量的个数
     * Describes the instance variables declared by a class.
     * 描述类声明的实例变量
     cls
     The class to inspect. 内省的类
     outCount
     On return, contains the length of the returned array. If outCount is NULL, the length is not returned.
     返回数组的长度 如果outCount 是NULL 长度不会返回
     
     An array of pointers of type Ivar describing the instance variables declared by the class. Any instance variables declared by superclasses are not included. The array contains *outCount pointers followed by a NULL terminator.
     You must free the array with free(). 必须使用释放数组 使用free
     If the class declares no instance variables, or cls is Nil, NULL is returned and *outCount is 0.
     SDKs    iOS 2.0+, macOS 10.5+, tvOS 9.0+, watchOS 2.0+
     */
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    NSMutableArray *instanceArrM = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i ++) {
        NSMutableDictionary *instanceDictM = [NSMutableDictionary dictionaryWithCapacity:2];
        /**
         const char * ivar_getName(Ivar v);
         Description
         Returns the name of an instance variable.
         返回实例变量的名字
         */
        const char *ivarName = ivar_getName(ivarList[i]);
        
        /**
         const char * ivar_getTypeEncoding(Ivar v);
         Description
         Returns the type string of an instance variable.
         返回实例变量的类型
         */
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        /**
         * + (instancetype)stringWithUTF8String:(const char *)nullTerminatedCString;
         Description
         Returns a string created by copying the data from a given C array of UTF8-encoded bytes.
         
         */
        instanceDictM[@"type"] = [NSString stringWithUTF8String:ivarType];
        instanceDictM[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        
        [instanceArrM addObject:instanceDictM];
        
    }
    //class_copyIvarList 明确表示 必须要free数组
    free(ivarList);
    
    return [instanceArrM copy];
    
}

@end
