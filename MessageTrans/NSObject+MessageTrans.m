//
//  TT.m
//  MessageTransTest
//
//  Created by zhangbin on 14-10-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NSObject+MessageTrans.h"
#import <objc/runtime.h>

//get rid of next line when you public your application
#undef DEBUG

@implementation NSObject(MessageTrans)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject exchangeMethod:@selector(methodSignatureForSelector:) withMethod:@selector(messageTrans_methodSignatureForSelector:)];
        [NSObject exchangeMethod:@selector(forwardInvocation:) withMethod:@selector(messageTrans_forwardInvocation:)];
    });
}

+ (BOOL)exchangeMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod =class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
        return NO;
    }
    
    Method altMethod =class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(altSel), [self class]);
        return NO;
    }
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),class_getInstanceMethod(self, altSel));
    
    return YES;
}

#pragma mark - Method Swizzling

- (NSMethodSignature *)messageTrans_methodSignatureForSelector:(SEL)aSelector {
#ifndef DEBUG
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
#else
    return [self messageTrans_methodSignatureForSelector:aSelector];
#endif
}

- (void)messageTrans_forwardInvocation:(NSInvocation *)anInvocation
{
#ifndef DEBUG
    NSString *className = NSStringFromClass([self class]);
    NSString *selName = NSStringFromSelector([anInvocation selector]);
    NSLog(@"%@找不到%@方法,不作处理防止崩溃",className,selName);
#else
    [self messageTrans_forwardInvocation:anInvocation];
#endif
}

@end
