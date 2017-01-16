//
//  NSObject+WeakSelf.m
//  BPC_ECRCOC
//
//  Created by YiJianjun on 14/12/1.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import "NSObject+WeakSelf.h"

@implementation NSObject (WeakSelf)

- (instancetype)weakSelf{
    __weak __typeof(self) wSelf = self;
    return wSelf;
}
@end
