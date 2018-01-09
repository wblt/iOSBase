//
//  FontAndColorMacros.h
//  Keepcaring
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -  间距区
//默认间距
#define KNormalSpace 12.0f


#pragma mark -  颜色区
//主题色 导航栏颜色
#define CNavBgColor  [UIColor colorWithHexString:@"00AE68"]
//#define CNavBgColor  [Ulor colorWithHexString:@"ffffff"]
#define CNavBgFontColor  [UIColor colorWithHexString:@"ffffff"]
//默认页面背景色
#define CViewBgColor [UIColor colorWithHexString:@"f2f2f2"]
//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"ededed"]
//次级字色
#define CFontColor1 [UIColor colorWithHexString:@"1f1f1f"]
//再次级字色
#define CFontColor2 [UIColor colorWithHexString:@"5c5c5c"]
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]
#define kRandomColor   KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)        //随机色生成

#pragma mark -  字体区
/**<字体宏定义*/
#define Font_11 [UIFont systemFontOfSize:11]
#define Font_12 [UIFont systemFontOfSize:12]
#define Font_13 [UIFont systemFontOfSize:13]
#define Font_14 [UIFont systemFontOfSize:14]
#define Font_15 [UIFont systemFontOfSize:15]
#define Font_16 [UIFont systemFontOfSize:16]
#define Font_17 [UIFont systemFontOfSize:17]
#define Font_18 [UIFont systemFontOfSize:18]
#define Font_19 [UIFont systemFontOfSize:19]
#define Font_20 [UIFont systemFontOfSize:20]
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]


#endif /* FontAndColorMacros_h */
