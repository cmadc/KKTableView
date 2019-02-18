//
//  NSObject+InvokeMethod.m
//  Example
//
//  Created by CaiMing on 2019/2/18.
//  Copyright © 2019年 CaiMing. All rights reserved.
//

#import "NSObject+InvokeMethod.h"

@implementation NSObject (InvokeMethod)

- (void)invokeMethodWithMethodName:(NSString*)methodName param:(id)param{
    SEL selector = NSSelectorFromString(methodName);
    if ([[self class] instancesRespondToSelector:selector]) {
        IMP imp = [self methodForSelector:selector];
        void(*func)(id, SEL, NSDictionary*) = (void *)imp;
        func(self, selector,param);
    }
    
    
}

@end
