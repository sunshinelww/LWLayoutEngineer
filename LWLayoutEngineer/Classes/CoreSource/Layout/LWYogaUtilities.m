//
//  LWYogaUtilities.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#import "LWYogaUtilities.h"

YGFlexDirection yogaFlexDirection(LWFBDirection flexDirection){
    switch (flexDirection) {
        case LWFBDirectionRow:            return YGFlexDirectionRow;
        case LWFBDirectionRowReverse:     return YGFlexDirectionRowReverse;
        case LWFBDirectionColumn:         return YGFlexDirectionColumn;
        case LWFBDirectionColumnReverse:  return YGFlexDirectionColumnReverse;
    }
}

YGJustify yogaJustifyContent(LWFBJustifyContent justifyContent){
    switch (justifyContent) {
        case LWFBJustifyContentStart:          return YGJustifyFlexStart;
        case LWFBJustifyContentCenter:         return YGJustifyCenter;
        case LWFBJustifyContentEnd:            return YGJustifyFlexEnd;
        case LWFBJustifyContentSpaceBetween:   return YGJustifySpaceBetween;
        case LWFBJustifyContentSpaceAround:    return YGJustifySpaceAround;
        case LWFBJustifyContentSpaceEvenly:    return YGJustifySpaceEvenly;
    }
}

YGAlign yogaAlignItems(LWFBAlignItem aligItems){
    switch (aligItems) {
        case LWFBAlignItemStart:    return YGAlignFlexStart;
        case LWFBAlignItemEnd:      return YGAlignFlexEnd;
        case LWFBAlignItemCenter:   return YGAlignCenter;
        case LWFBAlignItemBaseline: return YGAlignBaseline;
        case LWFBAlignItemStretch:  return YGAlignStretch;
    }
}

YGAlign yogaAlignContent(LWFBAlignContent alignContent){
    switch (alignContent) {
        case LWFBAlignContentStart:           return YGAlignFlexStart;
        case LWFBAlignContentCenter:          return YGAlignCenter;
        case LWFBAlignContentEnd:             return YGAlignFlexEnd;
        case LWFBAlignContentSpaceBetween:    return YGAlignSpaceBetween;
        case LWFBAlignContentSpaceAround:     return YGAlignSpaceAround;
    }
}

YGAlign yogaAlignSelf(LWFBAlignSelf alignSelf){
    switch (alignSelf) {
        case LWFBAlignSelfAuto:       return YGAlignAuto;
        case LWFBAlignSelfStretch:    return YGAlignStretch;
        case LWFBAlignSelfStart:      return YGAlignFlexStart;
        case LWFBAlignSelfCenter:     return YGAlignCenter;
        case LWFBAlignSelfEnd:        return YGAlignFlexEnd;
        case LWFBAlignSelfBaseline:   return YGAlignBaseline;
    }
}

YGWrap yogaWrap(LWFBWrap wrap){
    switch (wrap) {
        case LWFBWrapWrap:          return YGWrapWrap;
        case LWFBWrapNoWrap:        return YGWrapNoWrap;
        case LWFBWrapWrapReverse:   return YGWrapWrapReverse;
    }
}

void YGRemoveAllChildren(const YGNodeRef node)
{
    if (node == NULL) {
        return;
    }
    
    while (YGNodeGetChildCount(node) > 0) {
        YGNodeRemoveChild(node, YGNodeGetChild(node, YGNodeGetChildCount(node) - 1));
    }
}

