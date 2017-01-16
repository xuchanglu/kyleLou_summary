//
//  NSDictionary+DictExtral.h
//  BPC-4S-W
//
//  Created by YiJianJun on 14-8-13.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (DictExtral)
/// 根据key
- (nullable id)safeObjectForKey:(id)aKey;
@end


@interface NSDictionary (RequestEncoding)
-(nullable NSString *) urlEncodedKeyValueString;
-(nullable NSString *) jsonEncodedKeyValueString;
-(nullable NSString *) plistEncodedKeyValueString;
@end

NS_ASSUME_NONNULL_END
