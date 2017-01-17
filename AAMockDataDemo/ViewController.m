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
#import "AAMockInterget.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self mockModelData];
    [self testArr];
}

- (void)mockModelData{
    TestModel *model = [[TestModel alloc] init];
    [AAMockData mockModel:model];
    
//    model.name = [AAMockStringSource randomName];
    NSLog(@"测试数据：%@",model.mj_keyValues);
}

- (void)testArr {
    int i  = 0;
    while (i < 50) {
        i++;
        TestModel *model = [[TestModel alloc] init];
        [AAMockData mockModel:model];
        model.name  = [AAMockStringSource randomCotentWithLength:0];
        model.hasMore = [AAMockInterget returnYesOrNO];
        NSLog(@"测试数据：%@",model.TestModelData);
    }
}


@end
