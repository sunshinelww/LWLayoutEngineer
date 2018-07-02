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
#import "UIView+LWLayoutable.h"

@interface LWViewSpec : NSObject

@property (nonatomic, strong)UIView *view;
@property (nonatomic, strong)LWYogaLayoutSpec *layoutSpec;

- (instancetype)initWithView:(UIView *)view layoutSpec:(LWYogaLayoutSpec *)spec;

@end

@implementation LWViewSpec

- (instancetype)initWithView:(UIView *)view layoutSpec:(LWYogaLayoutSpec *)spec {
    self = [super init];
    if (self) {
        self.view = view;
        self.layoutSpec = spec;
    }
    return self;
}

@end

@implementation LWYogaLayoutSpec

- (LWLayout *)layoutThatFits:(CGSize)constrainedSize {
    NSArray *child = self.children; ///获取的是孩子节点（View或者是Spec）
    if (child.count == 0) {
        return [LWLayout layoutWithLayoutElement:self size:constrainedSize];
    }
    YGNodeRef node = self.layoutStyle.yogaStyle.yogaNode;
    YGRemoveAllChildren(node);
    NSUInteger i = 0;
    for (id<LWLayoutable> layoutElement in child) {
        LWLayoutEngineerAssert([layoutElement conformsToProtocol:@protocol(LWLayoutable)], @"child must conformsToProtocol LWLayoutable");
        YGNodeRef childNode = layoutElement.layoutStyle.yogaStyle.yogaNode;
        YGNodeRef parent = YGNodeGetParent(childNode);
        if (parent != NULL) {
            YGNodeRemoveChild(parent, childNode);
        }
        YGRemoveAllChildren(childNode);
        YGNodeSetDecisionFunc(childNode, YGMeasureDecisionImpl);
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
    LWLayout *layout = [LWLayout layoutWithLayoutElement:layoutElement size:size position:LWPointNull sublayoutElems:[self YGApplyLayoutToSubElement:position rootNode:node]];
    return layout;
}

- (NSArray<LWLayout *> *)YGApplyLayoutToSubElement:(CGPoint)origin rootNode:(YGNodeRef)rootNode { //从nodewanxia
    if (!rootNode) {
        return @[];
    }
    NSUInteger count = YGNodeGetChildCount(rootNode);
    if (count == 0) {
        return @[];
    }
    NSMutableArray *subLayout = [NSMutableArray array];
    for (NSUInteger i = 0; i < count; i++) {
        YGNodeRef node = YGNodeGetChild(rootNode, i);
        id context = (__bridge id)YGNodeGetContext(node);
        LWLayout *layout = nil;
        if ([context isKindOfClass:[LWViewSpec class]]) {
            UIView * layoutElement = [(LWViewSpec *)context view];
            CGSize size = CGSizeMake(YGNodeLayoutGetWidth(node), YGNodeLayoutGetHeight(node));
            layout = [LWLayout layoutWithLayoutElement:layoutElement size:size sublayoutElems:@[]];
            layout.position = (CGPoint) {
                .x = YGNodeLayoutGetLeft(node) + origin.x,
                .y = YGNodeLayoutGetTop(node) + origin.y
            };
            //这里需要手动设置为yoga容器的UIView布局
            [layoutElement setLayout:[LWLayout layoutWithLayoutElement:layoutElement size:size position:CGPointZero sublayoutElems:[self YGApplyLayoutToSubElement:CGPointZero rootNode:node]]];
        } else {
            id<LWLayoutable> layoutElement = context;
            CGPoint position = (CGPoint) {
                .x = YGNodeLayoutGetLeft(node) + origin.x,
                .y = YGNodeLayoutGetTop(node) + origin.y
            };
            CGSize size = CGSizeMake(YGNodeLayoutGetWidth(node), YGNodeLayoutGetHeight(node));
            layout = [LWLayout layoutWithLayoutElement:layoutElement size:size position:position sublayoutElems:[self YGApplyLayoutToSubElement:position rootNode:node]];
        }
        [subLayout addObject:layout];
    }
    return subLayout;
}
//用来决定node是否是叶子节点
//如果是叶子节点,则直接设置MeasureFunc，否则遍历其child节点，构建node树
static void YGMeasureDecisionImpl(YGNodeRef node,
                                  float width,
                                  YGMeasureMode widthMode,
                                  float height,
                                  YGMeasureMode heightMode) {
    id context = (__bridge id)YGNodeGetContext(node); //这里避免出现第二次布局时候context在第一次被修改的情况
    id<LWLayoutable> layoutElement = nil;
    if ([context isKindOfClass:[LWViewSpec class]]) {
        layoutElement = ((LWViewSpec *)context).view;
    } else {
        layoutElement = context;
    }
    
    if ([layoutElement isKindOfClass:[UIView class]]) { //如果是UIView
        const CGFloat constrainedWidth = (widthMode == YGMeasureModeUndefined) ? CGFLOAT_MAX : width;
        const CGFloat constrainedHeight = (heightMode == YGMeasureModeUndefined) ? CGFLOAT_MAX: height;
        LWLayoutSpec *spec = [(UIView *)layoutElement layoutableThatFits:(CGSize) {
            .width = constrainedWidth,
            .height = constrainedHeight,
        }]; //获取view的spec
        if ([spec isKindOfClass:[LWYogaLayoutSpec class]]) { //view是yoga容器
            NSArray *child = spec.children;
            YGRemoveAllChildren(node);
            uint32_t i = 0;
            for (id<LWLayoutable> layoutElement in child) {
                YGNodeRef childNode = layoutElement.layoutStyle.yogaStyle.yogaNode;
                YGNodeRef parent = YGNodeGetParent(childNode);
                if (parent != NULL) {
                    YGNodeRemoveChild(parent, childNode);
                }
                YGRemoveAllChildren(childNode);
                YGNodeSetDecisionFunc(childNode, YGMeasureDecisionImpl);
                YGNodeInsertChild(node, childNode, i);
                i++;
            }
            //构建view和spec的对应关系
            LWViewSpec *viewSpec = [[LWViewSpec alloc] initWithView:(UIView *)layoutElement layoutSpec:(LWYogaLayoutSpec *)spec];
            //将spec的yogaNode添加到yoga树
            YGNodeSetContext(node, (__bridge_retained void*)viewSpec);
            layoutElement.layoutStyle.specLayoutEnabled = YES;
        } else {
            YGNodeSetMeasureFunc(node, YGMeasureView);
        }
    } else if ([layoutElement isKindOfClass:[LWYogaLayoutSpec class]]) {
        NSArray *child = ((LWYogaLayoutSpec *)layoutElement).children;
        YGRemoveAllChildren(node);
        uint32_t i = 0;
        for (id<LWLayoutable> layoutElement in child) {
            YGNodeRef childNode = layoutElement.layoutStyle.yogaStyle.yogaNode;
            YGNodeRef parent = YGNodeGetParent(childNode);
            if (parent != NULL) {
                YGNodeRemoveChild(parent, childNode);
            }
            YGRemoveAllChildren(childNode);
            YGNodeSetDecisionFunc(childNode, YGMeasureDecisionImpl);
            YGNodeInsertChild(node, childNode, i);
            i++;
        }
    } else {
        YGNodeSetMeasureFunc(node, YGMeasureView);
    }
}

static YGSize YGMeasureView(YGNodeRef node,
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
