//
//  SPUtil.h
//  Keepcaring
//
//  Created by wb on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#define k_app_login @"app_login"      // 判断是否登录
#define k_app_userNumber @"app_userNumber"
#define k_app_passNumber @"app_passNumber"
#define k_app_rongCloud_token @"app_rongCloud_token"//融云Token
@interface SPUtil : NSObject

// 设置
+ (void)setInteger:(NSInteger)value forKey:(NSString *_Nullable)defaultName;

+ (void)setFloat:(float)value forKey:(NSString *_Nullable)defaultName;

+ (void)setDouble:(double)value forKey:(NSString *_Nullable)defaultName;

+ (void)setBool:(BOOL)value forKey:(NSString *_Nullable)defaultName;

+ (void)setURL:(nullable NSURL *)url forKey:(NSString *_Nullable)defaultName;

+ (void)setObject:(nullable id)value forKey:(NSString *_Nullable)defaultName;

// 获取
+ (NSInteger)integerForKey:(NSString *_Nullable)defaultName;

+ (float)floatForKey:(NSString *_Nullable)defaultName;

+ (double)doubleForKey:(NSString *_Nullable)defaultName;

+ (BOOL)boolForKey:(NSString *_Nullable)defaultName;

+ (nullable NSURL *)URLForKey:(NSString *_Nullable)defaultName;

+ (id _Nullable )objectForKey:(NSString *_Nullable)defaultName;

+ (void)clear;

@end
