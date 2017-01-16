//
//  GCDHelper.h
//  
//
//  Created by YiJianjun on 14-2-17.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 得地default global queue
dispatch_queue_t dispatch_get_default_global_queue();

@interface GCDHelper : NSObject

/*
 #define DISPATCH_QUEUE_PRIORITY_HIGH 2
 #define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
 #define DISPATCH_QUEUE_PRIORITY_LOW (-2)
 #define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
 
 typedef long dispatch_queue_priority_t;
 */

/// 得到queue
+ (dispatch_queue_t)getDefaultGlobalQueue;
+ (dispatch_queue_t)getMainQueue;
+ (dispatch_queue_t)getGlobalQueueWithPriority:(dispatch_queue_priority_t)priority;

+ (void)gcdAsyncRunInGlobalQueueWithBlock:(void(^)(void))block;
+ (void)gcdSyncRunInGlobalQueueWithBlock:(void(^)(void))block;
+ (void)gcdAsyncRunInMainQueueWithBlock:(void(^)(void))block;
+ (void)gcdSyncRunInMainQueueWithBlock:(void(^)(void))block;

+ (void)gcdAfterInMainQueueWithDuration:(NSTimeInterval)delayInSeconds block:(void (^)())block;
+ (void)gcdAfterInGlobalQueueWithDuration:(NSTimeInterval)delayInSeconds block:(void (^)())block;

+ (nullable dispatch_queue_t)gcdAsyncRunInCustomQueueWithName:(NSString *)queueName block:(void(^)(void))block;
+ (nullable dispatch_queue_t)gcdSyncRunInCustomQueueWithName:(NSString *)queueName block:(void(^)(void))block;


+ (void)gcdSyncLockWithObject:(id)lockedObject block:(void (^)(void))block;

@end

NS_ASSUME_NONNULL_END
