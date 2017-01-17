//
//  AAMockStringSource.m
//  AAKitDemo
//
//  Created by shiyuan on 16/12/7.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import "AAMockStringSource.h"
#import "AAMockTestDataManager.h"
#import "AADecimalTransformIp.h"
#import "AARandomCreditCardNumberGenerator.h"
#import "AAMockRandom.h"

@implementation AAMockStringSource
+ (NSString *)randomText:(RandomContentType)type{
    NSString *text = @"";
    switch (type) {
        case RandomContentTypeTitle:
        {
            text = [AAMockStringSource randomTitle];
        }
        break;
        case RandomContentTypeName:
        {
            text = [AAMockStringSource randomName];
        }
        break;
        case RandomContentTypeEmail:
        {
            text = [AAMockStringSource randomEmail];
        }
        break;
        case RandomContentTypePhone:
        {
            text = [AAMockStringSource randomPhone];
        }
        break;
        case RandomContentTypeIDCard:
        {
            text = [AAMockStringSource randomIDCard];
        }
        break;
        case RandomContentTypeAddress:
        {
            text = [AAMockStringSource randomAddress:AddresTypeALL];
        }
        break;
        case RandomContentTypeZipCode:
        {
            text = [AAMockStringSource randomZipCode];
        }
        break;
        case RandomContentTypeMaxContent:
        {
            text = [AAMockStringSource randomContentWithRandomMax:150];
        }
        break;
        case RandomContentTypeEnglishName:
        {
            text = [AAMockStringSource randomEnglishName];
        }
        break;
        case RandomContentTypeBankCardNumber:
        {
            text = [AAMockStringSource randomName];
        }
        break;
        case RandomContentTypeEnglis:
        {
            text = [AAMockStringSource randomEnglish];
        }
        break;
        case RandomContentTypeOffice:
        {
            text = [AAMockStringSource randomOffice];
        }
        break;
        case RandomContentTypeEducation:
        {
            text = [AAMockStringSource randomEducation];
        }
        break;
        default:
        {
            text = [AAMockStringSource randomTitle];
        }
        break;
    }
    return text;
}

#pragma mark 随机生成标题
+ (NSString *)randomTitle{
    NSArray<NSString *> *arrayTitle = [AAMockTestDataManager findTitleList];
    return [AAMockRandom randomTextWithArray:arrayTitle];
}

#pragma mark - 随机生成中文名称
+ (NSString *)randomName{
    NSArray<NSString *> *arrayName = [AAMockTestDataManager findChineseName];
     return [AAMockRandom randomTextWithArray:arrayName];
}

#pragma mark 随机生成英文名称
+ (NSString *)randomEnglishName{
   NSArray<NSString *> *arrayEnglishs = [AAMockTestDataManager findEnglishNameList];
    return [AAMockRandom randomTextWithArray:arrayEnglishs];
}

#pragma mark - 随机内容生成
#pragma mark 常用汉字集
+ (NSString *)stringContent{
   NSString *content = [AAMockTestDataManager findChineseCharacters];
    return content;
}

+ (NSString *)randomContentWithRandomMax{
    return [AAMockStringSource randomContentWithRandomMax:160];
}

#pragma mark 生成20到max范围内长度的字符数据
+ (NSString *)randomContentWithRandomMax:(NSInteger)max{
    NSInteger random = max;
    if(max<=0){
        random =  [AAMockRandom randomNumber:20 to:200];
    }else{
        random = [AAMockRandom randomNumber:20 to:max];
    }
    NSString *tmp = [AAMockStringSource randomCotentWithLength:random];
    return tmp;
}

#pragma mark 根据指定长度生成内容
+ (NSString *)randomCotentWithLength:(NSInteger)len{
    NSString *content = [AAMockStringSource stringContent];
    NSInteger random = [AAMockRandom randomNumber:0 to:content.length-len];
    NSString *text = [content substringWithRange:NSMakeRange(random, len)];
    return text;
}

#pragma mark - 生成随机电话号码
+ (NSString *)randomPhone{
    NSString *telStart = @"134,135,136,137,138,139,150,151,152,157,158,159,130,131,132,155,156,133,153,180,181,182,183,185,186,176,187,188,189,177,178";
    NSArray<NSString *> *telStarts = [telStart componentsSeparatedByString:@","];
    NSInteger index = arc4random() % (telStarts.count-1);
    NSString *first = telStarts[index];
    NSString *second = [NSString stringWithFormat:@"%d", ((arc4random() % 100) + 889)+10000];
    second = [second substringFromIndex:1];
    NSString *thrid = [NSString stringWithFormat:@"%d", ((arc4random() % 1) + 9100)+10000];
    thrid = [thrid substringFromIndex:1];
    NSString *phone = [NSString stringWithFormat:@"%@%@%@",first,second,thrid];
    return phone;
}

#pragma mark - 地址数据生成
#pragma mark 获取地址数据
+ (NSArray *)addressFileData{
    NSError*error;
    //获取文件路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"province_city_district"ofType:@"json"];
    
    //根据文件路径读取数据
    NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
    
    //格式化成json数据
    NSArray *jsonObjects=[NSJSONSerialization JSONObjectWithData:jdata                     options:NSJSONReadingAllowFragments                       error:&error];
    return jsonObjects;
}

#pragma mark 根据类型获取对应地址数据
+ (NSString *)randomAddress{
    return [AAMockStringSource randomAddress:AddresTypeALL];
}

+ (NSString *)randomAddress:(AddresType)type{
    NSArray *address = [AAMockStringSource addressFileData];
    NSInteger pindex = arc4random() % (address.count-1);
    NSString *province = [address[pindex] valueForKey:@"name"];
    
    NSArray *citys = [address[pindex] valueForKey:@"city_list"];
    NSInteger cindex = 1;
    if(citys.count>2){
        cindex = arc4random() % (citys.count-1);
    }
    NSString *city = [citys[cindex>citys.count?cindex:0] valueForKey:@"name"];
    
    NSArray *areas = [citys[cindex>citys.count?cindex:0] valueForKey:@"area_list"];
    NSInteger aindex = arc4random() % (citys.count>1?(citys.count-1):citys.count);
    NSString *area;
    if(areas.count>aindex){
        area = [areas[aindex] valueForKey:@"name"];
    }
    
    NSString *number = [NSString stringWithFormat:@"%ld号",[AAMockRandom randomNumber:0 to:200]];
    
    NSString *addressStr = [NSString stringWithFormat:@"%@ %@ %@ %@",province,city,area,number];
    NSString *resultAddress = @"";
    switch (type) {
        case AddresTypeALL:
        {
            resultAddress = addressStr;
        }
            break;
        case AddresTypeProvince:
        {
            resultAddress = province;
        }
            break;
        case AddresTypeCity:
        {
            resultAddress = city;
        }
            break;
        case AddresTypeArea:
        {
            resultAddress = area;
        }
            break;
        default:
        {
            resultAddress = addressStr;
        }
            break;
    }
    return resultAddress;
}

#pragma mark 生成隐藏Email地址
+ (NSString *)randomEmail{
    NSArray *emailSuffixs = @[ @"qq.com",@"163.com",@"163.net",@"126.com", @"hotmail.com",@"139.com",@"sina.com",@"yahoo.com", @"inbox.com",@"live.com",@"msn.com",@"126.com" ];
    NSInteger random = [AAMockRandom randomNumber:0 to:emailSuffixs.count-1];
    NSString *english = [AAMockStringSource randomEnglish];
    NSString *email = [NSString stringWithFormat:@"%@@%@",english,emailSuffixs[random]];
    return email;
}

#pragma mark - 随机生成英文 费舍尔茨洗牌
+ (NSString *)randomEnglish{
    static NSString *english = @"abcdefghijklmnopqrstuvwxyz";
    
    NSUInteger numberOfCharacters = [AAMockRandom randomNumber:5 to:12];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [english getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
    
    // Perform a Fisher-Yates shuffle
    for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
        //arc4random()
        srand((unsigned)time(0));
        NSUInteger j = ((NSInteger)(arc4random_uniform(numberOfCharacters - i)) + i);
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }
    
    // Turn the result back into a string
    NSString *result = [NSString stringWithCharacters:characters length:numberOfCharacters];
    free(characters);
    return result;
}

#pragma mark - 身份证号生成
+ (NSString *)randomIDCard{
    NSArray<NSString *> *str1_6 = @[@"110101",@"150422",@"120101",@"130101",@"330101",   @"440101",@"440113",@"441201",@"340101",@"340201",@"450101",@"150101",   @"150401",@"150423",@"150602",@"150801",@"152501",@"152921"];
    NSArray<NSString *>  *str7_9=@[@"189",@"178",@"168",@"158"];
    NSString *str10 = [NSString stringWithFormat:@"%ld",[AAMockRandom randomNumber:0 to:9]];
    NSString *str10_12 = [NSString stringWithFormat:@"%ld",(long)[AAMockRandom randomNumber:0 to:12]];
    if([str10_12 integerValue]<10){
        str10_12= [NSString stringWithFormat:@"0%@",str10_12];
    }
    
    NSString *str12_14 = [NSString stringWithFormat:@"%ld",[AAMockRandom randomNumber:0 to:27]];
    if([str12_14 integerValue]<10){
        str12_14=[NSString stringWithFormat:@"0%@",str12_14];
    }
    
    NSString *str14_17 = [NSString stringWithFormat:@"%ld",[AAMockRandom randomNumber:0 to:999]];
    if([str14_17 integerValue]<10){
        str14_17=[NSString stringWithFormat:@"0%@",str14_17];
    }
    if([str14_17 integerValue]<100&&(NSInteger)str14_17>=10){
        str14_17=[NSString stringWithFormat:@"0%@",str14_17];;
    }
    
    NSInteger  m = [AAMockRandom randomNumber:0 to:str1_6.count-1];
    NSInteger  n = [AAMockRandom randomNumber:0 to:str7_9.count-1];
    NSString *tempStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",str1_6[m],str7_9[n],str10,str10_12,str12_14,str14_17];
    
    NSInteger tnum1 =  [[tempStr substringWithRange:NSMakeRange(0, 1)]  integerValue] * 7;
    NSInteger tnum2 = [[tempStr substringWithRange:NSMakeRange(1, 1)] integerValue] * 9;
    NSInteger tnum3 = [[tempStr substringWithRange:NSMakeRange(2, 1)] integerValue] * 10;
    NSInteger tnum4 = [[tempStr substringWithRange:NSMakeRange(3, 1)] integerValue] * 5;
    NSInteger tnum5 = [[tempStr substringWithRange:NSMakeRange(4, 1)] integerValue] * 8;
    NSInteger tnum6 = [[tempStr substringWithRange:NSMakeRange(5, 1)] integerValue] * 4;
    NSInteger tnum7 = [[tempStr substringWithRange:NSMakeRange(6, 1)] integerValue] * 2;
    NSInteger tnum8 = [[tempStr substringWithRange:NSMakeRange(7, 1)] integerValue];
    NSInteger tnum9 = [[tempStr substringWithRange:NSMakeRange(8, 1)] integerValue] * 6;
    NSInteger tnum10 = [[tempStr substringWithRange:NSMakeRange(9, 1)] integerValue] * 3;
    NSInteger tnum11 = [[tempStr substringWithRange:NSMakeRange(10, 1)] integerValue] * 7;
    NSInteger tnum12 =[[tempStr substringWithRange:NSMakeRange(11, 1)] integerValue] * 9;
    NSInteger tnum13 = [[tempStr substringWithRange:NSMakeRange(12, 1)] integerValue] * 10;
    NSInteger tnum14 = [[tempStr substringWithRange:NSMakeRange(13, 1)] integerValue] * 5;
    NSInteger tnum15 =[[tempStr substringWithRange:NSMakeRange(14, 1)] integerValue] * 8;
    NSInteger tnum16 = [[tempStr substringWithRange:NSMakeRange(15, 1)] integerValue] * 4;
//    NSInteger tnum17 =[[tempStr substringWithRange:NSMakeRange(15, 1)] integerValue] * 2;
    
    NSInteger tempInt = tnum1 + tnum2 + tnum3 + tnum4 + tnum5 + tnum6 + tnum7 + tnum8 + tnum9
    +tnum10 + tnum11 + tnum12 + tnum13 + tnum14 + tnum15 + tnum16 ;
    
    NSArray<NSString *> *mapArry =@[ @"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2"];
    NSString *parityBit = mapArry[tempInt%11];
    NSString *resultIDCard = [NSString stringWithFormat:@"%@%@",tempStr,parityBit];
    return resultIDCard;
}

#pragma mark - 随机生成银行卡号
+ (NSString *)randomBankCardNumber{
    return [AARandomCreditCardNumberGenerator generateMasterCardNumber];
}

#pragma mark - 随机生成学历
+ (NSString *)randomEducation{
    NSArray<NSString *> *educations = [AAMockTestDataManager findEducationList];
    return [AAMockRandom randomTextWithArray:educations];
}

#pragma mark - 随机生成职位
+ (NSString *)randomOffice{
    NSArray<NSString *> *offices= [AAMockTestDataManager findOfficeList];
    return [AAMockRandom randomTextWithArray:offices];
}

#pragma mark 邮政编码随机生成
+ (NSString *)randomZipCode{
    NSArray<NSString *> *zipcodes = [AAMockTestDataManager findZipCodeList];
    return [AAMockRandom randomTextWithArray:zipcodes];
}

#pragma mark 随机IP生成
+ (NSString *)randomIp{
    NSArray *range = [AAMockTestDataManager findIpRangeList];

    NSInteger index = [AAMockRandom randomNumber:0 to:range.count-1];
    NSString *num = range[index][0] ;
    NSString *num2 = range[index][1];
    
    NSInteger tmpNum = [num2 integerValue] - [num integerValue];
    NSInteger ran = [AAMockRandom randomNumber:0 to:tmpNum];
    
   NSString *ip =  [AADecimalTransformIp decimalToIp:[num integerValue] + ran];
    return ip;
}


@end
