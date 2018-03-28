//
//  LWLayout.h
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/27.
//

#import <Foundation/Foundation.h>
#import "LWLayoutStyle.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN CGPoint const LWPointNull;

/*!
 *  @brief Whether or not point is LWPointNull
 *
 */
FOUNDATION_EXTERN BOOL LWPointIsNull(CGPoint point);

/**
 * 代表一个 layoutable 的布局结果
 **/
@interface LWLayout : NSObject

/**
 * The underlying object described by this layout
 **/
@property (nonatomic, weak, readonly) id<LWLayoutable> layoutElement;

@property (nonatomic, assign, readonly) LWLayoutElementType layoutElementType;

@property (nonatomic, assign, readonly) CGSize size;

/**
 * return a valid frame for current layout
 **/
@property (nonatomic, assign, readonly) CGRect frame;

/**
 *  Position in parent. Default to LWPointNull
 **/
@property (nonatomic, assign, readonly) CGPoint position;

@property (nonatomic, copy, readonly) NSArray<LWLayout *> *subLayouts;

- (instancetype)initWithLayoutElement:(id<LWLayoutable>)layoutElement
                                 size:(CGSize)size
                             position:(CGPoint)position
                       sublayoutElems:(nullable NSArray<LWLayout *> *)sublayouts NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)layoutWithLayoutElement:(id<LWLayoutable>)layoutElement
                                 size:(CGSize)size
                             position:(CGPoint)position
                       sublayoutElems:(nullable NSArray<LWLayout *> *)sublayouts;

+ (instancetype)layoutWithLayoutElement:(id<LWLayoutable>)layoutElement
                                 size:(CGSize)size
                       sublayoutElems:(nullable NSArray<LWLayout *> *)sublayouts;

+ (instancetype)layoutWithLayoutElement:(id<LWLayoutable>)layoutElement
                                 size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
