//
//  WXZPickCityView.m
//  自定义选择器
//
//  Created by WOSHIPM on 2017/5/3.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "WXZPickCityView.h"
#import "FZDJBankCardModel.h"
@interface WXZPickCityView()<UIPickerViewDataSource, UIPickerViewDelegate>


@property (nonatomic, strong, nullable)NSArray *areaDataSource;
@property (nonatomic, strong, nullable)NSMutableArray *selectedArray;//当前选中的数组
@property (nonatomic, strong, nullable)NSString *selectProvince;
@property (nonatomic, strong, nullable)NSString *selectCity;
@property (nonatomic, strong) FZDJBankCardModel *model;
@end

@implementation WXZPickCityView


- (void)initPickView
{
    [super initPickView];
    self.model = [FZDJBankCardModel new];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
}

- (void)reloadData{
    self.selectProvince = self.provinceArray.firstObject;
    self.selectCity = self.cityArray.firstObject;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count;
    }else  {
        return self.cityArray.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 36;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        [self.cityArray removeAllObjects];
        NSString *city = self.provinceArray[row];
        NSDictionary *dict2 = @{@"province":city.length>0 ? city : @""};
        
        __weak typeof(self) weak_self = self;
        [self.model loadCity:dict2 success:^(NSDictionary *dict) {
            weak_self.cityArray = [NSMutableArray arrayWithArray:weak_self.model.cityArr];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [weak_self refreshSelectAreaData];
        } failure:^(NSError *error) {
//            [weak_self refreshSelectAreaData];
        }];

    }else if (component == 1) {

    }else{
    }
    
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        text =  self.provinceArray[row];
    }else if (component == 1){
        text =  self.cityArray[row];
    }else{
        
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:16];
    label.text = text;
    
    return label;
}


- (void)clickConfirmButton
{
    
    [self.delegate pickerArea:self selectProvince:self.selectProvince selectCity:self.selectCity];
    
    [super clickConfirmButton];
}


- (void)refreshSelectAreaData
{
    NSInteger provienceIndex = [self.pickerView selectedRowInComponent:0];
    NSInteger cityIndex = [self.pickerView selectedRowInComponent:1];
    
    self.selectProvince = self.provinceArray[provienceIndex];
    self.selectCity = self.cityArray[cityIndex];
    
}


- (NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}


- (NSMutableArray *)selectedArray
{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}



@end
