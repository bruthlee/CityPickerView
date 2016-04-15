//
//  URDatePickerView.h
//  UnitRepair
//
//  Created by bruthlee on 15/10/12.
//  Copyright © 2015年 bruthlee.app. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DatePickerViewBlock)(BOOL sure, NSDate *date);

@interface URDatePickerView : UIView

@property (nonatomic, strong) NSDate *maxDate;

@property (nonatomic, strong) NSDate *minDate;

+ (void)showDatePickerInView:(UIView *)parentView block:(DatePickerViewBlock)block;

- (void)showInView:(UIView *)parentView block:(DatePickerViewBlock)block;

- (void)showInView:(UIView *)parentView withDateModel:(UIDatePickerMode)model block:(DatePickerViewBlock)block;

@end
