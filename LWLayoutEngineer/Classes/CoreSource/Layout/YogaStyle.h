//
//  YogaStyle.h
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#import <Foundation/Foundation.h>
#import "Yoga.h"

typedef NS_ENUM(NSUInteger, LWFBDirection){
    LWFBDirectionRow,
    LWFBDirectionRowReverse,
    LWFBDirectionColumn,
    LWFBDirectionColumnReverse
};

typedef NS_ENUM(NSUInteger, LWFBJustifyContent){
    LWFBJustifyContentStart,
    LWFBJustifyContentEnd,
    LWFBJustifyContentCenter,
    LWFBJustifyContentSpaceBetween,
    LWFBJustifyContentSpaceAround
};

typedef NS_ENUM(NSUInteger, LWFBAlignItem) {
    LWFBAlignItemStretch, //Default value. Lines stretch to take up the remaining space
    LWFBAlignItemStart,
    LWFBAlignItemEnd,
    LWFBAlignItemCenter,
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
    NoWrap,
    Wrap,
    WrapReverse
};

typedef NS_ENUM(NSUInteger, LWFBPositionType) {
    LWFBPositionTypeRelative,
    LWFBPositionTypeAbsolute
};




@interface YogaStyle : NSObject

@property (nonatomic, assign, readonly) YGNodeRef yogaNode;

#pragma mark Flex Container

@property (nonatomic, assign) LWFBDirection flexDirection;

@property (nonatomic, assign) LWFBPositionType position;

@property (nonatomic, assign) LWFBWrap flexWrap;

@property (nonatomic, assign) LWFBJustifyContent justifyContent;

@property (nonatomic, assign) LWFBAlignItem alignItems;

@property (nonatomic, assign) LWFBAlignContent alignContent;

#pragma mark Flex Item

@property (nonatomic, assign) LWFBAlignSelf alignSelf;

@property (nonatomic, assign) CGFloat flexGrow;

@property (nonatomic, assign) CGFloat flexShrink;

@property (nonatomic, assign) CGFloat flexBasis;

@end
