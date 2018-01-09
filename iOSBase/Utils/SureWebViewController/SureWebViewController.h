//
//  SureWebViewController.h
//  SureWebViewController
//
//  Created by 刘硕 on 2016/12/13.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SureWebViewController : UIViewController

// 纯地址
@property (nonatomic, copy) NSString * _Nullable url;

// 是否支持刷新
@property (nonatomic, assign) BOOL canDownRefresh;

/**
 加载本地网页
 
 @param htmlName 本地HTML文件名
 */
- (void)loadHostHtmlName:(NSString *_Nullable)htmlName;

/**
 加载html 文本
 
 @param content 文本
 */
- (void)loadHostHtmlContent:(NSString *_Nullable)content;

@end
