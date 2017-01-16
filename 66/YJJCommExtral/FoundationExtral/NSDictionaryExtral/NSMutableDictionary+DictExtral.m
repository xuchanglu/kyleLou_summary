//
//  NSMutableDictionary+DictExtral.m
//  YJJCommExtral
//
//  Created by Yasin-iOSer on 15/7/30.
//  Copyright (c) 2015年 Yasin-iOSer. All rights reserved.
//

#import "NSMutableDictionary+DictExtral.h"

@implementation NSMutableDictionary (DictExtral)
- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if(aKey && anObject){
        [self setObject:anObject forKey:aKey];
    }
}

/// 解决null问题
- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key{
    [self safeSetObject:obj forKey:key];
}

@end
