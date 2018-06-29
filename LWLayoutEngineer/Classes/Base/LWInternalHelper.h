//
//  LWInternalHelper.h
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


FOUNDATION_EXTERN CGFloat LWScreenScale(void);

FOUNDATION_EXTERN void exchangeMethod(Class aClass, SEL oldSel, SEL newSEL);
