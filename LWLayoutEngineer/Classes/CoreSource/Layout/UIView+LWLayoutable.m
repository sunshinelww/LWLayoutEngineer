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

- (LWLayoutSepc *)layoutSpecThatFits:(CGSize)constrainedSize{
    return nil; //有子类view自己实现
}

- (LWLayout *)layoutThatFits:(CGSize)constrainedSize{
    LWLayoutSepc *layoutSpec = [self layoutSpecThatFits:constrainedSize];
    if (!layoutSpec) { //  没有使用layoutSpec，那么采用手动布局
        CGSize size = [self sizeThatFits:constrainedSize];
        return [LWLayout layoutWithLayoutElement:self size:size];
    }
    LWLayout *layout = [layoutSpec layoutThatFits:constrainedSize];
    BOOL isFinalLayoutElement = (layout.layoutElement != self);
    if (isFinalLayoutElement) {
        layout.position = CGPointZero;
        layout = [LWLayout layoutWithLayoutElement:self size:layout.size sublayoutElems:@[layout]];
    }
    return layout;
}

- (nonnull NSArray<id<LWLayoutable>> *)sublayoutElements {
    return nil;
}


@end
