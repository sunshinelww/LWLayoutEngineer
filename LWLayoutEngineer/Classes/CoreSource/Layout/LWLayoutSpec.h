//
//  LWLayoutSepc.h
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/27.
//

#import <Foundation/Foundation.h>
#import "LWLayout.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 布局的规范抽象类，用来辅助view的布局
 **/
@interface LWLayoutSpec : NSObject <LWLayoutable>

/**
 * 代表第一个子元素
 **/
@property (nonatomic, strong)id<LWLayoutable> child;

/**
 * 代表所有的子元素
 **/
@property (nullable, nonatomic, strong)NSArray<id<LWLayoutable>> *children;


- (LWLayout *)layoutThatFits:(CGSize)constrainedSize;

@end

NS_ASSUME_NONNULL_END
