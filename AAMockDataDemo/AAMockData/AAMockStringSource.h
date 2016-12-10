//
//  AAMockStringSource.h
//  AAKitDemo
//
//  Created by shiyuan on 16/12/7.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AAMockConstant.h"

typedef NS_ENUM(NSInteger, AddresType) {
    AddresTypeALL = 0,//全部
    AddresTypeProvince = 1,//省份
    AddresTypeCity = 2,//城市
    AddresTypeArea = 3//区域
};

@interface AAMockStringSource : NSObject

+ (NSString *)randomText:(RandomContentType)type;/**<根据类型生成随机文本*/

+ (NSString *)randomTitle;/**<随机生成标题*/

+ (NSString *)randomName;/**<随机生成中文姓名*/

+ (NSString *)randomEnglishName;/**<随机生成英文名称*/

+ (NSString *)randomContentWithRandomMax;
+ (NSString *)randomContentWithRandomMax:(NSInteger)max;/**<根据最大范围生成文本内容*/

+ (NSString *)randomCotentWithLength:(NSInteger)len;/**<根据文本长度生成随机文本*/

+ (NSString *)randomPhone;/**<随机生成电话号码*/

+ (NSString *)randomAddress;
+ (NSString *)randomAddress:(AddresType)type;/**<根据类型随机生成数据*/

+(NSString *)randomEmail;/**<随机生成Email地址*/

+ (NSString *)randomIDCard;/**<随机生成身份证号*/

+ (NSString *)randomBankCardNumber;/**<随机生成银行卡号、信用卡号*/

+ (NSString *)randomEducation;/**<随机生成学历*/

+ (NSString *)randomOffice;/**<随机生成职位*/

+ (NSString *)randomZipCode;/**<邮政编码随机生成*/

+ (NSString *)randomIp;/**<随机ip生成*/
@end
