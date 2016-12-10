//
//  AAMockRandom.m
//  AAKitDemo
//
//  Created by shiyuan on 16/12/9.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import "AAMockRandom.h"

@implementation AAMockRandom
#pragma mark - 随机数范围生成
+(NSInteger)randomNumber:(NSInteger)from to:(NSInteger)to
{
    srand((unsigned)time(0));
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

#pragma mark 随机抽取数组内容
+ (NSString *)randomTextWithArray:(NSArray *)arr{
    NSInteger random = [AAMockRandom randomNumber:0 to:arr.count-1];
    NSString *tmpStr = arr[random];
    return tmpStr;
}
@end
