//
//  NSString+NSStringExtras.m
//
//  Created by YiJianJun on 13-10-5.
//  Copyright (c) 2013年 YiJianJun. All rights reserved.
//

#import "NSString+CommonCrypto.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (CommonDigest)

- (NSString *)__crypto_md_sha:(NSUInteger)len cc_md_sha:(unsigned char * (*)(const void *data,CC_LONG len,unsigned char *outBuffer))cc_md_sha{
    NSUInteger sLen = [self length];
    if(!self || !sLen){
        return @"";
    }
    const char *cstr = [self UTF8String];
    NSData *sData = [NSData dataWithBytes:cstr length:sLen];
    
    uint8_t digest[len];
    
    cc_md_sha(sData.bytes, (CC_LONG)sData.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:len * 2];
    
    for(int i = 0; i < len; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return [output copy];
}


- (NSString *)md2{
    return [self __crypto_md_sha:CC_MD2_DIGEST_LENGTH cc_md_sha:CC_MD2];
}

- (NSString *)md4{
    return [self __crypto_md_sha:CC_MD4_DIGEST_LENGTH cc_md_sha:CC_MD4];
}

- (NSString *)md5{
    return [self __crypto_md_sha:CC_MD5_DIGEST_LENGTH cc_md_sha:CC_MD5];
}
- (NSString *)sha1{
    return [self __crypto_md_sha:CC_SHA1_DIGEST_LENGTH cc_md_sha:CC_SHA1];
}

- (NSString *)sha224{
    return [self __crypto_md_sha:CC_SHA224_DIGEST_LENGTH cc_md_sha:CC_SHA224];
}

- (NSString *)sha256{
    return [self __crypto_md_sha:CC_SHA256_DIGEST_LENGTH cc_md_sha:CC_SHA256];
}

- (NSString *)sha384{
    return [self __crypto_md_sha:CC_SHA384_DIGEST_LENGTH cc_md_sha:CC_SHA384];
}

- (NSString *)sha512{
    return [self __crypto_md_sha:CC_SHA512_DIGEST_LENGTH cc_md_sha:CC_SHA512];
}


@end

@implementation NSString (CommonCryptor)
@end
