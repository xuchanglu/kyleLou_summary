//
//  NSObject+WeakSelf.h
//  BPC_ECRCOC
//
//  Created by YiJianjun on 14/12/1.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (WeakSelf)
- (instancetype)weakSelf;
@end

NS_ASSUME_NONNULL_END
