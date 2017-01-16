//
//  NSString+NSStringExtras.h
//
//  Created by YiJianJun on 13-10-5.
//  Copyright (c) 2013年 YiJianJun. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface NSData (CommonDigest)
- (NSData *)md2;
- (NSData *)md4;
- (NSData *)md5;
- (NSData *)sha1;
- (NSData *)sha224;
- (NSData *)sha256;
- (NSData *)sha384;
- (NSData *)sha512;
@end

@interface NSData (CommonCryptor)

///加密
//- (NSData *)AES256EncryptWithKey:(NSString *)key;
/////解密
//- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end