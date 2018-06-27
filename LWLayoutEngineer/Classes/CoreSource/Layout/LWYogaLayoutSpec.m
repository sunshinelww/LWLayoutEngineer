//
//  LWYogaLayoutSepc.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/29.
//

#import "LWYogaLayoutSpec.h"
#import "Yoga.h"
#import "LWAssert.h"
#import "YogaStyle.h"
#import "LWYogaUtilities.h"

@implementation LWYogaLayoutSpec

- (LWLayout *)layoutThatFits:(CGSize)constrainedSize {
    NSArray *child = self.children;
    if (child.count == 0) {
        return [LWLayout layoutWithLayoutElement:self size:constrainedSize];
    }
    YGNodeRef node = self.layoutStyle.yogaStyle.yogaNode;
    YGRemoveAllChildren(node);
    NSUInteger i = 0;
    for (id<LWLayoutable> layoutElement in child) {
        LWLayoutEngineerAssert([layoutElement conformsToProtocol:@protocol(LWLayoutable)], @"child must conformsToProtocol LWLayoutable");
        const YGNodeRef childNode = layoutElement.layoutStyle.yogaStyle.yogaNode;
        YGNodeRef parent = YGNodeGetParent(childNode);
        if (parent != NULL) {
            YGNodeRemoveChild(parent, childNode);
        }
        YGRemoveAllChildren(childNode);
        YGNodeSetMeasureFunc(childNode, YGMeasureView);
        YGNodeInsertChild(node, childNode, i);
        i++;
    }
    
    YGNodeCalculateLayout(node, constrainedSize.width, constrainedSize.height, YGNodeStyleGetDirection(node));
    
    id<LWLayoutable> layoutElement = (__bridge id <LWLayoutable>)YGNodeGetContext(node);
    
    CGPoint position = CGPointMake(YGNodeLayoutGetLeft(node), YGNodeLayoutGetTop(node));
    CGSize size = (CGSize) {
        .width = YGNodeLayoutGetWidth(node),
        .height = YGNodeLayoutGetHeight(node)
    };
    return [LWLayout layoutWithLayoutElement:layoutElement size:size position:LWPointNull sublayoutElems:[self YGApplyLayoutToSubElement:position]];
}

- (NSArray<LWLayout *> *)YGApplyLayoutToSubElement:(CGPoint)origin {
    NSArray *child = self.children;
    NSMutableArray *subLayout = [NSMutableArray array];
    for (id<LWLayoutable> layoutElement in child) {
        const YGNodeRef childNode = layoutElement.layoutStyle.yogaStyle.yogaNode;
        LWLayout *layout = [layoutElement layoutThatFits:CGSizeMake(YGNodeLayoutGetWidth(childNode), YGNodeLayoutGetHeight(childNode))];
        layout.position = (CGPoint) {
            .x = YGNodeLayoutGetTop(childNode) + origin.x,
            .y = YGNodeLayoutGetLeft(childNode) + origin.y
        };
        [subLayout addObject:layout];
    }
    return subLayout;
}

static YGSize YGMeasureView(
                            YGNodeRef node,
                            float width,
                            YGMeasureMode widthMode,
                            float height,
                            YGMeasureMode heightMode) {
    const CGFloat constrainedWidth = (widthMode == YGMeasureModeUndefined) ? CGFLOAT_MAX : width;
    const CGFloat constrainedHeight = (heightMode == YGMeasureModeUndefined) ? CGFLOAT_MAX: height;
    id<LWLayoutable> layoutElement = (__bridge id <LWLayoutable>)YGNodeGetContext(node);
    LWLayoutEngineerCAssert([layoutElement conformsToProtocol:@protocol(LWLayoutable)], @"node must contain a LWLayoutable");
    LWLayout *layout = [layoutElement layoutThatFits:(CGSize) {
        .width = constrainedWidth,
        .height = constrainedHeight,
    }];
    return (YGSize) {
        .width = layout.size.width,
        .height = layout.size.height
    };
}

@end
