//
//  BaseViewController.h
//  Keepcaring
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQPlaceholderView.h"

@interface BaseViewController : UIViewController
// 新项目需要去自定义 该类的样式。 修改文字、图片等
@property(nonatomic,strong)CQPlaceholderView *placeholderView;

/**
 *  显示没有数据页面
 */
-(void)showNoDataImage;

/**
 *  移除无数据页面
 */
-(void)removeNoDataImage;

//重新加载数据
- (void)reloadViewData;

@end

/*
 CQPlaceholderView *placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) type:CQPlaceholderViewTypeBeautifulGirl delegate:self];
 [self.view addSubview:placeholderView];
 
 */
