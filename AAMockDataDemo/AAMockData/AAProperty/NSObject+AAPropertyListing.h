//
//  NSObject+AAPropertyListing.h
//  AAKitDemo
//
//  Created by shiyuan on 16/12/8.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AAPropertyListing)
- (NSArray *)aa_getAllProperties;/**<获取对象的所有属性，不包括属性值*/
- (NSDictionary *)aa_propertiesValue;/**<获取对象的所有属性 以及属性值*/
- (NSDictionary *)aa_propertiesType;/**<获取对象的所有属性 以及属性类型*/
-(void)aa_printMothList;/**<获取对象所有方法*/
+ (BOOL) aa_getVariableWithClass:(Class) myClass varName:(NSString *)name;/**<判断对象是否存在某个属性*/

+ (id)invokeMethod:(Class)clazz withName:(NSString *)name;/**<动态调用类方法*/
+ (id)invokeMethod:(Class)clazz withName:(NSString *)name withParam:(id)param;/**<动态调用类方法，并传递参数*/
@end
