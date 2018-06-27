//
//  UIView+LWLayoutable.h
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/27.
//

#import <UIKit/UIKit.h>
#import "LWLayoutStyle.h"
#import "LWLayoutSpec.h"


NS_ASSUME_NONNULL_BEGIN

typedef LWLayoutSpec *(^LWLayoutSpecBlock)(CGSize constrainedSize);

@interface UIView (LWLayoutable) <LWLayoutable>

@property (nonatomic, copy)LWLayoutSpecBlock layoutSpecBlock;

- (LWLayoutSpec *)layoutSpecThatFits:(CGSize)constrainedSize;

- (LWLayout *)layoutThatFits:(CGSize)constrainedSize;

@end

NS_ASSUME_NONNULL_END
