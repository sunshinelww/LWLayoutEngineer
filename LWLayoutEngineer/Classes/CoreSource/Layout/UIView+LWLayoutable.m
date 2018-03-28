//
//  UIView+LWLayoutable.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/27.
//

#import "UIView+LWLayoutable.h"
#import <objc/runtime.h>

@implementation UIView (LWLayoutable)


- (LWLayoutElementType)layoutElementType{
    return LWLayoutElementTypeView;
}

- (LWLayoutStyle *)layoutStyle{
    LWLayoutStyle *style = objc_getAssociatedObject(self, _cmd);
    if (!style) {
        style = [[LWLayoutStyle alloc] init];
        objc_setAssociatedObject(self, _cmd, style, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return style;
}

- (LWLayout *)layoutThatFits:(CGSize)constrainedSize{
    return nil;
}

- (nonnull NSArray<id<LWLayoutable>> *)sublayoutElements {
    return nil;
}


@end
