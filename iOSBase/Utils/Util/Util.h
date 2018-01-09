//
//  Util.h
//  TheMall
//
//  Created by quange on 15/6/5.
//  Copyright (c) 2015年 KingHan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Util : NSObject

/**
 *  将obj转变成字符串
 *  @return 字符串
 */
+(NSString *)objectToString:(id)obj;

/**
 @brief 将NSInteger类型转换成NSNumber
 @param intSrc 要转换的NSInteger
 @return 转换后的NSNumber对象
 */
+ (NSNumber *)integerToNumber:(NSInteger)intSrc;

/**
 @brief 将NSInteger类型转换成NSNumber
 @param intSrc 要转换的double
 @return 转换后的NSNumber对象
 */
+ (NSNumber *)doubleToNumber:(double)intSrc;

/*
 @brief 根据颜色来生成图片
 @param color要生成图片的颜色
 */

/**
 *  将字符串进行decode解码
 *
 *  @return 字符串
 */
+ (NSString *)URLDecodeString:(NSString *)src;

/**
 *  将字符串进行encode编码
 *
 *  @return 字符串
 */
+ (NSString *)URLEncodeString:(NSString *)src;


+(UIColor *) hexStringToColor: (NSString *) stringToConvert ;

+(NSMutableAttributedString*)LabelAttributedStrin:(NSString*)originStr HeadIndent:(CGFloat)headindent lineHeightMultiple:(CGFloat)lineheight ;

+(CGSize)sizeWithString:(NSString *)string CGsize:(CGSize)size font:(UIFont *)font;

/**
 @brief 获取指定沙河的文件
 @param fileName 文件名称
 @param fileType 文件类型
 @return 文件的Data
 */
+ (NSData *)getBundleFile:(NSString *)fileName fileType:(NSString *)fileType;

/**
 *  将json转变成字典
 *
 *
 *
 */
+ (id)jsonToDictionary:(NSString *)jsonName;

/**
 *  将字典转变成json字符串
 *
 *  @param object 需要传入的字典
 *
 *  @return json字符串
 */
+ (NSString *)dictToJsonString:(id)object;

/**
 @brief 根据文件路径来创建文件夹
 @param path 要创建文件夹的路径
 @return 返回path
 */
+ (NSString *)createFileDirectory:(NSString *)path;

/**
 @brief 根据文件路径来删除文件夹
 @param path 要删除文件夹的路径
 @return 是否删除成功
 */
+ (BOOL)deleteFileDirectory:(NSString *)path;


/**
 @brief 根据文件路径来创建文件
 @param path 要创建文件的路径
 @param data 需要存储的数据
 @return 是否创建成功
 */
+ (BOOL)createFile:(NSString *)path withData:(NSData *)data;

/**
 @brief 根据文件路径来删除文件
 @param path 要删除文件的路径
 @return 是否删除成功
 */
+ (BOOL)deleteFile:(NSString *)path;


/**
 @brief 归档需要归档的数据到指定路径
 @param data 要归档的数据
 @param path 文件路径
 @return 归档数据是否成功
 */
+ (BOOL)saveObjectToArchiver:(id)data withPath:(NSString *)path;

/**
 @brief 读取归档的文件
 @param path 文件路径
 @return 读取的文件内容，如果文件不存在则返回空
 */
+ (id)readObjectFormArchierWithPath:(NSString *)path;

/**
 *  // 计算目录下面所有文件的大小
 *
 *  @param directory 文件目录
 *
 *  @return 该目录下文件的大小
 */
+ (long long)countDirectorySize:(NSString *)directory;


/**
 获取本地文件 MIMEType

 @param path 文件路径
 */
+ (NSString *)getMIMETypeAtFilePath:(NSString *)path;


/**
 获取当前时间戳
 
 @return 返回当前时间戳字符串
 */
+ (NSString *)timeToTurnTheTimestamp;

/**
 时间戳转时间格式
 
 @param timestamp 时间戳
 @param formatter 格式 @"yyyy-MM-dd HH:mm:ss"
 @return 返回字符串
 */
+ (NSString *)timestampToString:(NSString *)timestamp formatterString:(NSString *)formatter;

/**
 字符串设置特定字符串字体及颜色

 @param allStr 完整字符串
 @param specifiStr 指定字符串
 @param color 指定颜色
 @param font 制定字体
 @return 返回AttributedString 字符串
 */
+ (NSMutableAttributedString *)setAllText:(NSString *)allStr andSpcifiStr:(NSString *)specifiStr withColor:(UIColor *)color specifiStrFont:(UIFont *)font;


/**
 获取html字符串中的所有图片

 @param webString html字符串
 @return 图片数组
 */
+ (NSArray *) getImageurlFromHtml:(NSString *) webString;


/**
 将图片修改为指定大小

 @param image 原图片
 @param size 指定大小
 @return 返回修改后的图片
 */
+(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;


+ (NSString *)UUIDString;

// app版本
+ (NSString *)app_Version;

//设备名称
+ (NSString *)deviceName;

//手机系统版本
+ (NSString *)phoneVersion;

//手机型号
+ (NSString *)phoneModel;

//地方型号  （国际化区域名称）
+ (NSString *)localPhoneModel;

//获取当前设备语言
+ (NSString *)appLanguages;

+ (NSString *)countryCode;

// 判断是否是数字
+ (BOOL)isNumber:(NSString *)str;

// 获取当前的时间
+ (NSString *)getCurrentTime;

// 判断手机号码
+ (BOOL)valiMobile:(NSString *)mobile;
@end
