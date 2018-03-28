//
//  YogaStyle.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#import "YogaStyle.h"
#import "LWInternalHelper.h"

#define YG_PROPERTY(type, lowercased_name, capitalized_name)    \
- (type)lowercased_name                                         \
{                                                               \
return (type)YGNodeStyleGet##capitalized_name(self.yogaNode);           \
}                                                               \
\
- (void)set##capitalized_name:(type)lowercased_name             \
{                                                               \
YGNodeStyleSet##capitalized_name(self.yogaNode, lowercased_name); \
}


static YGConfigRef globalConfig;

@implementation YogaStyle{
    YGNodeRef _yogaNode;
}

@dynamic flexDirection,positionType,flexWrap,justifyContent,alignItem,alignContent,alignSelf;
@dynamic flexGrow,flexShrink,flexBasis;

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

YG_PROPERTY(LWFBDirection, direction, Direction);

- (void)dealloc{
    YGNodeFree(_yogaNode);
}

@end
