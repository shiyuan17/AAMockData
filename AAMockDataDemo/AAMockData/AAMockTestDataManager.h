//
//  AAMockTestDataManager.h
//  AAKitDemo
//
//  Created by shiyuan on 16/12/8.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAMockTestDataManager : NSObject

+ (NSString *)findChineseCharacters;/**<查找字符集*/

+ (NSArray <NSString *> *)findEnglishNameList;/**<查找英文字*/

+ (NSArray <NSString *> *)findChineseName;/**<查找中文名*/

+ (NSArray <NSString *> *)findTitleList;/**<查找标题列表*/

+ (NSArray <NSString *> *)findOfficeList;/**<查找职位列表*/

+ (NSArray <NSString *> *)findEducationList;/**<查找学历列表*/

+ (NSArray <NSString *> *)findZipCodeList;/**<查找邮政编码列表*/

+ (NSArray *)findIpRangeList;/**<查找ip范围段列表*/
@end
