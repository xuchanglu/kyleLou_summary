//
//  NSString+NSStringExtras.h
//
//  Created by YiJianJun on 13-10-5.
//  Copyright (c) 2013年 YiJianJun. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CommonDigest)
- (NSString *)md2;
- (NSString *)md4;
- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha224;
- (NSString *)sha256;
- (NSString *)sha384;
- (NSString *)sha512;
@end

@interface NSString (CommonCryptor)

@end

NS_ASSUME_NONNULL_END