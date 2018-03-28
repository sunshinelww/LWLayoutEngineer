//
//  LWAssert.h
//  LWLayoutEngineer
//
//  Created by sunshinelww on 2018/3/28.
//

#import <pthread.h>

#define LWLayoutEngineerAssert(condition, desc, ...) NSAssert(condition,desc, ##__VA_ARGS__)
#define LWLayoutEngineerCAssert(condition, desc, ...) NSCAssert(condition,desc, ##__VA_ARGS__)

#define LWLayoutEngineerAssertNil(condition, desc, ...) LWLayoutEngineerAssert((condition) == nil, desc, ##__VA_ARGS__)
#define LWLayoutEngineerCAssertNil(condition, desc, ...) LWLayoutEngineerCAssert((condition) == nil, desc, ##__VA_ARGS__)

#define LWLayoutEngineerAssertNotNil(condition, desc, ...) LWLayoutEngineerAssert((condition) != nil, desc, ##__VA_ARGS__)
#define LWLayoutEngineerCAssertNotNil(condition, desc, ...) LWLayoutEngineerCAssert((condition) != nil, desc, ##__VA_ARGS__)

#define LWLayoutEngineerAssertMainThread() LWLayoutEngineerAssert(0 != pthread_main_np, @"Method %s must be called on the main thread", __func__)
#define LWLayoutEngineerCAssertMainThread() LWLayoutEngineerCAssert(0 != pthread_main_np, @"Method %s must be called on the main thread", __func__)

#define LWLayoutEngineerAssertNotMainThread() LWLayoutEngineerAssert(0 == pthread_main_np, @"Method %s must not be called on the main thread", __func__)
#define LWLayoutEngineerCAssertNotMainThread() LWLayoutEngineerCAssert(0 == pthread_main_np, @"Method %s must not be called on the main thread", __func__)



