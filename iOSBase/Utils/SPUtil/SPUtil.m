//
//  SPUtil.m
//  Keepcaring
//
//  Created by wb on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SPUtil.h"


@implementation SPUtil

+ (void)setInteger:(NSInteger)value forKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:defaultName];
    [userDefaults synchronize];
}

+ (void)setFloat:(float)value forKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:value forKey:defaultName];
    [userDefaults synchronize];
}

+ (void)setDouble:(double)value forKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:value forKey:defaultName];
    [userDefaults synchronize];
}

+ (void)setBool:(BOOL)value forKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:defaultName];
    [userDefaults synchronize];
}

+ (void)setURL:(nullable NSURL *)url forKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setURL:url forKey:defaultName];
    [userDefaults synchronize];
}

+ (void)setObject:(nullable id)value forKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:defaultName];
    [userDefaults synchronize];
}

+ (void)clear {
    NSUserDefaults*userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary*dic =[userDefaults dictionaryRepresentation];
    for(id key in dic){
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

+ (NSInteger)integerForKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger i = [userDefaults integerForKey:defaultName];
    return i;
}

+ (float)floatForKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    float f = [userDefaults floatForKey:defaultName];
    return f;
}

+ (double)doubleForKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    double d = [userDefaults doubleForKey:defaultName];
    return d;

}

+ (BOOL)boolForKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL b = [userDefaults boolForKey:defaultName];
    return b;
}

+ (nullable NSURL *)URLForKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSURL *u = [userDefaults URLForKey:defaultName];
    return u;
    
}

+ (id _Nullable )objectForKey:(NSString *_Nullable)defaultName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id u = [userDefaults objectForKey:defaultName];
    return u;
}




@end
