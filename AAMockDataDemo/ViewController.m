//
//  ViewController.m
//  AAMockDataDemo
//
//  Created by shiyuan on 16/12/10.
//  Copyright © 2016年 sy. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "AAMockData.h"
#import "TestModel.h"
#import "AAMockStringSource.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mockModelData];
}

- (void)mockModelData{
    TestModel *model = [[TestModel alloc] init];
    [AAMockData mockModel:model];
    
//    model.name = [AAMockStringSource randomName];
    NSLog(@"测试数据：%@",model.mj_keyValues);
}


@end
