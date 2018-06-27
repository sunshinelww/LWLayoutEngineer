//
//  YogaStyle.h
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#import <Foundation/Foundation.h>
#import "Yoga.h"

typedef NS_ENUM(NSUInteger, LWFBDirection){
    LWFBDirectionColumn,
    LWFBDirectionColumnReverse,
    LWFBDirectionRow,
    LWFBDirectionRowReverse
};

typedef NS_ENUM(NSUInteger, LWFBJustifyContent){
    LWFBJustifyContentStart,
    LWFBJustifyContentCenter,
    LWFBJustifyContentEnd,
    LWFBJustifyContentSpaceBetween,
    LWFBJustifyContentSpaceAround,
    LWFBJustifyContentSpaceEvenly,
};

typedef NS_ENUM(NSUInteger, LWFBAlignItem) {
    LWFBAlignItemStart = 1,
    LWFBAlignItemCenter,
    LWFBAlignItemEnd,
    LWFBAlignItemStretch, //Default value. Lines stretch to take up the remaining space
    LWFBAlignItemBaseline //向第一个Item的baseline对齐，适用于textLabel
};

/**
 * 多轴线纵向对齐
 **/
typedef NS_ENUM(NSUInteger, LWFBAlignContent) {
    LWFBAlignContentStart,
    LWFBAlignContentEnd,
    LWFBAlignContentCenter,
    LWFBAlignContentSpaceBetween,
    LWFBAlignContentSpaceAround
};

typedef NS_ENUM(NSUInteger, LWFBAlignSelf) {
    LWFBAlignSelfAuto, //Default value.The element inherits its parent container's align-items property, or "stretch" if it has no parent container
    LWFBAlignSelfStretch,
    LWFBAlignSelfStart,
    LWFBAlignSelfEnd,
    LWFBAlignSelfCenter,
    LWFBAlignSelfBaseline
};

typedef NS_ENUM(NSUInteger, LWFBWrap) {
    LWFBWrapNoWrap,
    LWFBWrapWrap,
    LWFBWrapWrapReverse
};

typedef NS_ENUM(NSUInteger, LWFBPositionType) {
    LWFBPositionTypeRelative,
    LWFBPositionTypeAbsolute
};

extern YGValue YGPointValue(CGFloat value);

@protocol LWLayoutable;

@interface YogaStyle : NSObject

@property (nonatomic, assign, readonly) YGNodeRef yogaNode;

#pragma mark Flex Container

@property (nonatomic, assign) LWFBDirection flexDirection;

@property (nonatomic, assign) LWFBPositionType positionType;

@property (nonatomic, assign) LWFBWrap flexWrap;

@property (nonatomic, assign) LWFBJustifyContent justifyContent;

@property (nonatomic, assign) LWFBAlignItem alignItems;

@property (nonatomic, assign) LWFBAlignContent alignContent;

#pragma mark Flex Item

@property (nonatomic, assign) LWFBAlignSelf alignSelf;

@property (nonatomic, assign) CGFloat flexGrow;

@property (nonatomic, assign) CGFloat flexShrink;

@property (nonatomic, assign) CGFloat flexBasis;

#pragma mark YGValue

@property (nonatomic, readwrite, assign) YGValue left;
@property (nonatomic, readwrite, assign) YGValue top;
@property (nonatomic, readwrite, assign) YGValue right;
@property (nonatomic, readwrite, assign) YGValue bottom;
@property (nonatomic, readwrite, assign) YGValue start;
@property (nonatomic, readwrite, assign) YGValue end;

@property (nonatomic, readwrite, assign) YGValue marginLeft;
@property (nonatomic, readwrite, assign) YGValue marginTop;
@property (nonatomic, readwrite, assign) YGValue marginRight;
@property (nonatomic, readwrite, assign) YGValue marginBottom;
@property (nonatomic, readwrite, assign) YGValue marginStart;
@property (nonatomic, readwrite, assign) YGValue marginEnd;
@property (nonatomic, readwrite, assign) YGValue marginHorizontal;
@property (nonatomic, readwrite, assign) YGValue marginVertical;
@property (nonatomic, readwrite, assign) YGValue margin;

@property (nonatomic, readwrite, assign) YGValue paddingLeft;
@property (nonatomic, readwrite, assign) YGValue paddingTop;
@property (nonatomic, readwrite, assign) YGValue paddingRight;
@property (nonatomic, readwrite, assign) YGValue paddingBottom;
@property (nonatomic, readwrite, assign) YGValue paddingStart;
@property (nonatomic, readwrite, assign) YGValue paddingEnd;
@property (nonatomic, readwrite, assign) YGValue paddingHorizontal;
@property (nonatomic, readwrite, assign) YGValue paddingVertical;
@property (nonatomic, readwrite, assign) YGValue padding;

@property (nonatomic, readwrite, assign) CGFloat borderLeftWidth;
@property (nonatomic, readwrite, assign) CGFloat borderTopWidth;
@property (nonatomic, readwrite, assign) CGFloat borderRightWidth;
@property (nonatomic, readwrite, assign) CGFloat borderBottomWidth;
@property (nonatomic, readwrite, assign) CGFloat borderStartWidth;
@property (nonatomic, readwrite, assign) CGFloat borderEndWidth;
@property (nonatomic, readwrite, assign) CGFloat borderWidth;

@property (nonatomic, readwrite, assign) YGValue width;
@property (nonatomic, readwrite, assign) YGValue height;
@property (nonatomic, readwrite, assign) YGValue minWidth;
@property (nonatomic, readwrite, assign) YGValue minHeight;
@property (nonatomic, readwrite, assign) YGValue maxWidth;
@property (nonatomic, readwrite, assign) YGValue maxHeight;

- (instancetype)initWithLayoutElement:(id<LWLayoutable>)layoutElem NS_DESIGNATED_INITIALIZER;

@end
