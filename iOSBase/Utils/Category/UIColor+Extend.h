//
//  UIColor+Extend.h
//  CSDirectBank
//
//  Created by lizzy on 15/7/13.
//  Copyright (c) 2015年 lyx. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (Extend)

/*!
 *  @author lizzy, 15-08-07 10:08:54
 *
 *  @brief  16进制获取颜色
 *
 *  @param hex  16进制颜色值
 *
 *  @return 颜色
 *
 *  @since 2.8.0
 */
+ (UIColor *) colorWithHex:(unsigned int)hex;

/*!
 *  @author lizzy, 15-08-07 10:08:21
 *
 *  @brief  16进制获取颜色，并且设置颜色透明度
 *
 *  @param hex   16进制颜色值
 *  @param alpha 颜色透明度
 *
 *  @return 颜色
 *
 *  @since 2.8.0
 */
+ (UIColor *) colorWithHex:(unsigned int)hex
                     alpha:(CGFloat)alpha;

/*!
 *  @author lizzy, 15-08-07 10:08:25
 *
 *  @brief  随机获取颜色
 *
 *  @return 颜色
 *
 *  @since 2.8.0
 */
+ (UIColor *) randomColor;


@end
