//
//  UserManager.m
//  Keepcaring
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BeanManager.h"

static  BeanManager *instance = nil;

@implementation BeanManager

/**
 *  创建单例对象
 *
 *  @return 返回创建的单例对象
 */
+ (BeanManager *)shareInstace {
    
    static dispatch_once_t onecToken = 0;
    
    dispatch_once(&onecToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (instance == nil) {
        instance = [super allocWithZone:zone];
    }
    
    return instance;
    
}

// 解档
- (id) getBeanfromPath:(NSString *) path {
    id userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return userModel;
}

// 归档
- (void)setBean:(id ) model path:(NSString *)filePath {
    //将账号归档
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
}

// 删除
- (void)deleteFromPath:(NSString *)path {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if ([defaultManager isDeletableFileAtPath:path]) {
        [defaultManager removeItemAtPath:path error:&error];
    }
    if (error != nil) {
        DLog(@"%@",error);
    }
}



@end
