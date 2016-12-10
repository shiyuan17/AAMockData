//
//  AAMockData.m
//  AAKitDemo
//
//  Created by shiyuan on 16/12/7.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import "AAMockData.h"
#import "NSObject+AAPropertyListing.h"
#import "AAMockStringSource.h"
#import "AAMockInterget.h"
#import "AAMockDateSource.h"
@implementation AAMockData
+ (void)mockModel:(NSObject *)model{

    NSArray *arr = @[
                     @[@"title"],
                     @[@"phone",@"mobile",@"tel"],
                     @[@"member"],
                     @[@"age"],
                     @[@"date",@"time",@"timestamp"],
                     @[@"email"],
                     @[@"idcard"],
                     @[@"bankcard",@"credit"],
                     @[@"education"],
                     @[@"office"],
                     @[@"ip"],
                     @[@"province",@"city",@"area",@"address"],
                     @[@"text",@"des",@"description",@"con",@"content"],
                     @[@"name"]
                     ];
    NSDictionary *dic = [model aa_propertiesType];
    for (NSString *key in dic) {
        NSLog(@"key: %@ value: %@", key, dic[key]);
        if([dic[key] isKindOfClass:[NSDictionary class]]){
            //获取引用对象的属性名及对象名
            NSString *attr = [key substringToIndex:[key rangeOfString:@"_"].location];
            NSString *attrModel = [key substringFromIndex:[key rangeOfString:@"_"].location+1];
            
            //初始化对象
            Class attrClass = NSClassFromString(attrModel);
            id attrClassInit = [[attrClass alloc] init];
            [model setValue:attrClassInit forKey:attr];
            
            //设置该对象的值
            NSDictionary *ddic = dic[key];
            for (NSString *dKey in ddic) {
//                NSString *setKey = [NSString stringWithFormat:@"%@.%@",attr,dKey];
                BOOL isSetValue = [AAMockData cycleMatch:arr key:dKey model:attrClassInit];
//                 [model setValue:[AAMockData executeWithRandomType:RandomContentTypeTitle] forKeyPath:setKey];
            }
        }else if ([dic[key] isEqualToString:@"NSString"] || [dic[key] isEqualToString:@"NSInteger"] ) {
            BOOL isSetValue = NO;
            isSetValue = [AAMockData cycleMatch:arr key:key model:model];
            if(!isSetValue){
                Class class = [model class];
                if([class aa_getVariableWithClass:class varName:key]){//判断类是否包含某个属性
                     [model setValue:[AAMockData executeWithRandomType:RandomContentTypeTitle] forKey:key];
                }else{
                    
                }
            }
            
        }else if([dic[key] isEqualToString:@"NSDate"]){
            [model setValue:[AAMockDateSource randomDate:RandomDateTypeDefault] forKey:key];
        }else{
            //其它数据类型
        }
        
    }
    
}

#pragma mark 循环匹配
+ (BOOL)cycleMatch:(NSArray *)arr key:(NSString *)key model:(NSObject *)model{
    BOOL isSetValue = NO;
    for (int i=0; i<arr.count; i++) {//
        NSArray *tmp = arr[i];
        for (int j=0; j<tmp.count; j++) {
            //转小写判断是否存在，存在则自动调用对应的随机方法
            NSString *lowerTmpStr = [tmp[j] lowercaseString];
            NSString *lowerKeyStr = [key lowercaseString];
            if( [lowerKeyStr  rangeOfString:lowerTmpStr].location != NSNotFound){
                isSetValue = YES;
                NSString *text =[AAMockData executeWithRandomType:[AAMockData arrayIndexToRandomType:i]];//fun[i]
                [model setValue:text forKey:key];
                break;
            }
        }
        if(isSetValue){
            break;
        }else{
           [model setValue:[AAMockData executeWithRandomType:RandomContentTypeTitle] forKey:key];
        }
    }
    return isSetValue;
}

#pragma mark 数组arr i转枚举
+ (RandomContentType)arrayIndexToRandomType:(NSInteger)index{
    RandomContentType type;
    switch (index) {
        case 0:
            type = RandomContentTypeTitle;
            break;
        case 1:
            type = RandomContentTypePhone;
            break;
        case 2:
            type = RandomContentTypeNumber;
            break;
        case 3:
            type = RandomContentTypeAge;
            break;
        case 4:
            type = RandomContentTypeTimestamp;
            break;
        case 5:
            type = RandomContentTypeEmail;
            break;
        case 6:
            type = RandomContentTypeIDCard;
            break;
        case 7:
            type = RandomContentTypeBankCardNumber;
            break;
        case 8:
            type = RandomContentTypeEducation;
            break;
        case 9:
            type = RandomContentTypeOffice;
            break;
        case 10:
            type = RandomContentTypeIp;
            break;
        case 11:
            type = RandomContentTypeAddress;
            break;
        case 12:
            type = RandomContentTypeMaxContent;
            break;
        case 13:
            type = RandomContentTypeName;
            break;
        default:
            type = RandomContentTypeTitle;
            break;
    }
    return type;
}

#pragma mark - 根据随机类型执行方法
+ (NSString *)executeWithRandomType:(RandomContentType)type{
    NSString *text = @"";

    switch (type) {
        case RandomContentTypeTitle:
        {
            text = [AAMockStringSource randomTitle];
        }
            break;
        case RandomContentTypePhone:
        {
            text = [AAMockStringSource randomPhone];
        }
            break;
        case RandomContentTypeNumber:
        {
            text = [NSString stringWithFormat:@"%ld",(long)[AAMockInterget randomNumber]];
        }
            break;
        case RandomContentTypeAge:
        {
            NSInteger age =  [AAMockInterget randomAge] ;
            text = [NSString stringWithFormat:@"%ld",(long)age];
        }
            break;
        case RandomContentTypeTimestamp:
        {
            text = [AAMockDateSource randomDateTimestamp];
        }
            break;
        case RandomContentTypeEmail:
        {
            text = [AAMockStringSource randomEmail];
        }
            break;
        case RandomContentTypeIDCard:
        {
            text = [AAMockStringSource randomIDCard];
        }
            break;
        case RandomContentTypeBankCardNumber:
        {
            text = [AAMockStringSource randomName];
        }
            break;
        case RandomContentTypeEducation:
        {
            text = [AAMockStringSource randomEducation];
        }
            break;
        case RandomContentTypeOffice:
        {
            text = [AAMockStringSource randomOffice];
        }
            break;
        case RandomContentTypeIp:
        {
            text = [AAMockStringSource randomIp];
        }
            break;
        case RandomContentTypeAddress:
        {
            text = [AAMockStringSource randomAddress];
        }
            break;
        case RandomContentTypeMaxContent:
        {
            text = [AAMockStringSource randomContentWithRandomMax:150];
        }
            break;
        case RandomContentTypeName:
        {
            text = [AAMockStringSource randomName];
        }
            break;
        case RandomContentTypeZipCode:
        {
            text = [AAMockStringSource randomZipCode];
        }
            break;
        case RandomContentTypeEnglishName:
        {
            text = [AAMockStringSource randomEnglishName];
        }
            break;
        case RandomContentTypeEnglis:
        {
            text = [AAMockStringSource randomEnglishName];
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


+ (void)selRandomFun{
    
}

+ (void)mockWithNumber:(NSNumber *)text{
    
}

+ (void)randomString{
    
}
@end
