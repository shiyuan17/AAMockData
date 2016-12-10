//
//  AARandomCreditCardNumberGenerator.h
//  AAKitDemo
//  信用卡号、银行卡号生成
//  Created by shiyuan on 16/12/7.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define VISA_PREFIX_LIST @[@"4539",@"4556",@"4916",@"4532",@"4929",@"40240071", @"4485", @"4716", @"4" ]
#define MASTERCARD_PREFIX_LIST @[@"51",@"52",@"53", @"54", @"55"]
#define AMEX_PREFIX_LIST @[@"34", @"37"]
#define DISCOVER_PREFIX_LIST @[@"6011"]
#define DINERS_PREFIX_LIST @[@"300",@"301",@"302", @"303", @"36", @"38"]
#define ENROUTE_PREFIX_LIST @[@"2014",@"2149"]
#define JCB_PREFIX_LIST @[@"35"]
#define VOYAGER_PREFIX_LIST @[@"8699"]

@interface AARandomCreditCardNumberGenerator : NSObject
+ (NSArray<NSString *> *)generateMasterCardNumbers:(NSInteger)howMany;/**<生成指定量的银行卡、信用卡号*/
+ (NSString *)generateMasterCardNumber;/**<生成一个卡号*/
@end
