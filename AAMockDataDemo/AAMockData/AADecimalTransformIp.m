//
//  AATS.m
//  AAKitDemo
//
//  Created by shiyuan on 16/12/8.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import "AADecimalTransformIp.h"

@implementation AADecimalTransformIp
+ (NSString *)decimalToIp:(NSInteger)ip{
    NSMutableArray *b = [NSMutableArray array];
    NSString *x = @"";
    
    b[0] =@(((ip >> 24) & 0xff));
    b[1] =  @((ip >> 16) & 0xff);
    b[2] = @((ip >> 8) & 0xff);
    b[3] = @(ip & 0xff);
    x = [NSString stringWithFormat:@"%@.%@.%@.%@",b[0],b[1],b[2],b[3]];
    return x;
}
@end
