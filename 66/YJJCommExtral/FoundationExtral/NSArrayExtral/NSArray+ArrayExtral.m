//
//  NSArray+ArrayExtral.m
//  YJJCommExtral
//
//  Created by Yasin-iOSer on 15/7/30.
//  Copyright (c) 2015年 Yasin-iOSer. All rights reserved.
//

#import "NSArray+ArrayExtral.h"

@implementation NSArray (ArrayExtral)
- (id)safeObjectAtIndex:(NSUInteger)index{
    if(index < [self count]){
        return [self objectAtIndex:index];
    }
    
    return nil;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx{
    return [self safeObjectAtIndex:idx];
}

- (id)safeFirstObject{
    return [self safeObjectAtIndex:0];
}


@end
