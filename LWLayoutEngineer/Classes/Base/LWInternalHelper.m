//
//  LWInternalHelper.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#import "LWInternalHelper.h"
#import "LWAssert.h"

FOUNDATION_EXTERN CGFloat LWScreenScale(){
    static CGFloat __scale = 0.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LWLayoutEngineerCAssertMainThread();
        __scale = [UIScreen mainScreen].scale;
    });
    return __scale;
}
