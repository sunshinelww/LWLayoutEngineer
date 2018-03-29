//
//  YogaStyle.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#import "YogaStyle.h"
#import "LWInternalHelper.h"
#import "LWYogaUtilities.h"

static YGConfigRef globalConfig;

@implementation YogaStyle{
    YGNodeRef _yogaNode;
    
}

+ (void)initialize{
    [super initialize];
    globalConfig = YGConfigNew();
    YGConfigSetExperimentalFeatureEnabled(globalConfig, YGExperimentalFeatureWebFlexBasis, true);
    YGConfigSetPointScaleFactor(YGConfigGetDefault(), LWScreenScale());
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _yogaNode = YGNodeNewWithConfig(globalConfig);
    }
    return self;
}

- (YGNodeRef)yogaNode{
    return _yogaNode;
}

- (void)setFlexDirection:(LWFBDirection)flexDirection{
    _flexDirection = flexDirection;
    YGNodeStyleSetFlexDirection(self.yogaNode, yogaFlexDirection(flexDirection));
}

- (void)setFlexWrap:(LWFBWrap)flexWrap{
    _flexWrap = flexWrap;
    YGNodeStyleSetFlexWrap(self.yogaNode, yogaWrap(flexWrap));
}

- (void)setJustifyContent:(LWFBJustifyContent)justifyContent{
    _justifyContent = justifyContent;
    YGNodeStyleSetJustifyContent(self.yogaNode, yogaJustifyContent(justifyContent));
}

- (void)setAlignItems:(LWFBAlignItem)alignItems{
    _alignItems = alignItems;
    YGNodeStyleSetAlignItems(self.yogaNode, yogaAlignItems(alignItems));
}

- (void)setAlignContent:(LWFBAlignContent)alignContent{
    _alignContent = alignContent;
    YGNodeStyleSetAlignContent(self.yogaNode, yogaAlignContent(alignContent));
}

- (void)setAlignSelf:(LWFBAlignSelf)alignSelf{
    _alignSelf = alignSelf;
    YGNodeStyleSetAlignSelf(self.yogaNode, yogaAlignSelf(alignSelf));
}

- (void)setFlexGrow:(CGFloat)flexGrow{
    _flexGrow = flexGrow;
    YGNodeStyleSetFlexGrow(self.yogaNode, flexGrow);
}

- (void)setFlexShrink:(CGFloat)flexShrink{
    _flexShrink = flexShrink;
    YGNodeStyleSetFlexShrink(self.yogaNode, flexShrink);
}

- (void)setFlexBasis:(CGFloat)flexBasis{
    _flexBasis = flexBasis;
    YGNodeStyleSetFlexBasis(self.yogaNode, flexBasis);
}


- (void)dealloc{
    YGNodeFree(_yogaNode);
}

@end
