//
//  YogaStyle.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#import "YogaStyle.h"
#import "LWInternalHelper.h"
#import "LWYogaUtilities.h"
#import "LWLayoutStyle.h"

static YGConfigRef globalConfig;

#define YG_VALUE_EDGE_PROPERTY_SETTER(objc_lowercased_name, objc_capitalized_name, c_name, edge) \
- (void)set##objc_capitalized_name:(YGValue)objc_lowercased_name                                 \
{                                                                                                \
    switch (objc_lowercased_name.unit) {                                                         \
        case YGUnitUndefined:                                                                    \
            YGNodeStyleSet##c_name(self.yogaNode, edge, objc_lowercased_name.value);             \
            break;                                                                               \
        case YGUnitPoint:                                                                        \
            YGNodeStyleSet##c_name(self.yogaNode, edge, objc_lowercased_name.value);             \
            break;                                                                               \
        case YGUnitPercent:                                                                      \
            YGNodeStyleSet##c_name##Percent(self.yogaNode, edge, objc_lowercased_name.value);    \
            break;                                                                               \
        default:                                                                                 \
            NSAssert(NO, @"Not implemented");                                                    \
    }                                                                                            \
}

#define YG_EDGE_PROPERTY_GETTER(type, lowercased_name, capitalized_name, property, edge) \
- (type)lowercased_name                                                                  \
{                                                                                        \
    return YGNodeStyleGet##property(self.yogaNode, edge);                                \
}

#define YG_EDGE_PROPERTY_SETTER(lowercased_name, capitalized_name, property, edge) \
- (void)set##capitalized_name:(CGFloat)lowercased_name                             \
{                                                                                  \
    YGNodeStyleSet##property(self.yogaNode, edge, lowercased_name);                \
}

#define YG_VALUE_EDGE_PROPERTY(lowercased_name, capitalized_name, property, edge)   \
YG_EDGE_PROPERTY_GETTER(YGValue, lowercased_name, capitalized_name, property, edge) \
YG_VALUE_EDGE_PROPERTY_SETTER(lowercased_name, capitalized_name, property, edge)

#define YG_EDGE_PROPERTY(lowercased_name, capitalized_name, property, edge)         \
YG_EDGE_PROPERTY_GETTER(CGFloat, lowercased_name, capitalized_name, property, edge) \
YG_EDGE_PROPERTY_SETTER(lowercased_name, capitalized_name, property, edge)

#define YG_VALUE_EDGES_PROPERTIES(lowercased_name, capitalized_name)                                                  \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Left, capitalized_name##Left, capitalized_name, YGEdgeLeft)                   \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Top, capitalized_name##Top, capitalized_name, YGEdgeTop)                      \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Right, capitalized_name##Right, capitalized_name, YGEdgeRight)                \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Bottom, capitalized_name##Bottom, capitalized_name, YGEdgeBottom)             \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Start, capitalized_name##Start, capitalized_name, YGEdgeStart)                \
YG_VALUE_EDGE_PROPERTY(lowercased_name##End, capitalized_name##End, capitalized_name, YGEdgeEnd)                      \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Horizontal, capitalized_name##Horizontal, capitalized_name, YGEdgeHorizontal) \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Vertical, capitalized_name##Vertical, capitalized_name, YGEdgeVertical)       \
YG_VALUE_EDGE_PROPERTY(lowercased_name, capitalized_name, capitalized_name, YGEdgeAll)

#define YG_VALUE_PROPERTY(lowercased_name, capitalized_name)                                \
- (YGValue)lowercased_name                                                                  \
{                                                                                           \
    return YGNodeStyleGet##capitalized_name(self.yogaNode);                                 \
}                                                                                           \
                                                                                            \
- (void)set##capitalized_name:(YGValue)lowercased_name                                      \
{                                                                                           \
    switch (lowercased_name.unit) {                                                         \
        case YGUnitUndefined:                                                               \
            YGNodeStyleSet##capitalized_name(self.yogaNode, lowercased_name.value);         \
            break;                                                                          \
        case YGUnitPoint:                                                                   \
            YGNodeStyleSet##capitalized_name(self.yogaNode, lowercased_name.value);         \
            break;                                                                          \
        case YGUnitPercent:                                                                 \
            YGNodeStyleSet##capitalized_name##Percent(self.yogaNode, lowercased_name.value);\
            break;                                                                          \
        default:                                                                            \
            NSAssert(NO, @"Not implemented");                                               \
    }                                                                                       \
}

#define YG_AUTO_VALUE_PROPERTY(lowercased_name, capitalized_name)                           \
- (YGValue)lowercased_name                                                                  \
{                                                                                           \
    return YGNodeStyleGet##capitalized_name(self.yogaNode);                                 \
}                                                                                           \
                                                                                            \
- (void)set##capitalized_name:(YGValue)lowercased_name                                      \
{                                                                                           \
    switch (lowercased_name.unit) {                                                         \
        case YGUnitPoint:                                                                   \
            YGNodeStyleSet##capitalized_name(self.yogaNode, lowercased_name.value);         \
            break;                                                                          \
        case YGUnitPercent:                                                                 \
            YGNodeStyleSet##capitalized_name##Percent(self.yogaNode, lowercased_name.value);\
            break;                                                                          \
        case YGUnitAuto:                                                                    \
            YGNodeStyleSet##capitalized_name##Auto(self.yogaNode);                          \
            break;                                                                          \
        default:                                                                            \
            NSAssert(NO, @"Not implemented");                                               \
    }                                                                                       \
}

YGValue YGPointValue(CGFloat value)
{
    return (YGValue) { .value = (float) value, .unit = (YGUnit) YGUnitPoint };
}

@implementation YogaStyle{
    YGNodeRef _yogaNode;
}

+ (void)initialize {
    [super initialize];
    globalConfig = YGConfigNew();
    YGConfigSetExperimentalFeatureEnabled(globalConfig, YGExperimentalFeatureWebFlexBasis, true);
    YGConfigSetPointScaleFactor(YGConfigGetDefault(), LWScreenScale());
}

- (instancetype)initWithLayoutElement:(id<LWLayoutable>)layoutElem {
    self = [super init];
    if (self) {
        _yogaNode = YGNodeNewWithConfig(globalConfig);
        YGNodeSetContext(_yogaNode, (__bridge void *) layoutElem);
    }
    return self;
}

- (YGNodeRef)yogaNode {
    return _yogaNode;
}

- (void)setFlexDirection:(LWFBDirection)flexDirection {
    _flexDirection = flexDirection;
    YGNodeStyleSetFlexDirection(self.yogaNode, yogaFlexDirection(flexDirection));
}

- (void)setFlexWrap:(LWFBWrap)flexWrap {
    _flexWrap = flexWrap;
    YGNodeStyleSetFlexWrap(self.yogaNode, yogaWrap(flexWrap));
}

- (void)setJustifyContent:(LWFBJustifyContent)justifyContent {
    _justifyContent = justifyContent;
    YGNodeStyleSetJustifyContent(self.yogaNode, yogaJustifyContent(justifyContent));
}

- (void)setAlignItems:(LWFBAlignItem)alignItems {
    _alignItems = alignItems;
    YGNodeStyleSetAlignItems(self.yogaNode, yogaAlignItems(alignItems));
}

- (void)setAlignContent:(LWFBAlignContent)alignContent {
    _alignContent = alignContent;
    YGNodeStyleSetAlignContent(self.yogaNode, yogaAlignContent(alignContent));
}

- (void)setAlignSelf:(LWFBAlignSelf)alignSelf {
    _alignSelf = alignSelf;
    YGNodeStyleSetAlignSelf(self.yogaNode, yogaAlignSelf(alignSelf));
}

- (void)setFlexGrow:(CGFloat)flexGrow {
    _flexGrow = flexGrow;
    YGNodeStyleSetFlexGrow(self.yogaNode, flexGrow);
}

- (void)setFlexShrink:(CGFloat)flexShrink {
    _flexShrink = flexShrink;
    YGNodeStyleSetFlexShrink(self.yogaNode, flexShrink);
}

- (void)setFlexBasis:(CGFloat)flexBasis {
    _flexBasis = flexBasis;
    YGNodeStyleSetFlexBasis(self.yogaNode, flexBasis);
}

YG_VALUE_EDGE_PROPERTY(left, Left, Position, YGEdgeLeft)
YG_VALUE_EDGE_PROPERTY(top, Top, Position, YGEdgeTop)
YG_VALUE_EDGE_PROPERTY(right, Right, Position, YGEdgeRight)
YG_VALUE_EDGE_PROPERTY(bottom, Bottom, Position, YGEdgeBottom)
YG_VALUE_EDGE_PROPERTY(start, Start, Position, YGEdgeStart)
YG_VALUE_EDGE_PROPERTY(end, End, Position, YGEdgeEnd)
YG_VALUE_EDGES_PROPERTIES(margin, Margin)
YG_VALUE_EDGES_PROPERTIES(padding, Padding)

YG_EDGE_PROPERTY(borderLeftWidth, BorderLeftWidth, Border, YGEdgeLeft)
YG_EDGE_PROPERTY(borderTopWidth, BorderTopWidth, Border, YGEdgeTop)
YG_EDGE_PROPERTY(borderRightWidth, BorderRightWidth, Border, YGEdgeRight)
YG_EDGE_PROPERTY(borderBottomWidth, BorderBottomWidth, Border, YGEdgeBottom)
YG_EDGE_PROPERTY(borderStartWidth, BorderStartWidth, Border, YGEdgeStart)
YG_EDGE_PROPERTY(borderEndWidth, BorderEndWidth, Border, YGEdgeEnd)
YG_EDGE_PROPERTY(borderWidth, BorderWidth, Border, YGEdgeAll)

YG_AUTO_VALUE_PROPERTY(width, Width)
YG_AUTO_VALUE_PROPERTY(height, Height)
YG_VALUE_PROPERTY(minWidth, MinWidth)
YG_VALUE_PROPERTY(minHeight, MinHeight)
YG_VALUE_PROPERTY(maxWidth, MaxWidth)
YG_VALUE_PROPERTY(maxHeight, MaxHeight)

- (void)dealloc {
    YGNodeFree(_yogaNode);
}

@end
