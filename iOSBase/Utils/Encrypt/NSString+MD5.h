//
//  NSString+XHMD5.h
//  XHImageViewer
//
//  Created by 曾 宪华 on 14-2-18.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

/**
 *  MD5加密
 *
 *  @return MD5加密后的秘钥
 */
- (NSString *)MD5Hash;

/**
 *  MD5加密算法
 *
 *  @param str 传入的字符串
 *
 *  @return 返回加密的字符串
 */
+(NSString *)md5_Encrypt:(NSString *)str;

@end
