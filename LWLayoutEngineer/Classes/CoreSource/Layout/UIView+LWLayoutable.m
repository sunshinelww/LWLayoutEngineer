//
//  UIView+LWLayoutable.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/27.
//

#import "UIView+LWLayoutable.h"
#import <objc/runtime.h>
#import "LWInternalHelper.h"

@implementation UIView (LWLayoutable)


+ (void)load { //hook UIView的LayoutSubViews方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        exchangeMethod(self, @selector(layoutSubviews), @selector(LW_layoutSubviews));
    });
}

- (void)LW_layoutSubviews {
    if (self.layoutStyle.specLayoutEnabled) {
        [self applySubLayouts];
    }
    [self LW_layoutSubviews];
}

- (void)applySubLayouts {
    for (UIView *view in self.subviews) {
        CGRect frame = [self.caculatedViewLayout frameForElement:view];
        if (!CGRectIsNull(frame)) {
            view.frame = frame;
        }
    }
}

- (LWLayoutElementType)layoutElementType {
    return LWLayoutElementTypeView;
}

- (LWLayoutStyle *)layoutStyle {
    LWLayoutStyle *style = objc_getAssociatedObject(self, _cmd);
    if (!style) {
        style = [[LWLayoutStyle alloc] initWithLayoutElement:self];
        objc_setAssociatedObject(self, _cmd, style, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return style;
}

- (LWLayoutSpecBlock)layoutSpecBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLayoutSpecBlock:(LWLayoutSpecBlock)layoutSpecBlock {
    objc_setAssociatedObject(self, @selector(layoutSpecBlock), layoutSpecBlock, OBJC_ASSOCIATION_COPY);
}

- (LWLayout *)caculatedViewLayout {
    return objc_getAssociatedObject(self, @selector(caculatedViewLayout));
}

- (void)setCaculatedViewLayout:(LWLayout *)pendingViewLayout {
    objc_setAssociatedObject(self, @selector(caculatedViewLayout), pendingViewLayout, OBJC_ASSOCIATION_RETAIN);
}

- (LWLayoutSpec *)layoutSpecThatFits:(CGSize)constrainedSize {
    return nil; //由子类view自己实现
}

- (LWLayout *)layoutThatFits:(CGSize)constrainedSize {
    LWLayoutSpec *layoutSpec = [self layoutableThatFits:constrainedSize];
    if (!layoutSpec) { //  没有使用layoutSpec，那么采用手动布局
        CGSize size = [self sizeThatFits:constrainedSize];
        return [LWLayout layoutWithLayoutElement:self size:size];
    }
    self.layoutStyle.specLayoutEnabled = YES;

    LWLayout *layout = [layoutSpec layoutThatFits:constrainedSize];
    BOOL isFinalLayoutElement = (layout.layoutElement != self);
    if (isFinalLayoutElement) {
        layout.position = CGPointZero;
        layout = [LWLayout layoutWithLayoutElement:self size:layout.size sublayoutElems:@[layout]];
    }
    layout = [layout filteredViewLayoutTree];
    self.caculatedViewLayout = layout;
    return layout;
}

- (void)setLayout:(LWLayout *)layout {
    layout = [layout filteredViewLayoutTree];
    self.caculatedViewLayout = layout;
}

- (LWLayoutSpec *)layoutableThatFits:(CGSize)constrainedSize {
    if (self.layoutSpecBlock != nil) {
        return self.layoutSpecBlock(constrainedSize);
    } else {
        return [self layoutSpecThatFits:constrainedSize];
    }
}

- (nonnull NSArray<id<LWLayoutable>> *)sublayoutElements {
    return nil;
}


@end
