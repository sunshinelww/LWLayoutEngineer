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

@implementation LWLayout

@end
