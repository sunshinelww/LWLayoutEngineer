//
//  UIView+LWLayoutable.h
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/27.
//

#import <UIKit/UIKit.h>
#import "LWLayoutStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LWLayoutable) <LWLayoutable>


- (LWLayout *)layoutThatFits:(CGSize)constrainedSize;

@end

NS_ASSUME_NONNULL_END
