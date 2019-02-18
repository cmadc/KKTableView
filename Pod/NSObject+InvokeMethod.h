//
//  NSObject+InvokeMethod.h
//  Example
//
//  Created by CaiMing on 2019/2/18.
//  Copyright © 2019年 CaiMing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (InvokeMethod)

- (void)invokeMethodWithMethodName:(NSString*)methodName param:(id)param;

@end

NS_ASSUME_NONNULL_END
