//
//  Util.m
//  TheMall
//
//  Created by quange on 15/6/5.
//  Copyright (c) 2015年 KingHan. All rights reserved.
//

#import "Util.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Util

/**
 *  将obj转变成字符串
 *  @return 字符串
 */
+(NSString *)objectToString:(id)obj
{
    if([obj isKindOfClass:[NSNumber class]]) {
        
        return [NSString stringWithFormat:@"%@",obj];
        
    }else if ([obj isKindOfClass:[NSString class]]) {
        
        return obj;
    }else {
        
        return @"";
    }
}

/**
 @brief 将NSInteger类型转换成NSNumber
 @param intSrc 要转换的NSInteger
 @return 转换后的NSNumber对象
 */
+ (NSNumber *)integerToNumber:(NSInteger)intSrc
{
    return [NSNumber numberWithInteger:intSrc];
}

/**
 @brief 将NSInteger类型转换成NSNumber
 @param intSrc 要转换的double
 @return 转换后的NSNumber对象
 */
+ (NSNumber *)doubleToNumber:(double)intSrc
{
    return [NSNumber numberWithDouble:intSrc];
}


/**
 *  将字符串进行decode解码
 *
 *  @return 字符串
 */
+ (NSString *)URLDecodeString:(NSString *)src
{
    NSMutableString *outputStr = [NSMutableString stringWithString:src];
    
    NSString *result = [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return result;
}

/**
 *  将字符串进行encode编码
 *
 *  @return 字符串
 */
+ (NSString *)URLEncodeString:(NSString *)src
{
    NSMutableString *outputStr = [NSMutableString stringWithString:src];
    
    NSString *result = [outputStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return result;
}

+(UIColor *) hexStringToColor: (NSString *) stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
        return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f)                         alpha:1.0f];
}

/**
 *uilabel富文本originStr 文本 headindent首行缩进 默认0 不缩进 lineheight行间距 默认1.0 单倍行距
 */
+(NSMutableAttributedString*)LabelAttributedStrin:(NSString*)originStr HeadIndent:(CGFloat)headindent lineHeightMultiple:(CGFloat)lineheight {
    
    if(lineheight==0){
        lineheight=1.0;
    }
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString: originStr];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 2;//增加行高
    style.lineHeightMultiple = lineheight;//行间距是多少倍
    style.alignment = NSTextAlignmentLeft;//对齐方式
    style.firstLineHeadIndent = headindent;//首行头缩进
    style.paragraphSpacing = 5;//段落后面的间距
    style.paragraphSpacingBefore = 5;//段落之前的间距
    //    style.headIndent = 10;//缩进，相当于左padding
    //    style.tailIndent = -10;//尾部缩进相当于右padding
    
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, originStr.length)];
    
    
    return attributedStr;
}

/**
 *返回范围 文本  最大范围 字号
 */
+(CGSize)sizeWithString:(NSString *)string CGsize:(CGSize)size font:(UIFont *)font
{
    //限制最大的宽度和高度
    CGRect rect = [string boundingRectWithSize:size
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}


/**
 @brief 获取指定沙河的文件
 @param fileName 文件名称
 @param fileType 文件类型
 @return 文件的Data
 */
+ (NSData *)getBundleFile:(NSString *)fileName fileType:(NSString *)fileType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    NSData *tempData = [NSData dataWithContentsOfFile:path];
    return tempData;
}

/**
 *  将json转变成字典
 *
 */
+ (id)jsonToDictionary:(NSString *)jsonName
{
    NSData *jsonData = [Util getBundleFile:jsonName fileType:@"json"];
    NSError *err;
    id value = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        
        return nil;
        
    }else {
        
        return value;
    }
}

/**
 *  将字典转变成json字符串
 *
 *  @param object 需要传入的字典
 *
 *  @return json字符串
 */
+ (NSString *)dictToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        
        return nil;
        
    }else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        return jsonString;
    }
}

/**
 @brief 根据文件路径来创建文件夹
 @param path 要创建文件夹的路径
 @return 是否创建成功
 */
+ (NSString *)createFileDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path isDirectory:nil]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

/**
 @brief 根据文件路径来删除文件夹
 @param path 要删除文件夹的路径
 @return 是否删除成功
 */
+ (BOOL)deleteFileDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        
        BOOL isSucuss = [fileManager removeItemAtPath:path error:nil];
        
        if (isSucuss) {
            return YES;
        }
    }
    
    return NO;
}

/**
 @brief 根据文件路径来创建文件
 @param path 要创建文件的路径
 @param data 需要存储的数据
 @return 是否创建成功
 */
+ (BOOL)createFile:(NSString *)path withData:(NSData *)data
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL bol = NO;
    if (![fileManager fileExistsAtPath:path]) {
        bol = [fileManager createFileAtPath:path contents:data attributes:nil];
    }
    
    return bol;
    
}

/**
 @brief 根据文件路径来删除文件
 @param path 要删除文件的路径
 @return 是否删除成功
 */
+ (BOOL)deleteFile:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        BOOL isSucuss = [fileManager removeItemAtPath:path error:nil];
        
        if (isSucuss) {
            return YES;
        }
    }
    
    return NO;
}


/**
 @brief 归档需要归档的数据到指定路径
 @param data 要归档的数据
 @param path 文件路径
 @return 归档数据是否成功
 */
+ (BOOL)saveObjectToArchiver:(id)data withPath:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        
        [fm removeItemAtPath:path error:nil];
    }
    
    BOOL bol = [NSKeyedArchiver archiveRootObject:data toFile:path];
    
    return bol;
}

/**
 @brief 读取归档的文件
 @param path 文件路径
 @return 读取的文件内容，如果文件不存在则返回空
 */
+ (id)readObjectFormArchierWithPath:(NSString *)path
{
    // 解归档，拿缓存数据
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        id unarchiverData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return unarchiverData;
        
    }else{
        
        return nil;
    }
    
}


/**
 *  // 计算目录下面所有文件的大小
 *
 *  @param directory 文件目录
 *
 *  @return 该目录下文件的大小
 */
+ (long long)countDirectorySize:(NSString *)directory
{
    // 文件管理者对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 获取到目录下面所有的文件名
    NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:directory error:nil];
    //NSLog(@"fileNames : %@", fileNames);
    
    // 所有的文件大小
    long long sum = 0;
    for (NSString *fileName in fileNames) {
        
        // 拼接文件路径 Library/Caches.. + bdcdd4208ac8657348d9836f7d6cc160
        NSString *filePath = [directory stringByAppendingPathComponent:fileName];
        
        // 获取文件属性
        NSDictionary *attribute = [fileManager attributesOfItemAtPath:filePath error:nil];
        //NSLog(@"attribute : %@", attribute);
        
        //NSNumber *filesize = attribute[NSFileSize];
        // 得到是每一个文件大小
        long long size = [attribute fileSize];
        
        // 累加
        sum += size;
    }
    
    return sum;
}


/**
  获取本地文件 MIMEType

 @param path 文件路径

 */
+ (NSString *)getMIMETypeAtFilePath:(NSString *)path
{
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
        return nil;
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)(MIMEType);
}


/**
 获取当前时间戳

 @return 返回当前时间戳字符串
 */
+ (NSString *)timeToTurnTheTimestamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    return timeString;
}

/**
 时间戳转时间格式

 @param timestamp 时间戳
 @param formatter 格式 @"yyyy-MM-dd HH:mm:ss"
 @return 返回字符串
 */
+ (NSString *)timestampToString:(NSString *)timestamp formatterString:(NSString *)formatter {
    NSTimeInterval time=[[NSString stringWithFormat:@"%@",timestamp] doubleValue];
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatter];
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    return  currentDateStr;
}


+ (NSMutableAttributedString *)setAllText:(NSString *)allStr andSpcifiStr:(NSString *)specifiStr withColor:(UIColor *)color specifiStrFont:(UIFont *)font {
    NSMutableAttributedString *mutableAttributedStr = [[NSMutableAttributedString alloc] initWithString:allStr];
    if (color == nil) {
        color = [UIColor redColor];
    }
    if (font == nil) {
        font = [UIFont systemFontOfSize:17.0];
    }
    //    NSArray *array = [allStr componentsSeparatedByString:specifiStr];//array.cout-1是所有字符特殊字符出现的次数
    NSRange searchRange = NSMakeRange(0, [allStr length]);
    NSRange range;
    //拿到所有的相同字符的range
    while
        ((range = [allStr rangeOfString:specifiStr options:0 range:searchRange]).location != NSNotFound) {
            //改变多次搜索时searchRange的位置
            searchRange = NSMakeRange(NSMaxRange(range), [allStr length] - NSMaxRange(range));
            //设置富文本
            [mutableAttributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            
            [mutableAttributedStr addAttribute:NSFontAttributeName value:font range:range];
        }
    return mutableAttributedStr;
    
}

#pragma mark - 获取html中的图片url数组
+ (NSArray *) getImageurlFromHtml:(NSString *) webString
{
    NSMutableArray * imageurlArray = [NSMutableArray arrayWithCapacity:1];
    
    //标签匹配
    NSString *parten = @"<img(.*?)>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    
    NSArray* match = [reg matchesInString:webString options:0 range:NSMakeRange(0, [webString length] - 1)];
    
    for (NSTextCheckingResult * result in match) {
        
        //过去数组中的标签
        NSRange range = [result range];
        NSString * subString = [webString substringWithRange:range];
        
        //从图片中的标签中提取ImageURL
        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"http://(.*?)\'" options:0 error:NULL];
        NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
        NSTextCheckingResult * subRes = match[0];
        NSRange subRange = [subRes range];
        subRange.length = subRange.length -1;
        NSString * imagekUrl = [subString substringWithRange:subRange];
        
        //将提取出的图片URL添加到图片数组中
        [imageurlArray addObject:imagekUrl];
    }
    return imageurlArray;
}

+(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
	
	UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
	UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return reSizeImage;
}

+(NSString *)UUIDString {
    return [[NSUUID UUID] UUIDString];
}

+ (NSString *)app_Version {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (NSString *)deviceName {
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
}

+ (NSString *)phoneVersion {
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
}

+ (NSString *)phoneModel {
    NSString* phoneModel = [[UIDevice currentDevice] model];
    return phoneModel;
}

+ (NSString *)localPhoneModel {
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    return localPhoneModel;
}

+ (NSString *)appLanguages {
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    return languageName;
}

+ (NSString *)countryCode {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    return countryCode;
}

+ (BOOL)isNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

// 获取当前的时间
+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//判断手机号码格式是否正确

+ (BOOL)valiMobile:(NSString *)mobile

{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        
        return NO;
        
    }else{
        
        /**
         
         * 移动号段正则表达式
         
         */
        
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        
        /**
         
         * 联通号段正则表达式
         
         */
        
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        
        /**
         
         * 电信号段正则表达式
         
         */
        
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        
        
        if (isMatch1 || isMatch2 || isMatch3) {
            
            return YES;
            
        }else{
            
            return NO;
            
        }
        
    }
    
}





@end
