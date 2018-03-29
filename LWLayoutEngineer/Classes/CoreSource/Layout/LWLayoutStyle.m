//
//  LWLayoutStyle.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/27.
//

#import "LWLayoutStyle.h"
#import "YogaStyle.h"

@implementation LWLayoutStyle{
    CGSize _size;
}

@dynamic width, height, preferredSize;

- (instancetype)init{
    self = [super init];
    if (self) {
        _size = CGSizeZero;
    }
    return self;
}

- (CGFloat)width{
    return _size.width;
}

- (void)setWidth:(CGFloat)width{
    CGSize newSize = _size;
    newSize.width = width;
    _size = newSize;
}

- (CGFloat)height{
    return _size.height;
}

- (void)setHeight:(CGFloat)height{
    CGSize newSize = _size;
    newSize.height = height;
    _size = newSize;
}

- (CGSize)preferredSize{
    return CGSizeMake(_size.width, _size.height);
}

- (void)setPreferredSize:(CGSize)preferredSize{
    CGSize newSize = _size;
    newSize.width = preferredSize.width;
    newSize.height = preferredSize.height;
}

- (YogaStyle *)yogaStyle{
    if (!_yogaStyle) { //设置默认的yoGaStyle
        _yogaStyle = [[YogaStyle alloc] init];
    }
    return _yogaStyle;
}

@end
