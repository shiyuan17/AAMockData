# AAMockData
##ios 有意义测试数据模拟
AAMockData是一个模拟数据生成器，旨在帮助前端攻城师独立于后端进行开发，帮助编写单元测试，方便模拟数据测试。提供一键model生成模拟测试数据，并可单独指定生成方式。

##using(使用)
1.引入文件：**#import "AAMockData.h"** 主要是用来一键model生成测试数据   

额外文件，安需引入：
**AAMockStringSource.h**
    包含各类字符串随机生成方法(随机文本、有意义标题、姓名、英文名、电话号码、Email、身份证、银行卡、邮政编码、随机ip)   
***AAMockInterget.h**
    包含年龄及随机编号随机生成   
**AAMockDateSource.h**
    包含日期及时间戳随机生成   
    
2.公开的方法都为static，类名调用即可，示例如下：

    - (void)mockModelData{
        //要生成模拟数据的实体
        TestModel *model = [[TestModel alloc] init];
        
        //调用mockModel即可自动匹配生成模拟数据
        [AAMockData mockModel:model];
        
        //也可以单独调用具体的生成方法，生成有意义的测试数据
        //model.name = [AAMockStringSource randomName];
    
        //输出生成好带模拟数据的实体
        NSLog(@"测试数据：%@",model.mj_keyValues);
    }

3.AAMockData使用过程中有任何bug或者建议请联系：QQ:[1213423761](http://wpa.qq.com/msgrd?v=3&uin=1213423761&site=qq&menu=yes),亦或邮件：1213423761@qq.com


