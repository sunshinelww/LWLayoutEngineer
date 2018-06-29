//
//  LWLayoutUtilities.h
//  LWLayoutEngineer
//
//  Created by liweiwei.sunshine on 2018/6/27.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <functional>


inline CGPoint operator+(const CGPoint &p1, const CGPoint &p2) {
    return { p1.x + p2.x, p1.y + p2.y };
}

inline CGPoint operator-(const CGPoint &p1, const CGPoint &p2) {
    return { p1.x - p2.x, p1.y - p2.y };
}

