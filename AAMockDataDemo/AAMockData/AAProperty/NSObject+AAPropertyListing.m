//
//  NSObject+AAPropertyListing.m
//  AAKitDemo
//
//  Created by shiyuan on 16/12/8.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import "NSObject+AAPropertyListing.h"
#import <objc/runtime.h>
#import <objc/message.h>

typedef NS_ENUM(NSInteger, PropertiesType) {
    PropertiesTypeValue = 0,//属性和值
    PropertiesTypeType = 1//属性和属性类型
};

@implementation NSObject (AAPropertyListing)

#pragma mark 获取对象的所有属性，不包括属性值
- (NSArray *)aa_getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

#pragma mark - 获取对象的所有属性 以及属性值
- (NSDictionary *)aa_propertiesValue
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    [self aa_objRecursion:props obj:self type:PropertiesTypeValue];
    return props;
}

#pragma mark - 获取对象的所有属性 以及属性类型
- (NSDictionary *)aa_propertiesType{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    [self aa_objRecursion:props obj:self type:PropertiesTypeType];
    return props;
}

- (void)aa_objRecursion:(NSMutableDictionary *)props obj:(NSObject *)obj type:(PropertiesType)propertiesType{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    
    NSString *objType = @"";
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        //        const char* char_attr = property_getAttributes(property);
        
        NSString *getPropertyNameString = [NSString stringWithCString:property_getAttributes(properties[i]) encoding:NSUTF8StringEncoding];
        NSString *typeTmp = [getPropertyNameString componentsSeparatedByString:@","][0] ;
        NSString *type = [typeTmp substringWithRange:NSMakeRange(0, 2)];
        if ([type isEqualToString:@"T@"]) {
            objType = [getPropertyNameString substringWithRange:NSMakeRange(3, [getPropertyNameString rangeOfString:@","].location-4)];
            const char  *rawPropertyType = [objType UTF8String];
            id currentClass = objc_getClass(rawPropertyType);
            
//            NSLog(@"objType:%@",objType);
            NSBundle *mainB = [NSBundle bundleForClass:[currentClass class]];//判断类是否在Bundle里，如果是，则不为系统类
            if (mainB == [NSBundle mainBundle]) {//自定义类
                id currentClassObj = [[NSClassFromString(objType) alloc] init];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [props setObject:dic forKey:[NSString stringWithFormat:@"%@_%@",[NSString stringWithUTF8String:char_f],objType]];
                [self aa_objRecursion:dic obj:currentClassObj type:propertiesType];
                
            }else{//系统类
                
            }
        }else if([type isEqualToString:@"Tq"]){//q表示NSInterget
            objType = @"NSInteger";
        }else if([type isEqualToString:@"TB"]){//b表示枚举
            objType = @"NS_ENUM";
        }else{
        }
        
        NSString *propertyName = [NSString stringWithUTF8String:char_f];

        id propertyValue = [obj valueForKey:(NSString *)propertyName];
        if(type==PropertiesTypeValue){
            if(propertyValue){
                [props setObject:propertyValue forKey:propertyName];
            }else{
                [props setObject:@"" forKey:propertyName];
            }
        }else{
            [props setObject:objType forKey:propertyName];
        }
    }
    free(properties);
    
}

#pragma mark - 获取对象所有方法
-(void)aa_printMothList
{
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++)
    {
        Method temp_f = mothList_f[i];
        IMP imp_f = method_getImplementation(temp_f);
        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,[NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}

+ (BOOL) aa_getVariableWithClass:(Class) myClass varName:(NSString *)name{
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
//        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        keyName = [keyName substringWithRange:NSMakeRange(1, keyName.length-1)];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

+ (id)invokeMethod:(Class)clazz withName:(NSString *)name
{
    id result = nil;
    SEL sel = NSSelectorFromString(name);
    IMP imp = [clazz methodForSelector:sel];
    result = imp(clazz, sel);
    return result;
}

+ (id)invokeMethod:(Class)clazz withName:(NSString *)name withParam:(id)param
{
    id  result = nil;
    SEL sel = NSSelectorFromString(name);
    IMP imp = [clazz methodForSelector:sel];
    
    //TODO:使用XCode6.X的要特别注意了，需要先到项目的构建设置里面把Apple LLVM 6.0 - Preprocessing 的Enable Strict Checking of objc_msgSend Calls 选项设置为NO，否则result = imp(clazz, sel);会报错的！！
    result = imp(clazz, sel, param);
    return result;
}

@end
