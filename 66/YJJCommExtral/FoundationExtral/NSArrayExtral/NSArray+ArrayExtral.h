//
//  NSArray+ArrayExtral.h
//  YJJCommExtral
//
//  Created by Yasin-iOSer on 15/7/30.
//  Copyright (c) 2015年 Yasin-iOSer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ArrayExtral)

/// 安全获取
- (nullable id)safeObjectAtIndex:(NSUInteger)index;
/// 修改原来的以便安全获取
- (nullable id)objectAtIndexedSubscript:(NSUInteger)idx;

- (nullable id)safeFirstObject;

@end

NS_ASSUME_NONNULL_END
