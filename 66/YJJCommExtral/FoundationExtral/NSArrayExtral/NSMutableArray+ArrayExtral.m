//
//  NSMutableArray+ArrayExtral.m
//  YJJCommExtral
//
//  Created by Yasin-iOSer on 15/7/30.
//  Copyright (c) 2015年 Yasin-iOSer. All rights reserved.
//

#import "NSMutableArray+ArrayExtral.h"

#import <objc/runtime.h>

@implementation NSMutableArray (ArrayExtral)

/// obj是否有效
- (BOOL)isVaildOfObject:(id)obj{
    return obj && [obj isKindOfClass:[NSObject class]];
}

/// 安全添加
- (void)safeAppendObject:(id)obj{
    /// 非空并且是对象
    if([self isVaildOfObject:obj]){
        [self addObject:obj];
    }
}

- (void)safeInsertObject:(id)obj atIndex:(NSUInteger)index{
    if(index > [self count]){
        return;
    }
    /// 非空并且是对象
    if([self isVaildOfObject:obj]){
        [self insertObject:obj atIndex:index];
    }
}

- (void)safeRemoveLastObject{
    if([self count]){
        [self removeLastObject];
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index{
    if(index >= [self count]){
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if(index >= [self count]){
        return;
    }
    if([self isVaildOfObject:anObject]){
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}

@end
