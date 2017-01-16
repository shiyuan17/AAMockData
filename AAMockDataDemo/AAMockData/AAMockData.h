//
//  AAMockData.h
//  AAKitDemo
//
//  Created by shiyuan on 16/12/7.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

/**
 使用说明详细见demo github
 https://github.com/shiyuan17/AAMockData
 
 MJExtension使用指导（转）
 http://www.jianshu.com/p/93c242452b9b
 
 1.实现这个方法的目的：告诉MJExtension框架statuses和ads数组里面装的是什么模型
 + (NSDictionary *)objectClassInArray{
 return @{
 @"statuses" : @"Status",
 @"ads" : @"Ad"
 };
 }
 
 2.模型中的属性名和字典中的key不相同(或者需要多级映射)
 + (NSDictionary *)replacedKeyFromPropertyName{
 return @{
 @"ID" : @"id",
 @"desc" : @"desciption",
 @"oldName" : @"name.oldName",
 @"nowName" : @"name.newName",
 @"nameChangedTime" : @"name.info.nameChangedTime",
 @"bag" : @"other.bag"
 };
 }
 
 yymodel
 http://www.jianshu.com/p/86b39f2bdd26
 
1、返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
 + (NSDictionary *)modelContainerPropertyGenericClass {
 return @{@"shadows" : [Shadow class],
 @"borders" : Border.class,
 @"attachments" : @"Attachment" };
 }
 @end
 
2、 模型中的属性名和字典中的key不相同(或者需要多级映射)
 + (NSDictionary *)modelCustomPropertyMapper {
 return @{@"name" : @"n",
 @"page" : @"p",
 @"desc" : @"ext.desc",
 @"bookID" : @[@"id",@"ID",@"book_id"]};
 }
 */

#import <Foundation/Foundation.h>
#import "AAMockStringSource.h"
#import "AAMockInterget.h"
#import "AAMockDateSource.h"//额外三个类，一起引用，测试数据方便删除。

@interface AAMockData : NSObject
+ (void)mockModel:(NSObject *)model;
@end
