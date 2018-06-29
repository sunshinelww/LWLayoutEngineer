//
//  LWInternalHelper.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#import "LWInternalHelper.h"
#import "LWAssert.h"

FOUNDATION_EXTERN CGFloat LWScreenScale() {
    static CGFloat __scale = 0.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LWLayoutEngineerCAssertMainThread();
        __scale = [UIScreen mainScreen].scale;
    });
    return __scale;
}


void exchangeMethod(Class aClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(aClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(aClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
