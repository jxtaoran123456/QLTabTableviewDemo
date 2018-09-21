//
//  ACBigClickButton.m
//  MyComic
//
//  Created by clareychen on 16/03/11.
//  Copyright (c) 2016年 ellentao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ACBigClickButton : UIButton

//默认扩大上下左右边距为原来的10个像素点
@property(assign,nonatomic)float expandMargins;
@property(strong,nonatomic)UIView *rangeView;
@property(strong,nonatomic)UIColor *oriBackGroundColor;

-(void)showRangeView:(BOOL)show;//显示扩大后的区域点击范围
-(void)setExpandMargins:(float)expandMargins;//设置上下左右的扩展区域


//扩大区域 高度和宽度不一致 用这两个参数 生效优先于expandMargins
@property(assign,nonatomic)float expandMarginsWidth;
@property(assign,nonatomic)float expandMarginsHeight;


@end
