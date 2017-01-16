//
//  NSString+NSStringExtras.m
//
//  Created by YiJianJun on 13-10-5.
//  Copyright (c) 2013年 YiJianJun. All rights reserved.
//

#import "NSString+NSStringExtras.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

#import "NSData+DataExtral.h"

@implementation NSString (NSStringExtras)

- (BOOL)isEmpty{
    BOOL empty = YES;
    if(self && ([self isKindOfClass:[NSString class]] || [self description].length || self.length)){
        empty = NO;
    }
    return empty;
}


/// 包含字符串
- (BOOL)containsSubString:(NSString *)aString{
    return [self containsSubString:aString subStringRange:NULL];
}

- (BOOL)containsSubString:(NSString *)aString subStringRange:(NSRange *)range{
    if(!aString || ![aString length] || [aString length] > [self length]){
        return NO;
    }
    NSRange subStringRange = [self rangeOfString:aString];
    
    if(range && subStringRange.length){
        *range = subStringRange;
    }
    return (BOOL)(subStringRange.length);
}

- (CGFloat)heightForSelfWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth lineBreakMode:(NSLineBreakMode)lineBreakMode{
    return [self sizeForSelfWithFont:font limitWidth:limitWidth lineBreakMode:lineBreakMode].height;
}

- (CGSize)sizeForSelfWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth lineBreakMode:(NSLineBreakMode)lineBreakMode{
    CGSize constrainedSize = CGSizeMake(limitWidth, CGFLOAT_MAX);
    return [self sizeForSelfWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
}

- (CGSize)sizeForSelfWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode{
    if(!self || [self isEmpty]){
        return CGSizeZero;
    }
    return [NSString sizeForString:self font:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
}

+ (CGSize)sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }
    
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
}

- (NSString *)flattenHTML{
    
    NSScanner *theScanner;
    NSString *text = nil;
    NSString *strRes = self;
    
    theScanner = [NSScanner scannerWithString:strRes];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        strRes = [strRes stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@>", text] withString:@""];
        
    } // while //
    
    return strRes;
    
}

- (NSString *)stringByFilterHtmlSpecialCharacter{
    //默认过滤列表
    NSString *strRes = self;
    NSArray *arrFilterString = @[@"&gt;",@"&lt;",@"&amp;nbsp;",@"&nbsp;",@"&quot;",@"&#39;", @"&amp;"];
    NSArray *arrReplaceChars = @[@">",@"<",@" ",@" ",@"\\",@"\\",@"&"];
    NSDictionary *dictFilter = [NSDictionary dictionaryWithObjects:arrReplaceChars forKeys:arrFilterString];
    
    for(NSString *filterChar in arrFilterString){
        NSString *replaceChar = (NSString *)[dictFilter objectForKey:filterChar];
        if(replaceChar){
            strRes = [strRes stringByReplacingOccurrencesOfString:filterChar withString:replaceChar];
        }
    }
    return strRes;
}

- (NSString *)codeHtmlSpecialCharacter{
    if(nil == self || !self.length){ //默认过滤列表
        return nil;
    }
//    NSArray *arrFilterString = [NSArray arrayWithObjects:@"&gt;",@"&lt;",@"&nbsp;",@"&quot;",@"&#39;",@"<br/>", nil];
    
    NSString *strRes = self;
    NSArray *arrReplaceChars = [NSArray arrayWithObjects:@"&gt;",@"&lt;",@"&nbsp;",@"&quot;",@"&#39;",@"<br/>", nil];
    
    NSArray *arrSpecialChars = [NSArray arrayWithObjects:@">",@"<",@" ",@"\\",@"\\",@"<br/>", nil];
    
    NSDictionary *dictFilter = [NSDictionary dictionaryWithObjects:arrReplaceChars forKeys:arrSpecialChars];
    
    for(NSString *filterChar in arrSpecialChars){
        NSString *replaceChar = (NSString *)[dictFilter objectForKey:filterChar];
        if(replaceChar){
            strRes = [strRes stringByReplacingOccurrencesOfString:filterChar withString:replaceChar];
        }
    }
    return strRes;
}

- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar *charBuffer = (unichar *)malloc(length * sizeof(unichar));
    [self getCharacters:charBuffer range:NSMakeRange(0,length)];
    //[self getCharacters:charBuffer];
    for (location = 0; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    free(charBuffer);
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar *charBuffer = (unichar *)malloc(length * sizeof(unichar));//[length];
    [self getCharacters:charBuffer range:NSMakeRange(0,length)];
    //[self getCharacters:charBuffer];
    
    for (location = length; location > 0; location--) {
        if (![characterSet characterIsMember:charBuffer[location - 1]]) {
            break;
        }
    }
    free(charBuffer);
    return [self substringWithRange:NSMakeRange(0, location)];
}

- (NSString *)stringByTrimmingRightAndLeftWhitespaceAndNewline{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *strLeft = [self stringByTrimmingLeftCharactersInSet:set];
    NSString *strRight = [strLeft stringByTrimmingRightCharactersInSet:set];
    return strRight;
}

- (NSString *)stringByRemoveWhitespace{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (NSAttributedString *)attributedStringWithColor:(UIColor *)stringColor{
    if(self && [self length] && stringColor){
        return [[NSAttributedString alloc] initWithString:self attributes:@{NSForegroundColorAttributeName:stringColor}];
    }
    return nil;
}

+ (NSAttributedString *)attributedString:(NSString *)string color:(UIColor *)stringColor{
    return [string attributedStringWithColor:stringColor];
}

+ (NSString *)getIPAddress
{
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }else{
                    NSLog(@"ifa name:%@",[NSString stringWithUTF8String:temp_addr->ifa_name]);
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

@end

@implementation NSString (RegexKitLite)

- (BOOL)isEmail{
    ///邮箱
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [predicate evaluateWithObject:self];
}

/*
 * 手机号码
 * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
 * 联通：130,131,132,152,155,156,185,186
 * 电信：133,1349,153,180,189

 NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";

 * 中国移动：China Mobile
 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188

 NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";

 * 中国联通：China Unicom
 * 130,131,132,152,155,156,185,186

 NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";

 * 中国电信：China Telecom
 * 133,1349,153,180,189
 NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
 
 * 大陆地区固话及小灵通
 * 区号：010,020,021,022,023,024,025,027,028,029
 * 号码：七位或八位
 NSString * PHS = @"^0(10|2[0-5789]|\\d{3})-?\\d{7,8}$";
 
 * 中国移动/中国联通/中国电信 综合
 NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
*/

/// 中国移动
- (BOOL)isChinaMobilePhoneNumber{
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    return [predicate evaluateWithObject:self];
}

/// 中国联通
- (BOOL)isChinaUnicomPhoneNumber{
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    return [predicate evaluateWithObject:self];
}

/// 中国电信
- (BOOL)isChinaTelecomPhoneNumber{
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    return [predicate evaluateWithObject:self];
}

/// 手机号码 (包括移动/联通/电信)
- (BOOL)isMobilePhoneNumber{
    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [predicate evaluateWithObject:self];
}

/// 座机
- (BOOL)isChinaLandlinesPhoneNumber{
//    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})-?\\d{7,8}$";
//    NSString *PHS = @"^0(((10|2[0-5789])-?\\d{8})|(\\d{3}-?\\d{7}))$";
//    NSString *PHS = @"^0(((10|2[0-5789])-?\\d{8})|(\\d{3}-?\\d{7,8}))$";
    
    //验证输入的固话中带 "-"符号
    NSString * PHS = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    return [predicate evaluateWithObject:self];
}

/// 中国电话 (包括移动/联通/电信 座机/小灵通)
- (BOOL)isChinaPhoneNumber{
    return [self isMobilePhoneNumber] || [self isChinaLandlinesPhoneNumber] || [self isTelephoneNumber];
}

///八位或11位数字 座机号码
- (BOOL)isTelephoneNumber{
    NSString *telephoneNumberRegex = @"^\\d{8}$|^\\d{11}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telephoneNumberRegex];
    return [predicate evaluateWithObject:self];
}

///电话 包括:手机或者座机
- (BOOL)isRightPhoneNumber{
    return [self isMobilePhoneNumber] || [self isTelephoneNumber];
}

///是否为网址
- (BOOL)isWebAddress{
    ///((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)
    NSString *webAddressRegex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",webAddressRegex];
    return [predicate evaluateWithObject:self];
}
@end

@implementation NSString (JsonValid)

- (NSArray *)jsonFilterStrings{
    static NSArray *jsonFilterStrings = nil;
    if(!jsonFilterStrings){
        jsonFilterStrings = @[@"\"",@":",@";",@"\n",@"\\"];
    }
    return jsonFilterStrings;
}

- (BOOL)isVaildJsonString{
    NSArray *filterStrings = [self jsonFilterStrings];
    for (NSString *filter in filterStrings) {
        if([self rangeOfString:filter].location != NSNotFound){
            return NO;
        }
    }
    return YES;
}

- (NSString *)vaildJsonString{
    NSMutableString *resString = [self mutableCopy];
    NSArray *filterStrings = [self jsonFilterStrings];
    for (NSString *filter in filterStrings) {
        NSRange range = [self rangeOfString:filter];
        
        ///找到后移除
        if(range.location != NSNotFound){
            [resString replaceCharactersInRange:range withString:@""];
        }
    }
    return [resString copy];
}

@end

@implementation NSString (UUIDCategory)
+ (instancetype)getDeviceUUIDString{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (instancetype)getUUIDString{
    CFUUIDRef   uuid;
    CFStringRef uuidStrRef;
    
    uuid = CFUUIDCreate(NULL);
    if(!uuid){
        return nil;
    }
    
    uuidStrRef = CFUUIDCreateString(NULL, uuid);
    if(!uuidStrRef){
        return nil;
    }
    
    NSString *uuidString = [NSString stringWithFormat:@"%@",uuidStrRef];
    
    CFRelease(uuidStrRef);
    CFRelease(uuid);
    
    return uuidString;
}

+ (NSString *)getDateUnqueDescription{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"%m%d%Y%H%M%S%F"];
    return [formatter stringFromDate:now];
}

+ (instancetype)getTimeIntervalSince1970Description{
    NSDate *now = [NSDate date];
    NSTimeInterval timeInterval = [now timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",timeInterval];
}

@end

@implementation NSString (MKNetworkKitAdditions)

- (NSString *) mk_urlEncodedString { // mk_ prefix prevents a clash with a private api
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString *) urlDecodedString{
    NSString *originStr = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];/// 把 + 转为 空格
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) originStr,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return decodedString;//(!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

@end

@implementation NSString (NSStringBase64)

- (NSString *)encodeBase64String{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    if(data){
        if([data respondsToSelector:@selector(base64EncodedDataWithOptions:)]){
            return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        }else{
            /// iOS7 以下
            return [data base64EncodeString];
        }
    }
    
    return nil;
}

- (NSString *)decodeBase64String{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    if(data){
        if([data respondsToSelector:@selector(initWithBase64EncodedData:options:)]){
            NSData *decodeData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
            return [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
        }else{
            /// iOS 7 以下
            NSData *decodeData = [NSData base64DecodeDataFromString:self];
            if(decodeData){
                return [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
            }
        }
    }
    
    return nil;
}

@end


@implementation NSString (ChineseStringAdditions)


/// 是否为中文字符
- (BOOL)isChineseChar:(unichar)aChar{
    return aChar >= 0x4e00 && aChar <= 0x9fff;
}

/// 是否为包含中文字符
- (BOOL)containsChineseString{
    NSInteger len = self.length;
    for(NSInteger idx = 0; idx < len ; idx++){
        unichar aChar = [self characterAtIndex:idx];
        
        /// 中文字符
        if([self isChineseChar:aChar]){
            return YES;
        }
    }
    return NO;
}

+ (BOOL)containsChineseString:(NSString *)aString{
    return [aString containsChineseString];
}

/// 是否为全为中文字符
- (BOOL)isChineseString{
    NSInteger len = self.length;
    for(NSInteger idx = 0; idx < len ; idx++){
        unichar aChar = [self characterAtIndex:idx];
        
        /// 中文字符
        if([self isChineseChar:aChar]){
            continue;
        }else{
            return NO;
        }
        
    }
    return YES;
}

+ (BOOL)isChineseString:(NSString *)aString{
    return [aString isChineseString];
}

/// 移除中文
- (NSString *)removeChineseString{
    NSMutableString *retString = [NSMutableString string];
    NSInteger len = self.length;
    for(NSInteger idx = 0; idx < len ; idx++){
        unichar aChar = [self characterAtIndex:idx];
        
        /// 中文字符
        if([self isChineseChar:aChar]){
            continue;
        }else{
            NSString *subString = [self substringWithRange:NSMakeRange(idx, 1)];
            if(subString){
                [retString appendString:subString];
            }
        }
    }
    
    return retString;
}

+ (NSString *)removeChineseString:(NSString *)aString{
    return [aString removeChineseString];
}

@end
