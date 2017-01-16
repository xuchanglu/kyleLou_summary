//
//  NSDate+DateExtral.m
//  WorkLogger
//
//  Created by admin on 14-5-26.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "NSDate+DateExtral.h"
#import <time.h>
#import <xlocale.h>

@implementation NSDate (DateExtral)

static NSCalendar *gCalender = nil;

///根据dateFormat得到对应的字符串 yyyy-MM-dd HH:mm:ss
+ (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat{
    if(!dateFormat || !dateFormat.length){
        dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)stringFromDateFormat:(NSString *)dateFormat{
    if(!dateFormat || !dateFormat.length){
        dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return [self.class stringFromDate:self dateFormat:dateFormat];
}

///格式字符串 yyyy-MM-dd
- (NSString *)stringFromDateShortFormat:(NSString *)dateFormat{
    if(!dateFormat || !dateFormat.length){
        dateFormat = @"yyyy-MM-dd";
    }
    return [self.class stringFromDate:self dateFormat:dateFormat];
}

+ (NSDate *)dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat{
    if(!dateFormat || !dateFormat.length){
        dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter dateFromString:dateString];
}

///componts
- (void)initCalender{
    if(!gCalender){
        gCalender = [NSCalendar currentCalendar];
    }
}

- (NSDateComponents *)dateComponentsWithUnit:(NSCalendarUnit)unit{
    [self initCalender];
    NSDateComponents *components = [gCalender components:unit fromDate:self];
    return components;
}

- (NSInteger)dateYear{
    NSDateComponents *components = [self dateComponentsWithUnit:NSCalendarUnitYear];
    return [components year];
}

- (NSInteger)dateMonth{
    NSDateComponents *components = [self dateComponentsWithUnit:NSCalendarUnitMonth];
    return [components month];
}

- (NSInteger)dateDay{
    NSDateComponents *components = [self dateComponentsWithUnit:NSCalendarUnitDay];
    return [components day];
}

- (NSInteger)dateHour{
    NSDateComponents *components = [self dateComponentsWithUnit:NSCalendarUnitHour];
    return [components hour];
}

- (NSInteger)dateMinute{
    NSDateComponents *components = [self dateComponentsWithUnit:NSCalendarUnitMinute];
    return [components minute];
}

- (NSInteger)dateSecond{
    NSDateComponents *components = [self dateComponentsWithUnit:NSCalendarUnitSecond];
    return [components second];
}

- (NSInteger)dateWeekday{
    NSDateComponents *components = [self dateComponentsWithUnit:NSCalendarUnitWeekday];
    return [components weekday];
}


// NSString <-> NSDate 格式化数组默认为 "2012-10-10 23:10:10" 中 非数组(-,-, ,:,:,nil)
+ (NSString *)stringByDate:(NSDate *)date withFormatArray:(NSArray *)arrFormat{
    if(!arrFormat || [arrFormat count] < 5){
        arrFormat = nil;
        arrFormat = [NSArray arrayWithObjects:@"-",@"-",@" ",@":",@":",nil];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSMutableString *strFomat = [[NSMutableString alloc] init];//WithString:@"G "
    [strFomat appendFormat:@"yyyy%@MM%@dd%@",(NSString *)[arrFormat objectAtIndex:0],\
     (NSString *)[arrFormat objectAtIndex:1],\
     (NSString *)[arrFormat objectAtIndex:2]\
     ];
    [strFomat appendFormat:@"H%@mm%@ss",(NSString *)[arrFormat objectAtIndex:3],\
     (NSString *)[arrFormat objectAtIndex:4]
     ];
    if(6 == [arrFormat count]){
        [strFomat appendString:[arrFormat objectAtIndex:5]];
    }
    [dateFormatter setDateFormat:strFomat];
    [dateFormatter setDefaultDate:date];
    NSString *strRtn = [dateFormatter stringFromDate:date];
    //    [strFomat release];
    //    [dateFormatter release];
    return  strRtn;
}

+ (NSDate *)dateByString:(NSString *)strDate withFormatArray:(NSArray *)arrFormat{
    if(!arrFormat || [arrFormat count] < 5){
        arrFormat = nil;
        arrFormat = [NSArray arrayWithObjects:@"-",@"-",@" ",@":",@":",nil];
    }
    if(!strDate || [strDate length] < 18){
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSMutableString *strFomat = [[NSMutableString alloc] initWithString:@"G "];
    [strFomat appendFormat:@"yyyy%@MM%@dd%@",(NSString *)[arrFormat objectAtIndex:0],\
     (NSString *)[arrFormat objectAtIndex:1],\
     (NSString *)[arrFormat objectAtIndex:2]\
     ];
    [strFomat appendFormat:@"H%@mm%@ss",(NSString *)[arrFormat objectAtIndex:3],\
     (NSString *)[arrFormat objectAtIndex:4]
     ];
    if(6 == [arrFormat count]){
        [strFomat appendString:[arrFormat objectAtIndex:5]];
    }
    [dateFormatter setDateFormat:strFomat];
    NSDate *dateRtn = [dateFormatter dateFromString:strDate];
    //    [strFomat release];
    //    [dateFormatter release];
    return  dateRtn;
}

//得到时间格式化字符串
+ (NSString *)getIntervalTimeFromCreateTime:(double)time{
    NSDate *dateCreate = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSTimeInterval timeInterval = 0.0 - [dateCreate timeIntervalSinceNow];
    
    NSTimeInterval timeShift = 0;
    
    if(timeInterval <= 1e-6){
        NSLog(@"getIntervalTimeFromCreateTime:>有问题");
        return @"";
    }

    
    
    int nType = 0;
    NSMutableString *strTime = [[NSMutableString alloc] init];
    BOOL isHalfMathAgo = NO;
    do{
        switch (nType) {
            case 0:{//半个月以上
                int nHalfMath = 15*24*60*60;
                if((timeShift = timeInterval / nHalfMath) >= 1.0){
                    [strTime appendString:@"半个月以上"];
                    timeInterval = -1; //结束循环
                    isHalfMathAgo = YES;
                }else{
                    timeInterval = (long)timeInterval % nHalfMath;
                }
            }
                break;
            case 1:{//半个月以内
                int nDay = 24*60*60;
                if((timeShift = timeInterval / nDay) >= 1.0){
                    [strTime appendFormat:@"%d天",(int)timeShift];
                }
                timeInterval = (long)timeInterval % nDay;
            }
                break;
            case 2:{//一天以内
                int nHour = 60*60;
                if((timeShift = timeInterval / nHour) >= 1.0){
                    [strTime appendFormat:@"%d小时",(int)timeShift];
                }
                timeInterval = (long)timeInterval % nHour;
            }
                break;
            case 3:{//一个小时以内
                int nMinute = 60;
                if((timeShift = timeInterval / nMinute) >= 1.0){
                    [strTime appendFormat:@"%d分钟",(int)timeShift];
                }
                //timeInterval = (long)timeInterval % nMinute;
                timeInterval = - 1.0;
            }
                break;
            default:{
                NSLog(@"impossible");
            }
                break;
        }
        
        nType++;
    }while(timeInterval > 1e-6);
    
    if(!isHalfMathAgo){//不是半个月以上
        [strTime appendString:@"以前"];
    }
    return strTime;
}

+ (NSString *)stringByTimeInterval:(NSTimeInterval)timeInterval{
    if(timeInterval <= 1e-6){
        return @"";
    }
    if (timeInterval<1) {
        return @"00:01";
    }
    NSMutableString *strTime = [[NSMutableString alloc] init];
    int timeShift = 0;
    if((timeShift = (int)timeInterval/3600)){
        if(timeShift){
            [strTime appendFormat:@"%d:",(int)timeShift];
        }
    }
    timeInterval = (long)timeInterval % 3600;
    timeShift = (int)timeInterval/60;
    if(timeShift < 10){
        [strTime appendFormat:@"0%d:",(int)timeShift];
    }else{
        [strTime appendFormat:@"%d:",(int)timeShift];
    }
    
    timeShift = (long)timeInterval % 60;
    
    if(timeShift < 10){
        [strTime appendFormat:@"0%d",timeShift];
    }else{
        [strTime appendFormat:@"%d",timeShift];
    }
    return strTime;
}

- (NSString *)dateTips{
    NSDate *now = [NSDate date];
    
    NSInteger nowYear = [now dateYear];
    NSInteger year = [self dateYear];
    
    NSString *dateFormat;
    
    if(nowYear == year){
        NSInteger nowMonth = [now dateMonth];
        NSInteger month = [self dateMonth];
        
        if(nowMonth == month){
            NSInteger nowDay = [now dateDay];
            NSInteger day = [self dateDay];
            
            NSInteger interval = nowDay - day;
            switch (interval) {
                case 0:///今天
                    dateFormat = @"HH:mm";
                    break;
                case 1:///昨天
                    dateFormat = @"昨天 HH:mm";
                    break;
                case 2:///前天
                    dateFormat = @"前天 HH:mm";
                default:
                    dateFormat = @"MM月dd日";
                    break;
            }
        }else{
            dateFormat = @"MM月dd日";
        }
    }else{
        dateFormat = @"yyyy年MM月dd日";
    }
    
    return [self stringFromDateFormat:dateFormat];
}

/// 距离当前时间的间隔 例如:128天2小数24分钟
- (NSString *)timeIntervalForDate:(NSDate *)date{
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:date];
    
    NSInteger aMinute = 60;// 60s
    NSInteger aHour = 60 * aMinute;// 60 * 60s
    NSInteger aDay = 24 * aHour;// 24 * 60 * 60s
    
    long long timeInter = (long long) timeInterval;
    
    NSInteger day = timeInter / aDay;
    NSInteger hour = (timeInter % aDay) / aHour;
    NSInteger minute = (timeInter % aHour) / aMinute;
    
    NSMutableString *timeInteTips = [NSMutableString string];
    
    if(day > 0){
        [timeInteTips appendFormat:@"%d天",day];
    }
    if(hour > 0){
        [timeInteTips appendFormat:@"%d小时",hour];
    }
    if(minute > 0){
        [timeInteTips appendFormat:@"%d分钟",minute];
    }
    
    return timeInteTips;
}

- (NSString *)timeIntervalForNow{
    return [self timeIntervalForDate:[NSDate date]];
}

+ (NSString *)timeIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    return [fromDate timeIntervalForDate:toDate];
}

@end


@implementation NSDate (RFC1123)

+(NSDate*)dateFromRFC1123:(NSString*)value_
{
    if(value_ == nil)
        return nil;
    
    const char *str = [value_ UTF8String];
    const char *fmt;
    NSDate *retDate;
    char *ret;
    
    fmt = "%a, %d %b %Y %H:%M:%S %Z";
    struct tm rfc1123timeinfo;
    memset(&rfc1123timeinfo, 0, sizeof(rfc1123timeinfo));
    ret = strptime_l(str, fmt, &rfc1123timeinfo, NULL);
    if (ret) {
        time_t rfc1123time = mktime(&rfc1123timeinfo);
        retDate = [NSDate dateWithTimeIntervalSince1970:rfc1123time];
        if (retDate != nil)
            return retDate;
    }
    
    
    fmt = "%A, %d-%b-%y %H:%M:%S %Z";
    struct tm rfc850timeinfo;
    memset(&rfc850timeinfo, 0, sizeof(rfc850timeinfo));
    ret = strptime_l(str, fmt, &rfc850timeinfo, NULL);
    if (ret) {
        time_t rfc850time = mktime(&rfc850timeinfo);
        retDate = [NSDate dateWithTimeIntervalSince1970:rfc850time];
        if (retDate != nil)
            return retDate;
    }
    
    fmt = "%a %b %e %H:%M:%S %Y";
    struct tm asctimeinfo;
    memset(&asctimeinfo, 0, sizeof(asctimeinfo));
    ret = strptime_l(str, fmt, &asctimeinfo, NULL);
    if (ret) {
        time_t asctime = mktime(&asctimeinfo);
        return [NSDate dateWithTimeIntervalSince1970:asctime];
    }
    
    return nil;
}

-(NSString*)rfc1123String
{
    time_t date = (time_t)[self timeIntervalSince1970];
    struct tm timeinfo;
    gmtime_r(&date, &timeinfo);
    char buffer[32];
    size_t ret = strftime_l(buffer, sizeof(buffer), "%a, %d %b %Y %H:%M:%S GMT", &timeinfo, NULL);
    if (ret) {
        return @(buffer);
    } else {
        return nil;
    }
}

@end
