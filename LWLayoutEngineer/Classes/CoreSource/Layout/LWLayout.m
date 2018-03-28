//
//  LWLayout.m
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/27.
//

#import "LWLayout.h"

CGPoint const LWPointNull = {NAN,NAN};

FOUNDATION_EXTERN BOOL LWPointIsNull(CGPoint point){
    return isnan(point.x) && isnan(point.y);
}

@interface LWLayout(){
    LWLayoutElementType _layoutElementType;
}

@end

@implementation LWLayout

- (instancetype)initWithLayoutElement:(id<LWLayoutable>)layoutElement
                                 size:(CGSize)size
                             position:(CGPoint)position
                       sublayoutElems:(NSArray<LWLayout *> *)sublayouts{
    self = [super init];
    if (self) {
        _layoutElement = layoutElement;
        //避免weak性能损失
        _layoutElementType = layoutElement.layoutElementType;
        _size = size;
        _position = position;
        
        _subLayouts = sublayouts != nil? [sublayouts copy] : @[];
    }
    return self;
}


+ (instancetype)layoutWithLayoutElement:(id<LWLayoutable>)layoutElement
                                   size:(CGSize)size
                               position:(CGPoint)position
                         sublayoutElems:(NSArray<LWLayout *> *)sublayouts{
    return [[self alloc] initWithLayoutElement:layoutElement size:size position:position sublayoutElems:sublayouts];
}

+ (instancetype)layoutWithLayoutElement:(id<LWLayoutable>)layoutElement
                                   size:(CGSize)size
                         sublayoutElems:(NSArray<LWLayout *> *)sublayouts{
    return [self layoutWithLayoutElement:layoutElement size:size position:LWPointNull sublayoutElems:sublayouts];
}

+ (instancetype)layoutWithLayoutElement:(id<LWLayoutable>)layoutElement size:(CGSize)size{
    return [self layoutWithLayoutElement:layoutElement size:size position:LWPointNull sublayoutElems:nil];
}

- (LWLayoutElementType)layoutElementType{
    return _layoutElementType;
}

@end
