//
//  AAMockDateSource.m
//  AAKitDemo
//
//  Created by shiyuan on 16/12/7.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import "AAMockDateSource.h"
#import "AAMockRandom.h"
@implementation AAMockDateSource
+ (NSDate *)randomDate:(RandomDateType)type{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [AAMockDateSource aa_dateFormatter];
     [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger year = [dateComponent year];
    
    NSInteger fromNum;
    NSInteger toNum;
    switch (type) {
        case RandomDateTypeDefault:
        {
            fromNum = 1971;
            toNum = 2036;
        }
            break;
        case RandomDateTypeAfter:
        {
            fromNum = year;
            toNum = 2036;
        }
            break;
        case RandomDateTypeBefore:
        {
            fromNum = 1971;
            toNum = year;
        }
            break;
        default:{
            fromNum = 1971;
            toNum = 2036;
        }
            break;
    }
    
    NSInteger yearRandom = [AAMockRandom randomNumber:fromNum to:toNum];
    NSInteger monthRandom =  [AAMockRandom randomNumber:1 to:12];
    NSInteger monthDayRandom;
    if (monthRandom==2) {
        monthDayRandom =  [AAMockRandom randomNumber:1 to:28];
    }else{
        monthDayRandom =  [AAMockRandom randomNumber:1 to:30];
    }
    NSInteger hourRandom =[AAMockRandom randomNumber:1 to:24];
    NSInteger minuteRandom = [AAMockRandom randomNumber:1 to:59];
    NSInteger secondRandom =[AAMockRandom randomNumber:1 to:59];
    NSString *randomDateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:%02ld",yearRandom,monthRandom,monthDayRandom,hourRandom,minuteRandom,secondRandom];
    //YYYY-MM-dd hh:mm:ss:SSS
    NSDate *randomDate = [formatter dateFromString:randomDateStr];
    return randomDate;
}

#pragma mark 随机日期
+ (NSString *)randomDateString:(RandomDateType)type{
    NSDate *randomDate = [AAMockDateSource randomDate:type];
    NSDateFormatter *formatter = [AAMockDateSource aa_dateFormatter];
    NSString *dateStr = [formatter stringFromDate:randomDate];
    return dateStr;
}

+(NSDateFormatter *)aa_dateFormatter {
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    });
    
    return formatter;
}


#pragma mark 随机时间戳
+ (NSString *)randomDateTimestamp:(RandomDateType)type{
    NSDate *date = [AAMockDateSource randomDate:type];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

+ (NSString *)randomDateTimestamp{
    NSDate *date = [AAMockDateSource randomDate:RandomDateTypeDefault];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}
@end
