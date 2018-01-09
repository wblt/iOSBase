//
//  SYCacheManager.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/30.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import "SYCacheManager.h"
// 类型定义
static NSString *userId = nil;
// 便于单例销毁控制
static SYCacheManager *sharedManager;
static dispatch_once_t onceToken;
static NSString *const dataName = @"SYFMDB.db";
@interface SYCacheManager ()
@property (nonatomic, strong) NSString *dataPath; // 数据库文件目录
// LKDBHelper
@property (nonatomic, strong) LKDBHelper *dataHelper; // 数据库
@end
@implementation SYCacheManager
#pragma mark - 实例化
// 初始化数据库类型
+ (void)initializeWithType:(NSString *)userType
{
    userId = userType;
}
// 销毁单例
+ (void)releaseCache
{
    sharedManager = nil;
    onceToken=0l;
}
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 区分每个类型数据库
        NSString *userType = (userId ? userId : @"");
        NSString *userDBName = [NSString stringWithFormat:@"%@%@", userType, dataName];
        self.dataHelper = [[LKDBHelper alloc] initWithDBName:userDBName];
    }
    return self;
}

- (void)dealloc
{
    self.dataPath = nil;
    self.dataHelper = nil;
}

/// 单例
+ (SYCacheManager *)shareCache
{
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        assert(sharedManager != nil);
    });
    return sharedManager;
}

#pragma mark - 存储路径

- (NSString *)dataPath
{
    if (_dataPath == nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        _dataPath = [documentDirectory stringByAppendingPathComponent:dataName];
        NSLog(@"_dataPath = %@", _dataPath);
    }
    return _dataPath;
}



#pragma mark - LKDB操作
- (LKDBHelper *)lkdbManager
{
    return self.dataHelper;
}

#pragma mark 删除表
- (void)deleteAllTableModel
{
    [self.dataHelper dropAllTable];
}

- (BOOL)deleteTableWithModel:(Class)class
{
    BOOL isResult = [self.dataHelper dropTableWithClass:class];
    NSLog(@"deleteTableWithModel = %@", (isResult ? @"success" : @"error"));
    return isResult;
}

#pragma mark 插入数据

- (BOOL)saveModel:(id)model
{
    BOOL isResult = NO;

    if ([self.dataHelper isExistsModel:model])
    {
        // 已存在时，先删除，且删除成功再保存
        if ([self deleteModel:model])
        {
            isResult = [self.dataHelper insertWhenNotExists:model];
        }
    }
    else
    {
        // 不存在时，直接保存
        isResult = [self.dataHelper insertWhenNotExists:model];
    }
    
    NSLog(@"saveModel = %@", (isResult ? @"success" : @"error"));
    return isResult;
}

- (void)saveModel:(id)model callback:(void (^)(BOOL result))callback
{
    if ([self.dataHelper isExistsModel:model])
    {
        // 已存在时，先删除，且删除成功再保存
        if ([self deleteModel:model])
        {
            [self.dataHelper insertToDB:model callback:^(BOOL result) {
                NSLog(@"saveModel = %@", (result ? @"success" : @"error"));
                if (callback)
                {
                    callback(result);
                }
            }];
        }
    }
    else
    {
        // 不存在时，直接保存
        [self.dataHelper insertToDB:model callback:^(BOOL result) {
            NSLog(@"saveModel = %@", (result ? @"success" : @"error"));
            if (callback)
            {
                callback(result);
            }
        }];
    }
}

#pragma mark 修改数据

- (BOOL)updateModel:(id)model
{
    BOOL isResult = [self.dataHelper updateToDB:model where:nil];
    NSLog(@"updateModel = %@", (isResult ? @"success" : @"error"));
    return isResult;
}

- (void)updateModel:(id)model callback:(void (^)(BOOL result))callback
{
    [self.dataHelper updateToDB:model where:nil callback:^(BOOL result) {
        NSLog(@"updateModel = %@", (result ? @"success" : @"error"));
        if (callback)
        {
            callback(result);
        }
    }];
}

- (BOOL)updateModel:(Class)class value:(NSString *)value where:(id)where
{
    BOOL isResult = [self.dataHelper updateToDB:class set:value where:where];
    NSLog(@"updateModel = %@", (isResult ? @"success" : @"error"));
    return isResult;
}

#pragma mark 删除数据

- (BOOL)deleteModel:(id)model
{
    [self.dataHelper deleteToDB:model callback:^(BOOL result) {
        
    }];
    BOOL isResult = [self.dataHelper deleteToDB:model];
    NSLog(@"deleteModel = %@", (isResult ? @"success" : @"error"));
    return isResult;
}

- (void)deleteModel:(id)model callback:(void (^)(BOOL result))callback
{
    [self.dataHelper deleteToDB:model callback:^(BOOL result) {
        NSLog(@"deleteModel = %@", (result ? @"success" : @"error"));
        if (callback)
        {
            callback(result);
        }
    }];
}

- (BOOL)deleteModel:(Class)class where:(id)where
{
    BOOL isResult = [self.dataHelper deleteWithClass:class where:where];
    NSLog(@"deleteModel = %@", (isResult ? @"success" : @"error"));
    return isResult;
}

- (void)deleteModel:(Class)class where:(id)where callback:(void (^)(BOOL result))callback
{
    [self.dataHelper deleteWithClass:class where:where callback:^(BOOL result) {
        NSLog(@"deleteModel = %@", (result ? @"success" : @"error"));
        if (callback)
        {
            callback(result);
        }
    }];
}

- (BOOL)deleteAllModel:(Class)class
{
//    [LKDBHelper clearTableData:class];
    BOOL isResult = [self.dataHelper deleteWithClass:class where:nil];
    NSLog(@"deleteModel = %@", (isResult ? @"success" : @"error"));
    return isResult;
}

#pragma mark 查找数据

- (NSArray *)readModel:(Class)class where:(id)where
{
    NSArray *array = [self readModel:class column:nil where:where orderBy:nil offset:0 count:0];
    return array;
}

- (void)readModel:(Class)class where:(id)where callback:(void (^)(NSMutableArray *array))callback
{
    [self readModel:class where:where orderBy:nil offset:0 count:0 callback:callback];
    
}

- (NSArray *)readModel:(Class)class column:(id)column where:(id)where orderBy:(NSString *)orderBy offset:(NSInteger)offset count:(NSInteger)count
{
    // 查找字段：@"字段1,字段2"
    // 查找条件：
    //  根据 and 条件 查询所有数据 NSString *conditions = @"age = 23 and name = '张三1'";
    //  根据 字典条件，查询所有数据 NSDictionary *conditions1 = @{@"age" : @23, @"name" : @"张三1"};
    //  根据 or 条件，查询所有数据 NSString *conditions2 = @"age = 23 or ID = 5";
    //  根据 in 条件，查询所有数据 NSString *conditions3 = @"age in (23, 24)";
    //  根据 字典 in 条件，查询所有数据 NSDictionary *conditions4 = @{@"age" : @[@23, @24]};
    //  查询符合条件的数据有多少条 NSString *conditions5 = @"age = 23 and name = '张三1'";
    
    // 排序查询：升序 "排序字段 asc"; 降序 "排序字段 desc"
    
    // 偏移量：10表示从第11个读取，23表示从第24个读取
    
    // 读取数量：10表示从数据库读10个
    NSArray *array = [self.dataHelper search:class column:column where:where orderBy:orderBy offset:offset count:count];
    return array;
}

- (void)readModel:(Class)class where:(id)where orderBy:(NSString *)orderBy offset:(NSInteger)offset count:(NSInteger)count callback:(void (^)(NSMutableArray *array))callback
{
    [self.dataHelper search:class where:where orderBy:orderBy offset:offset count:count callback:^(NSMutableArray *array) {
        if (callback)
        {
            callback(array);
        }
    }];
}

@end
