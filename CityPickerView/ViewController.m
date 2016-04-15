//
//  ViewController.m
//  CityPickerView
//
//  Created by bruthlee on 16/4/15.
//  Copyright © 2016年 custom.view.org. All rights reserved.
//

#import "ViewController.h"

#import "URPickerView.h"
#import "URDatePickerView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *chooseCityButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseDateButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchShowAreaPickerView:(id)sender {
    URAreaPickerView *pickerView = [[URAreaPickerView alloc] initWithFrame:self.view.bounds];
    [pickerView showInView:self.view withBlock:^(BOOL result, NSString *province, NSString *city, NSString *area) {
        if (result) {
            NSString *txt = @"";
            if (province) {
                txt = province;
            }
            if (city) {
                txt = [txt stringByAppendingString:city];
            }
            if (area) {
                txt = [txt stringByAppendingString:area];
            }
            [self.chooseCityButton setTitle:txt forState:UIControlStateNormal];
        }
    }];
}

- (IBAction)touchShowDatePickerView:(id)sender {
    URDatePickerView *pickerView = [[URDatePickerView alloc] initWithFrame:self.view.bounds];
//    [pickerView showInView:<#(UIView *)#> block:<#^(BOOL sure, NSDate *date)block#>];
    [pickerView showInView:self.view withDateModel:UIDatePickerModeDateAndTime block:^(BOOL sure, NSDate *date) {
        if (sure) {
            [self showDate:date];
        }
    }];
}

- (void)showDate:(NSDate *)date {
    if (date) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [self.chooseDateButton setTitle:[formatter stringFromDate:date] forState:UIControlStateNormal];
    }
}

@end
