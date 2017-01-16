//
//  NSString+NSStringExtras.h
//
//  Created by YiJianJun on 13-10-5.
//  Copyright (c) 2013年 YiJianJun. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NSStringExtras)

///nil [NSNULL null] length==0
- (BOOL)isEmpty;

/// 包含字符串
- (BOOL)containsSubString:(NSString *)aString;
- (BOOL)containsSubString:(NSString *)aString subStringRange:(nullable NSRange *)range;

///计算字符串所占的大小区域
- (CGFloat)heightForSelfWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)sizeForSelfWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)sizeForSelfWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;
+ (CGSize)sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

// HTML字符过滤
- (NSString *)flattenHTML;
- (NSString *)stringByFilterHtmlSpecialCharacter;

// - (instancetype)codeHtmlSpecialCharacter;

// 左右空格过滤
- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingRightAndLeftWhitespaceAndNewline;

- (NSString *)stringByRemoveWhitespace;

+ (nullable NSString *)getIPAddress;

@end

@interface NSString (RegexKitLite)
///Email邮件
- (BOOL)isEmail;
/// 中国移动
- (BOOL)isChinaMobilePhoneNumber;
/// 中国联通
- (BOOL)isChinaUnicomPhoneNumber;
/// 中国电信
- (BOOL)isChinaTelecomPhoneNumber;
/// 手机号码 (包括移动/联通/电信)
- (BOOL)isMobilePhoneNumber;
/// 座机
- (BOOL)isChinaLandlinesPhoneNumber;

/// 中国电话 (包括移动/联通/电信 座机/小灵通)
- (BOOL)isChinaPhoneNumber;

///八位或11位数字 座机号码
- (BOOL)isTelephoneNumber;
///电话 包括:手机或者座机
- (BOOL)isRightPhoneNumber;
///是否为网址
- (BOOL)isWebAddress;
@end

@interface NSString (JsonValid)
- (NSArray *)jsonFilterStrings;
- (BOOL)isVaildJsonString;
- (NSString *)vaildJsonString;
@end

@interface NSString (UUIDCategory)
///得到设备UUID字符串
+ (NSString *)getDeviceUUIDString;
///得到一个唯一的UUID字符串
+ (nullable NSString *)getUUIDString;
///得到现在时间戳的字符串
+ (NSString *)getDateUnqueDescription;
@end

@interface NSString (MKNetworkKitAdditions)
- (NSString *) mk_urlEncodedString;
- (nullable NSString *) urlDecodedString;
@end

@interface NSString (NSStringBase64)
- (nullable NSString *)encodeBase64String;
- (nullable NSString *)decodeBase64String;
@end

@interface NSString (ChineseStringAdditions)

/// 是否为中文字符
- (BOOL)isChineseChar:(unichar)aChar;

/// 是否为包含中文字符
- (BOOL)containsChineseString;
+ (BOOL)containsChineseString:(NSString *)aString;

/// 是否为全为中文字符
- (BOOL)isChineseString;
+ (BOOL)isChineseString:(NSString *)aString;

/// 移除中文
- (NSString *)removeChineseString;
+ (NSString *)removeChineseString:(NSString *)aString;
@end

NS_ASSUME_NONNULL_END