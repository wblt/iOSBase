//
//  UIButton+XYButton.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/6/1.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WYButtonEdgeInsetsStyle) {
    WYButtonEdgeInsetsStyleTop, // image在上，label在下
    WYButtonEdgeInsetsStyleLeft, // image在左，label在右
    WYButtonEdgeInsetsStyleBottom, // image在下，label在上
    WYButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (XYButton)

@property(nonatomic ,copy)void(^block)(UIButton*);

-(void)addTapBlock:(void(^)(UIButton*btn))block;

/**
 *  快速创建文字Button
 *
 *  @param frame           frame
 *  @param title           title
 *  @param backgroundColor 背景颜色
 *  @param titleColor      文字颜色
 *  @param titleFont            文字大小
 */
+ (instancetype)createCustomButtonWithFrame:(CGRect)frame
                                      title:(NSString *)title
                            backGroungColor:(UIColor *)backgroundColor
                                 titleColor:(UIColor *)titleColor
                                       font:(UIFont *)titleFont;
/**
 设置图片文字Frame
 
 @param title     按钮文字
 @param imageName 按钮图片
 @param frame     按钮位置
 
 @return <#return value description#>
 */
-(UIButton *)buttonWithTitle:(NSString *)title ImageName:(NSString *)imageName Frame:(CGRect)frame;


/**
 设置图文样式 及其间距
 
 @param style 样式
 @param space 间距
 */
-(void)layoutButtonWithEdgeInsetsStyle:(WYButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;


@end
