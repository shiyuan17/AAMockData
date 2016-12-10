//
//  AAMockRandom.h
//  AAKitDemo
//
//  Created by shiyuan on 16/12/9.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAMockRandom : NSObject
+(NSInteger)randomNumber:(NSInteger)from to:(NSInteger)to;/**<随机数范围生成*/
+ (NSString *)randomTextWithArray:(NSArray *)arr;/**<随机抽取数组内容*/
@end
