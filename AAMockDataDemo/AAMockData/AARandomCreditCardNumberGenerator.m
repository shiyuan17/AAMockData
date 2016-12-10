//
//  AARandomCreditCardNumberGenerator.m
//  AAKitDemo
//
//  Created by shiyuan on 16/12/7.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import "AARandomCreditCardNumberGenerator.h"

@implementation AARandomCreditCardNumberGenerator
+ (NSString *)strrev:(NSString *)str{
    if (str == nil || str == NULL || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    NSString *revstr = @"";
    for (NSInteger i = str.length - 1; i >= 0; i--) {
        revstr = [NSString stringWithFormat:@"%@%@",revstr,[str substringWithRange:NSMakeRange(i, 1)]];
    }
    return revstr;
}

+ (NSString *)completed_number:(NSString *)prefix length:(NSInteger)length{
    
    NSString *ccnumber = prefix;
    
    // generate digits
    
    while (ccnumber.length < (length - 1)) {
        NSInteger ran = (NSInteger)(0 + (arc4random() % (10 - 0 + 1)));
        ccnumber = [NSString stringWithFormat:@"%@%ld",ccnumber,ran];
    }
    
    NSString *reversedCCnumberString = [AARandomCreditCardNumberGenerator strrev:ccnumber];
    
    NSMutableArray *reversedCCnumberList =[[NSMutableArray alloc] init];
    for (int i = 0; i < reversedCCnumberString.length; i++) {
        [reversedCCnumberList addObject:[NSString stringWithFormat:@"%@",[reversedCCnumberString substringWithRange:NSMakeRange(i, 1)]]];
    }
    
    NSInteger sum = 0;
    NSInteger pos = 0;
    
    NSMutableArray *reversedCCnumber = [NSMutableArray arrayWithArray:reversedCCnumberList];
    while (pos < length - 1) {
        
        NSInteger odd = [reversedCCnumber[pos] integerValue] * 2;
        if (odd > 9) {
            odd -= 9;
        }
        
        sum += odd;
        
        if (pos != (length - 2)) {
            sum += [reversedCCnumber[pos + 1] integerValue];
        }
        pos += 2;
    }
    
    // calculate check digit
    NSInteger checkdigit = (NSInteger)((floor(sum / 10) + 1) * 10 - sum)%10;

    ccnumber = [NSString stringWithFormat:@"%@%ld",ccnumber,checkdigit];
    return ccnumber;
}

+ (NSArray<NSString *> *)credit_card_number:(NSArray<NSString *> *)prefixList length:(NSInteger)length howMany:(NSInteger)howMany{
    NSMutableArray <NSString *> *result = [[NSMutableArray alloc] init];
    for (int i = 0; i < howMany; i++) {
        NSInteger tmp = (NSInteger)(0 + (arc4random() % (prefixList.count - 0 + 1)));;
        
        while (floor(tmp)>=prefixList.count) {
            tmp = (NSInteger)(0 + (arc4random() % (prefixList.count - 0 + 1)));
        }
        NSInteger randomArrayIndex = floor(tmp);
        NSString *ccnumber = prefixList[randomArrayIndex];
        [result addObject:[AARandomCreditCardNumberGenerator completed_number:ccnumber length:length]];
    }
    return result;
}

#pragma mark -生成指定量的银行卡、信用卡号
+ (NSArray<NSString *> *)generateMasterCardNumbers:(NSInteger)howMany{
    return [AARandomCreditCardNumberGenerator credit_card_number:MASTERCARD_PREFIX_LIST length:16 howMany:howMany];
}

+ (NSString *)generateMasterCardNumber{
    return [AARandomCreditCardNumberGenerator credit_card_number:MASTERCARD_PREFIX_LIST length:16 howMany:1][0];
}

+ (BOOL)isValidCreditCardNumber:(NSString *)creditCardNumber{
    BOOL isValid = false;

    @try {
        NSString *reversedNumber =[AARandomCreditCardNumberGenerator reverse:creditCardNumber];

        NSInteger mod10Count = 0;
        for (int i = 0; i < reversedNumber.length; i++) {
            NSInteger augend = [[reversedNumber substringWithRange:NSMakeRange(i, 1)] integerValue];
            if (((i + 1) % 2) == 0) {
                NSString *productString = [NSString stringWithFormat:@"%ld",(augend * 2)];
                augend = 0;
                for (int j = 0; j < productString.length; j++) {
                    augend += [[productString substringWithRange:NSMakeRange(i, 1)] integerValue];
                }
            }
            mod10Count += augend;
        }
        
        if ((mod10Count % 10) == 0) {
            isValid = true;
        }
        
    } @catch (NSException *exception) {
        
    }
    
    return isValid;
}

+ (NSString *)reverse:(NSString *)str{
    NSInteger length = str.length;
    NSString *reverse = @"";  //注意这是空串，不是null
    for (int i = 0; i < length; i++){
        NSString *tmp = [NSString stringWithFormat:@"%@",[str substringWithRange:NSMakeRange(i, 1)]];
        reverse = [NSString stringWithFormat:@"%@%@",tmp,reverse];
    }
    return reverse;
}
@end
