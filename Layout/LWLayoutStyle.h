//
//  LWLayoutStyle.h
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/27.
//

#import <Foundation/Foundation.h>
@class LWLayoutStyle;
@class LWLayout;

NS_ASSUME_NONNULL_BEGIN

/**
 Type of LWLayoutElement
 **/
typedef NS_ENUM(NSUInteger, LWLayoutElementType) {
    LWLayoutElementTypeSpec,  //布局规范
    LWLayoutElementTypeView  // view
};



/**
 * 定义元素的布局能力
 **/
@protocol LWLayoutable

@property (nonatomic, assign, readonly) LWLayoutElementType *layoutElementType;

@property (nonatomic, strong, readonly) LWLayoutStyle *layoutStyle;

- (NSArray<id<LWLayoutable>> *)sublayoutElements;

/*!
 *  @brief 布局核心函数
 *
 *  @param  constrainedSize 约束的大小
 *
 *  @return 布局的结果
 */
- (LWLayout *)layoutThatFits:(CGSize)constrainedSize;


@end

@interface LWLayoutStyle : NSObject

@end

NS_ASSUME_NONNULL_END
