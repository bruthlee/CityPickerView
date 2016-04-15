//
//  UIView+ViewStyle.m
//  BYHelping
//
//  Created by bruthlee on 15/9/23.
//  Copyright © 2015年 bruthlee.app. All rights reserved.
//

#import "UIView+ViewStyle.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIView (ViewStyle)

#pragma mark - 设置视图基本坐标

- (void)setTop:(CGFloat)top
{
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)left
{
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)right
{
    CGRect rect = self.frame;
    rect.origin.x = right - CGRectGetWidth(self.frame);
    self.frame = rect;
}

- (CGFloat)right
{
    return self.frame.origin.x + CGRectGetWidth(self.frame);
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect rect = self.frame;
    rect.origin.y = bottom - CGRectGetHeight(self.frame);
    self.frame = rect;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + CGRectGetHeight(self.frame);
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

#pragma mark - 设置视图基本样式

- (void)setMaskBounds:(BOOL)maskBounds
{
    self.layer.masksToBounds = maskBounds;
}

- (BOOL)maskBounds
{
    return self.layer.masksToBounds;
}

- (void)setCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)width
{
    if (self.layer.masksToBounds == NO) {
        self.layer.masksToBounds = YES;
    }
    self.layer.borderWidth = width;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)color
{
    if (self.layer.masksToBounds == NO) {
        self.layer.masksToBounds = YES;
    }
    self.layer.borderColor = color.CGColor;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

#pragma mark - 通过颜色生成图片

+ (UIImage *)generateImage:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 对指定视图添加底部下划线

+ (void)addLineTo:(UIView *)view position:(CGRect)rect lineColor:(UIColor *)color
{
    UIView *sepLine = [[UIView alloc] initWithFrame:rect];
    sepLine.backgroundColor = color;
    [view addSubview:sepLine];
}

- (void)addLineWithPosition:(CGRect)rect lineColor:(UIColor *)color
{
    UIView *sepLine = [[UIView alloc] initWithFrame:rect];
    sepLine.backgroundColor = color;
    [self addSubview:sepLine];
}

@end