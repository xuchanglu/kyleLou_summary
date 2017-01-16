//
//  NSDate+DateExtral.h
//  WorkLogger
//
//  Created by admin on 14-5-26.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (DateExtral)

///根据dateFormat得到对应的字符串 yyyy-MM-dd HH:mm:ss
+ (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;
///格式字符串 yyyy-MM-dd HH:mm:ss
- (NSString *)stringFromDateFormat:(NSString *)dateFormat;
///格式字符串 yyyy-MM-dd
- (NSString *)stringFromDateShortFormat:(NSString *)dateFormat;

///格式字符串 yyyy-MM-dd HH:mm:ss
+ (nullable NSDate *)dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

///componts
- (NSDateComponents *)dateComponentsWithUnit:(NSCalendarUnit)unit;
- (NSInteger)dateYear;
- (NSInteger)dateMonth;
- (NSInteger)dateDay;
- (NSInteger)dateHour;
- (NSInteger)dateMinute;
- (NSInteger)dateSecond;
- (NSInteger)dateWeekday;

// NSString <-> NSDate 格式化数组默认为 "2012-10-10 23:10:10" 中 非数组(-,-, ,:,:,nil)
+ (NSString *)stringByDate:(NSDate *)date withFormatArray:(NSArray *)arrFormat;
+ (nullable NSDate * )dateByString:(NSString *)strDate withFormatArray:(NSArray *)arrFormat;
///得到时间戳的间隔提示
+ (NSString *)getIntervalTimeFromCreateTime:(double)time;
///得到时间戳的时间提示 通常用于音视频的时间显示
+ (NSString *)stringByTimeInterval:(NSTimeInterval)timeInterval;

///BPC时间提示
- (NSString *)dateTips;

/// 距离当前时间的间隔 例如:128天2小数24分钟
- (NSString *)timeIntervalForDate:(NSDate *)date;
- (NSString *)timeIntervalForNow;
+ (NSString *)timeIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end

@interface NSDate (RFC1123)
/**
 Convert a RFC1123 'Full-Date' string
 (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1)
 into NSDate.
 */
+(nullable NSDate*)dateFromRFC1123:(NSString*)value_;

/**
 Convert NSDate into a RFC1123 'Full-Date' string
 (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1).
 */
-(nullable NSString*)rfc1123String;

@end

NS_ASSUME_NONNULL_END
