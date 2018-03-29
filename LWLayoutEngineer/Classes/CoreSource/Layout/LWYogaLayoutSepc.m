//
//  LWYogaLayoutSepc.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/29.
//

#import "LWYogaLayoutSepc.h"
#import "Yoga.h"
#import "LWAssert.h"

@implementation LWYogaLayoutSepc

- (LWLayout *)layoutThatFits:(CGSize)constrainedSize{
    NSArray *child = self.children;
    if (child.count == 0) {
        return [LWLayout layoutWithLayoutElement:self size:constrainedSize];
    }
    
    LWLayoutStyle *style = self.layoutStyle;
    LWLayoutEngineerAssert(style.yogaStyle != nil, @"yoga layoutSpec can");
}

@end
