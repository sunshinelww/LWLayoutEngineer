//
//  LWLayoutSepc.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/27.
//

#import "LWLayoutSepc.h"
#import "LWAssert.h"

@interface LWLayoutSepc(){
    LWLayoutStyle  *_layoutStyle;
    NSMutableArray *_childrenArray;
}

@end

@implementation LWLayoutSepc

@dynamic children;
@dynamic child;

- (instancetype)init{
    self = [super init];
    if (self) {
        _childrenArray = [NSMutableArray array];
    }
    return self;
}

- (LWLayoutElementType)layoutElementType{
    return LWLayoutElementTypeSpec;
}

- (LWLayoutStyle *)layoutStyle{
    if (!_layoutStyle) {
        _layoutStyle = [[LWLayoutStyle alloc] init];
    }
    return _layoutStyle;
}

- (LWLayout *)layoutThatFits:(CGSize)constrainedSize{
    return [LWLayout layoutWithLayoutElement:self size:CGSizeZero];
}


- (void)setChild:(id<LWLayoutable>)child{
    if (child) {
        _childrenArray[0] = child;
    }
    else{
        if (_childrenArray.count) {
            [_childrenArray removeObjectAtIndex:0];
        }
    }
}

- (void)setChildren:(NSArray<id<LWLayoutable>> *)children{
    [_childrenArray removeAllObjects];
    
    NSUInteger i =0 ;
    for (id<LWLayoutable> child in children) {
        LWLayoutEngineerAssert([child conformsToProtocol:@protocol(LWLayoutable)], @"Child %@ of Spec %@ should conform to LWLayoutable!", child, self);
        _childrenArray[i] = child;
        i++;
    }
}

- (nullable NSArray<id<LWLayoutable>>*)children{
    return [_childrenArray copy];
}

- (nonnull NSArray<id<LWLayoutable>> *)sublayoutElements {
    return [_childrenArray copy];
}

@end
