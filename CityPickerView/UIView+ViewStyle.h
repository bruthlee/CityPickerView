//
//  UIView+ViewStyle.h
//  BYHelping
//
//  Created by bruthlee on 15/9/23.
//  Copyright © 2015年 bruthlee.app. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface UIView (ViewStyle)

/*========设置视图基本坐标========*/
//rect.origin.y = top
@property (nonatomic) CGFloat top;

//rect.origin.x = left;
@property (nonatomic) CGFloat left;

//rect.origin.y = bottom - CGRectGetHeight(self.frame);
@property (nonatomic) CGFloat bottom;

//rect.origin.x = right - CGRectGetWidth(self.frame);
@property (nonatomic) CGFloat right;

//CGRectGetWidth(self.frame)
@property (nonatomic) CGFloat width;

//CGRectGetHeight(self.frame)
@property (nonatomic) CGFloat height;

/*========设置视图基本样式========*/
@property (nonatomic) BOOL maskBounds;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic,strong) UIColor *borderColor;

/*========通过颜色生成图片========*/
+ (UIImage *)generateImage:(UIColor *)color;

/*====对指定视图添加底部下划线=====*/
+ (void)addLineTo:(UIView *)view position:(CGRect)rect lineColor:(UIColor *)color;
- (void)addLineWithPosition:(CGRect)rect lineColor:(UIColor *)color;

@end