//
//  NSString+NSStringExtras.m
//
//  Created by YiJianJun on 13-10-5.
//  Copyright (c) 2013年 YiJianJun. All rights reserved.
//

#import "NSData+CommonCrypto.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@implementation NSData (CommonDigest)

- (NSData *)__crypto_md_sha:(NSUInteger)len cc_md_sha:(unsigned char * (*)(const void *data,CC_LONG len,unsigned char *outBuffer))cc_md_sha{
    NSUInteger sLen = [self length];
    if(!self || !sLen){
        return nil;
    }
    const char *cstr = self.bytes;
    uint8_t outBuffer[len];
    
    cc_md_sha(cstr, (CC_LONG)sLen, outBuffer);
    
    NSData *outputData = [NSData dataWithBytesNoCopy:outBuffer length:sLen];
    
    return outputData;
}


- (NSData *)md2{
    return [self __crypto_md_sha:CC_MD2_DIGEST_LENGTH cc_md_sha:CC_MD2];
}

- (NSData *)md4{
    return [self __crypto_md_sha:CC_MD4_DIGEST_LENGTH cc_md_sha:CC_MD4];
}

- (NSData *)md5{
    return [self __crypto_md_sha:CC_MD5_DIGEST_LENGTH cc_md_sha:CC_MD5];
}
- (NSData *)sha1{
    return [self __crypto_md_sha:CC_SHA1_DIGEST_LENGTH cc_md_sha:CC_SHA1];
}

- (NSData *)sha224{
    return [self __crypto_md_sha:CC_SHA224_DIGEST_LENGTH cc_md_sha:CC_SHA224];
}

- (NSData *)sha256{
    return [self __crypto_md_sha:CC_SHA256_DIGEST_LENGTH cc_md_sha:CC_SHA256];
}

- (NSData *)sha384{
    return [self __crypto_md_sha:CC_SHA384_DIGEST_LENGTH cc_md_sha:CC_SHA384];
}

- (NSData *)sha512{
    return [self __crypto_md_sha:CC_SHA512_DIGEST_LENGTH cc_md_sha:CC_SHA512];
}


@end

@implementation NSData (CommonCryptor)
///加密
- (NSData *)AES256EncryptWithKey:(NSString *)key{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

///解密
- (NSData *)AES256DecryptWithKey:(NSString *)key{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

@end
