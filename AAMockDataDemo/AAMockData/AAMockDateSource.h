//
//  AAMockDateSource.h
//  AAKitDemo
//
//  Created by shiyuan on 16/12/7.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, RandomDateType) {
    RandomDateTypeDefault = 0,//默认1970-3016
    RandomDateTypeAfter = 1,//今天往后
    RandomDateTypeBefore = 2//今天往前
};
@interface AAMockDateSource : NSObject
+ (NSDate *)randomDate:(RandomDateType)type;/**<根据类型随机日期*/
+ (NSString *)randomDateString:(RandomDateType)type;/**<根据类型随机日期*/
+ (NSString *)randomDateTimestamp:(RandomDateType)type;/**<根据类型随机时间戳*/
+ (NSString *)randomDateTimestamp;/**<按默认类型随机生成时间戳*/
@end
