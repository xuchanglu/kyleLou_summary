//
//  NSMutableArray+ArrayExtral.h
//  YJJCommExtral
//
//  Created by Yasin-iOSer on 15/7/30.
//  Copyright (c) 2015年 Yasin-iOSer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (ArrayExtral)

/// 安全添加
- (void)safeAppendObject:(id)obj;

- (void)safeInsertObject:(id)obj atIndex:(NSUInteger)index;

- (void)safeRemoveLastObject;
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;
- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end

NS_ASSUME_NONNULL_END
