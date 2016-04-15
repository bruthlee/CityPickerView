//
//  URPickerView.m
//  UnitRepair
//
//  Created by bruthlee on 15/10/9.
//  Copyright © 2015年 bruthlee.app. All rights reserved.
//

#import "URPickerView.h"

#import "UIView+ViewStyle.h"

@interface URPickerView()
@property (nonatomic,strong) UIToolbar *toolBar;
@property (nonatomic,strong) URPickerViewToolbarBlock pickerBlock;
@end

@implementation URPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return self;
}

- (void)showInView:(UIView *)parentView withBlock:(URPickerViewToolbarBlock)block {
    self.pickerBlock = block;
    [parentView addSubview:self];
    [self showViewWithAnimate];
}

- (void)dealloc{
    if (self.pickerBlock) {
        self.pickerBlock = nil;
    }
    
    if (_pickerView) {
        _pickerView.delegate = nil;
        _pickerView.dataSource = nil;
        _pickerView = nil;
    }
}

#pragma mark - Animate

- (void)showViewWithAnimate {
    self.alpha = 0.0;
    self.toolBar.top = ScreenHeight;
    [self addSubview:self.toolBar];
    self.pickerView.top = self.toolBar.bottom;
    [self addSubview:self.pickerView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        self.toolBar.top = ScreenHeight - self.toolBar.height - self.pickerView.height - self.top;
        self.pickerView.top = self.toolBar.bottom;
    }];
}

- (void)hideViewWithAnimate {
    [UIView animateWithDuration:0.3 animations:^{
        self.toolBar.top = ScreenHeight;
        self.pickerView.top = self.toolBar.bottom;
    } completion:^(BOOL finished) {
        [self.toolBar removeFromSuperview];
        [self.pickerView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - Event

- (void)touchPickerViewCancekButton {
    if (self.pickerBlock) {
        self.pickerBlock(self,0);
    }
    
    [self hideViewWithAnimate];
}

- (void)touchPickerViewOKButton {
    if (self.pickerBlock) {
        self.pickerBlock(self,1);
    }
    
    [self hideViewWithAnimate];
}

#pragma mark - Getter

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240)];
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        [_toolBar setBackgroundImage:[UIView generateImage:[UIColor blueColor]] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        _toolBar.tintColor = [UIColor whiteColor];
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(touchPickerViewCancekButton)];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *sure = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(touchPickerViewOKButton)];
        _toolBar.items = @[cancel,flex,sure];
    }
    return _toolBar;
}

@end

#pragma mark -
#pragma mark URAreaPickerView

@interface URAreaPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSString *_selectProvince;
    NSString *_selectCity;
    NSString *_selectArea;
}
@property (strong, nonatomic) NSMutableArray *provinceList;
@property (strong, nonatomic) NSMutableArray *cityList;
@property (strong, nonatomic) NSMutableArray *areaList;
@end

@implementation URAreaPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
    }
    return self;
}

- (void)showInView:(UIView *)parentView withBlock:(URAreaPickerViewBlock)block {
//    [self matchLocationInfo];
    [super showInView:parentView withBlock:^(URPickerView *pickerView, NSInteger index) {
        if (block) {
            if (index == 1) {
                block(YES,_selectProvince,_selectCity,_selectArea);
            }
            else {
                block(NO,_selectProvince,_selectCity,_selectArea);
            }
        }
    }];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceList.count;
    }
    else if (component == 1) {
        return self.cityList.count;
    }
    else {
        return self.areaList.count;
    }
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return floorf(ScreenWidth / 3);
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0 && row < self.provinceList.count) {
        NSDictionary *item = [self.provinceList objectAtIndex:row];
        return item[@"-areaName"];
    }
    else if (component == 1 && row < self.cityList.count) {
        NSDictionary *item = [self.cityList objectAtIndex:row];
        return item[@"-areaName"];
    }
    else if (component == 2 && row < self.areaList.count) {
        NSDictionary *item = [self.areaList objectAtIndex:row];
        return item[@"-areaName"];
    }
    return nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if (view == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, floorf(ScreenWidth/3), 44)];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        view = label;
    }
    
    UILabel *label = (UILabel *)view;
    if (component == 0 && row < self.provinceList.count) {
        NSDictionary *item = [self.provinceList objectAtIndex:row];
        label.text = item[@"-areaName"];
    }
    else if (component == 1 && row < self.cityList.count) {
        NSDictionary *item = [self.cityList objectAtIndex:row];
        label.text = item[@"-areaName"];
    }
    else if (component == 2 && row < self.areaList.count) {
        NSDictionary *item = [self.areaList objectAtIndex:row];
        label.text = item[@"-areaName"];
    }
    
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0 && row < self.provinceList.count) {
        NSDictionary *item = [self.provinceList objectAtIndex:row];
        if (!_selectProvince || ![_selectProvince isEqualToString:item[@"-areaName"]]) {
            _selectProvince = item[@"-areaName"];
            [self loadCityByProvince:item match:NO];
            [pickerView reloadAllComponents];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView selectRow:0 inComponent:2 animated:NO];
        }
    }
    else if (component == 1 && row < self.cityList.count) {
        NSDictionary *item = [self.cityList objectAtIndex:row];
        if (!_selectCity || ![_selectCity isEqualToString:item[@"-areaName"]]) {
            _selectCity = item[@"-areaName"];
            [self loadAreaByCity:item match:NO];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
        }
    }
    else if (component == 2 && row < self.areaList.count) {
        NSDictionary *item = [self.areaList objectAtIndex:row];
        if (!_selectArea || ![_selectArea isEqualToString:item[@"-areaName"]]) {
            _selectArea = item[@"-areaName"];
        }
    }
}

#pragma mark - Data

- (void)loadCityByProvince:(NSDictionary *)province match:(BOOL)match {
    [self.cityList removeAllObjects];
    NSArray *list = province[@"city"];
    if (list.count > 0) {
        [self.cityList addObjectsFromArray:list];
        NSDictionary *first = list[0];
        _selectCity = first[@"-areaName"];
        [self loadAreaByCity:first match:NO];
    }

//  //本地定位后显示定位后的位置
//    if (match) {
//        NSString *city = [[NSUserDefaults standardUserDefaults] stringForKey:UserLocationCity];
//        if (city) {
//            for (int i=0; i<self.cityList.count; i++) {
//                NSDictionary *item = [self.cityList objectAtIndex:i];
//                if ([city isEqualToString:item[@"-areaName"]]) {
//                    [self.pickerView reloadComponent:1];
//                    [self.pickerView selectRow:i inComponent:1 animated:NO];
//                    _selectCity = city;
//                    [self loadAreaByCity:item match:YES];
//                    break;
//                }
//            }
//        }
//    }
}

- (void)loadAreaByCity:(NSDictionary *)city match:(BOOL)match {
    [self.areaList removeAllObjects];
    NSArray *list = city[@"district"];
    if (list.count > 0) {
        [self.areaList addObjectsFromArray:list];
        NSDictionary *first = list[0];
        _selectArea = first[@"-areaName"];
    }
    /*
    if (match) {
        NSString *street = [AppStorage stringForKey:UserLocationStreet];
        if (street) {
            for (int i=0; i<self.areaList.count; i++) {
                URBaseModel *item = [self.areaList objectAtIndex:i];
                if ([street isEqualToString:item.baseValue]) {
                    [self.pickerView reloadComponent:2];
                    [self.pickerView selectRow:i inComponent:2 animated:NO];
                    _selectArea = street;
                    break;
                }
            }
        }
    }
     */
}
/*
- (void)matchLocationInfo {
    NSString *province = [AppStorage stringForKey:UserLocationProvince];
    if (province) {
        for (int i=0; i<self.provinceList.count; i++) {
            URBaseModel *item = [self.provinceList objectAtIndex:i];
            if ([province isEqualToString:item.baseValue]) {
                [self.pickerView selectRow:i inComponent:0 animated:NO];
                _selectProvince = province;
                [self loadCityByProvince:item match:YES];
                break;
            }
        }
    }
}
*/
- (NSMutableArray *)provinceList {
    if (_provinceList == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"procity" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *list = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _provinceList = [[NSMutableArray alloc] init];
        for (int i=0; i<list.count; i++) {
            NSDictionary *item = [list objectAtIndex:i];
            [_provinceList addObject:item];
            
            if (i == 0) {
                [self loadCityByProvince:item match:NO];
            }
        }
    }
    return _provinceList;
}

- (NSMutableArray *)cityList {
    if (_cityList == nil) {
        _cityList = [[NSMutableArray alloc] init];
    }
    return _cityList;
}

- (NSMutableArray *)areaList {
    if (_areaList == nil) {
        _areaList = [[NSMutableArray alloc] init];
    }
    return _areaList;
}

@end

