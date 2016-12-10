//
//  TestModel.h
//  AAKitDemo
//
//  Created by shiyuan on 16/12/8.
//  Copyright © 2016年 shiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TestModelData;
@interface TestModel : NSObject
@property (nonatomic, copy) NSString *phone;/**<手机号 */

@property (nonatomic, assign) NSInteger age;/**<产妇信息 ID */

@property (nonatomic, strong) NSData *notes_id;/**<是否填过调查问券（0 没填） */

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *member_id;/**<会员id */

@property (nonatomic, copy) NSString *order_state;/**<总订单状态（0 没有总订单，1 正常，2 取消，3 完成） */

@property (nonatomic, copy) NSString *pay_state;/**<预订单支付状态（0 没有预订单，1 未支付，2 支付，3 取消） */

@property (nonatomic, copy) NSString *name;/**<产妇姓名 */

@property (nonatomic, copy) NSString *package_name;/**<套餐名字 */

@property (nonatomic, copy) NSString *group_name;/**<用户标签名称 */

@property (nonatomic, copy) NSString *create_time;/**<登记时间（时间戳/秒） */

@property (nonatomic, copy) NSString *continue_state;/**<是否为续住单（1 续住，2 不续住） */

@property (nonatomic,strong) TestModelData *data;
@end

@interface TestModelData : NSObject
@property (nonatomic, copy) NSString *dataPhone;
@property (nonatomic, copy) NSString *dataAddress;
@property (nonatomic, copy) NSString *dataAge;
@end
