//
//  URPickerView.h
//  UnitRepair
//
//  Created by bruthlee on 15/10/9.
//  Copyright © 2015年 bruthlee.app. All rights reserved.
//

#import <UIKit/UIKit.h>

@class URPickerView;
typedef void(^URPickerViewToolbarBlock)(URPickerView *pickerView , NSInteger index);

@interface URPickerView : UIView

@property (nonatomic,strong) UIPickerView *pickerView;

- (void)showInView:(UIView *)parentView withBlock:(URPickerViewToolbarBlock)block;

@end

#pragma mark -
#pragma mark URAreaPickerView

@class URAreaPickerView;

typedef void(^URAreaPickerViewBlock)(BOOL result, NSString *province, NSString *city, NSString *area);

@interface URAreaPickerView : URPickerView

- (void)showInView:(UIView *)parentView withBlock:(URAreaPickerViewBlock)block;

@end