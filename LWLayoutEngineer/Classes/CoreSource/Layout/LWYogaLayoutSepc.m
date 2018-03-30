//
//  LWYogaLayoutSepc.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/29.
//

#import "LWYogaLayoutSepc.h"
#import "Yoga.h"
#import "LWAssert.h"
#import "YogaStyle.h"
#import "LWYogaUtilities.h"

@implementation LWYogaLayoutSepc

- (LWLayout *)layoutThatFits:(CGSize)constrainedSize{
    NSArray *child = self.children;
    if (child.count == 0) {
        return [LWLayout layoutWithLayoutElement:self size:constrainedSize];
    }
    YGNodeRef *node = self.layoutStyle.yogaStyle.yogaNode;
    YGRemoveAllChildren(node);
    NSUInteger i = 0;
    for (id<LWLayoutable> layoutElement in child) {
        LWLayoutEngineerAssert([layoutElement conformsToProtocol:@protocol(LWLayoutable)], @"child must conformsToProtocol LWLayoutable");
        const YGNodeRef childNode = layoutElement.layoutStyle.yogaStyle.yogaNode;
        YGNodeRef parent = YGNodeGetParent(childNode);
        if (parent != NULL) {
            YGNodeRemoveChild(parent, childNode);
        }
        YGNodeInsertChild(node, childNode, i);
        i++;
    }
    
    YGNodeCalculateLayout(node, constrainedSize.width, constrainedSize.height, YGNodeStyleGetDirection(node));
    
    return nil;
}



@end
