//
//  GCDHelper.m
//  
//
//  Created by YiJianjun on 14-2-17.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "GCDHelper.h"

/// 得地default global queue
dispatch_queue_t dispatch_get_default_global_queue(){
    return [GCDHelper getDefaultGlobalQueue];
}

@implementation GCDHelper
/// 得到queue
+ (dispatch_queue_t)getGlobalQueueWithPriority:(dispatch_queue_priority_t)priority{
    return dispatch_get_global_queue(priority, 0);
}

+ (dispatch_queue_t)getDefaultGlobalQueue{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

+ (dispatch_queue_t)getMainQueue{
    return dispatch_get_main_queue();
}

+ (void)gcdAsyncRunInGlobalQueueWithBlock:(void(^)(void))block{
    if(!block){
        return;
    }
    dispatch_async([self getDefaultGlobalQueue], block);
}

+ (void)gcdSyncRunInGlobalQueueWithBlock:(void(^)(void))block{
    if(!block){
        return;
    }
    dispatch_sync([self getDefaultGlobalQueue], block);
}

+ (void)gcdAsyncRunInMainQueueWithBlock:(void(^)(void))block{
    if(!block){
        return;
    }
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (void)gcdSyncRunInMainQueueWithBlock:(void(^)(void))block{
    if(!block){
        return;
    }
    dispatch_sync(dispatch_get_main_queue(), block);
}

+ (void)gcdAfterInMainQueueWithDuration:(NSTimeInterval)delayInSeconds block:(void (^)())block{
    if(!block){
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

+ (void)gcdAfterInGlobalQueueWithDuration:(NSTimeInterval)delayInSeconds block:(void (^)())block{
    if(!block){
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), [self getDefaultGlobalQueue], block);
}

+ (dispatch_queue_t)gcdAsyncRunInCustomQueueWithName:(NSString *)queueName block:(void(^)(void))block{
    if(!queueName || !queueName.length || !block){
        return nil;
    }
    
    dispatch_queue_t customQueue = dispatch_queue_create([queueName cStringUsingEncoding:NSUTF8StringEncoding], nil);
    dispatch_async(customQueue, block);
    return customQueue;
}

+ (dispatch_queue_t)gcdSyncRunInCustomQueueWithName:(NSString *)queueName block:(void(^)(void))block{
    if(!queueName || !queueName.length || !block){
        return nil;
    }
    
    dispatch_queue_t customQueue = dispatch_queue_create([queueName cStringUsingEncoding:NSUTF8StringEncoding], nil);
    dispatch_sync(customQueue, block);
    return customQueue;
}

+ (void)gcdSyncLockWithObject:(id)lockedObject block:(void (^)(void))block{
    if(!lockedObject || !block){
        return;
    }
    @synchronized(lockedObject){
        block();
    }
}
@end
