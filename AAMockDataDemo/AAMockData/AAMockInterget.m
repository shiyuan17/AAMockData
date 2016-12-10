//
//  AAMockInterget.m
//  AAKitDemo
//
//  Created by shiyuan on 16/12/9.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import "AAMockInterget.h"
#import "AAMockRandom.h"

@implementation AAMockInterget
#pragma mark 随机年龄生成
+ (NSInteger)randomAge{
   return [AAMockRandom randomNumber:12 to:90];
}

#pragma mark 随机编号
+ (NSInteger)randomNumber{
    return [AAMockRandom randomNumber:100 to:99999];
}

@end
