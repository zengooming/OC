//
//  ZMDatePickerView.m
//  日期选择器
//
//  Created by 明 on 2020/9/22.
//  Copyright © 2020 mengxianjin. All rights reserved.
//

#import "ZMDatePickerView.h"

#define SCREEN_WIDTH  UIScreen.mainScreen.bounds.size.width
#define SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height

@interface ZMDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>


@property (nonatomic,strong)UIPickerView   * datePicker;
@property (nonatomic,strong)NSMutableArray * yearArray;
@property (nonatomic,strong)NSMutableArray * monthArray;
@property (nonatomic,strong)NSMutableArray * dayArray;

@property (nonatomic,assign)NSInteger      minYear;
@property (nonatomic,assign)NSInteger      minMonth;
@property (nonatomic,assign)NSInteger      minDay;

@property (nonatomic,assign)NSInteger      maxYear;
@property (nonatomic,assign)NSInteger      maxMonth;
@property (nonatomic,assign)NSInteger      maxDay;

@property (nonatomic,assign)NSInteger      defaultYear;
@property (nonatomic,assign)NSInteger      defaultMonth;
@property (nonatomic,assign)NSInteger      defaultDay;

@end

@implementation ZMDatePickerView {
    
    //记录日期位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:CGRectZero]) {
        [self setupUI];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }
    
    return self;
}


- (void)show {
   
    NSInteger yearRow = 0;
    NSInteger monthRow = 0;
    NSInteger dayRow = 0;
    
    if ([self.yearArray containsObject:@(self.defaultYear)]) {
        yearRow = [self.yearArray indexOfObject:@(self.defaultYear)];
    }
    if ([self.monthArray containsObject:@(self.defaultMonth)]) {
        monthRow = [self.monthArray indexOfObject:@(self.defaultMonth)];
    }
    if ([self.dayArray containsObject:@(self.defaultDay)]) {
        dayRow = [self.dayArray indexOfObject:@(self.defaultDay)];
    }
    
    yearIndex = yearRow;
    monthIndex = monthRow;
    dayIndex = dayRow;
    
    [self.datePicker reloadAllComponents];
    
    [self.datePicker selectRow:yearRow inComponent:0 animated:NO];
    [self.datePicker selectRow:monthRow inComponent:1 animated:NO];
    [self.datePicker selectRow:dayRow inComponent:2 animated:NO];
    

    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.datePicker.center = self.center;
    
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (void)setupUI {
    
    [self addSubview:self.datePicker];
    
    [self defaultConfig];
}


/// 限制最小可选年 月 日
/// @param minYear 年
/// @param minMonth 月
/// @param minDay 日
- (void)setMinYear:(NSInteger)minYear minMonth:(NSInteger)minMonth minDay:(NSInteger)minDay {
    self.minYear  = minYear;
    self.minMonth = minMonth;
    self.minDay   = minDay;
    [self setYearCount];
}

/// 限制最大可选年 月 日
/// @param maxYear 年
/// @param maxMonth 月
/// @param maxDay 日
- (void)setMaxYear:(NSInteger)maxYear maxMonth:(NSInteger)maxMonth maxDay:(NSInteger)maxDay {
    self.maxYear  = maxYear;
    self.maxMonth = maxMonth;
    self.maxDay   = maxDay;
    [self setYearCount];
}



/// 设置默认选择年月日
/// @param year 年
/// @param month 月
/// @param day 日
/// 该值不设置 默认当前时间
- (void)setDefaultYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    if (year < self.maxYear && year > self.minYear) {
        self.defaultYear  = year;
    }
    
    if (month < self.maxMonth && month > self.minMonth) {
        self.defaultMonth  = month;
    }
    
    if (day < self.maxDay && day > self.minDay) {
        self.defaultDay  = day;
    }

}


- (void)defaultConfig {
    
    //最小 公元1年01月01日
    self.minYear = 1;
    self.minMonth = 1;
    self.minDay   = 1;
    //最大 公元9999年12月31日
    self.maxYear = 9999;
    self.maxMonth   = 12;
    self.maxDay = 31;
    
    yearIndex = 0;
    monthIndex = 0;
    dayIndex = 0;
    
    [self.yearArray removeAllObjects];
    [self.monthArray removeAllObjects];
    [self.dayArray removeAllObjects];
    
    [self setYearCount];
    
    for (NSInteger i = 1; i <= 12; i ++) {
        [self.monthArray addObject:@(i)];
    }
    
    for (NSInteger i = 1; i <= 31; i ++) {
        [self.dayArray addObject:@(i)];
    }
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    self.defaultYear = [[formatter stringFromDate:[NSDate date]] integerValue];

    formatter.dateFormat = @"MM";
    self.defaultMonth = [[formatter stringFromDate:[NSDate date]] integerValue];
   
    formatter.dateFormat = @"dd";
    self.defaultDay = [[formatter stringFromDate:[NSDate date]] integerValue];
    
    
}



// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.yearArray.count;
            break;
        case 1:
            return self.monthArray.count;
            break;
        case 2:
            return self.dayArray.count;
            break;
            
        default:
            return 0;
            break;
    }
}


//cell高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return  40;
}
//返回每行文本
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component  {
    
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%@",[self.yearArray objectAtIndex:row]];
            break;
        case 1:
            return [NSString stringWithFormat:@"%02ld",(long)[self.monthArray[row] integerValue]];
            break;
        case 2:
            return [NSString stringWithFormat:@"%02ld",(long)[self.dayArray[row] integerValue]];
            break;
        default:
        return  @"";
            break;
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    UILabel *headLabel = [[UILabel alloc] init];
    headLabel.textColor = UIColor.redColor;
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.font = [UIFont systemFontOfSize:16];
    
    switch (component) {
        case 0:
            headLabel.text = [NSString stringWithFormat:@"%@",self.yearArray[row]];
            break;
        case 1:
            headLabel.text = [NSString stringWithFormat:@"%02ld",(long)[self.monthArray[row] integerValue]];
            break;
        case 2:
            headLabel.text = [NSString stringWithFormat:@"%02ld",(long)[self.dayArray[row] integerValue]];
            break;
            
        default:
            break;
    }
    
    return  headLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0 ){
        yearIndex = row;
        //月数计算
        [self setMonthCount];
        //调整滚轮 防止 月数 数量调整 取 月数 数据据数组越界
        if (monthIndex >= self.monthArray.count) {
            monthIndex = self.monthArray.count - 1;
        }
    }
    
    
    if (component == 1 ){
        monthIndex = row;
    }
    if (component == 2 ){
        dayIndex = row;
    }
    
    //天数计算
    if (component == 0 || component == 1) {
        [self setDayCount];
        
        //调整滚轮 防止 天数数量调整 取 天数 数据据数组越界
        if (dayIndex >= self.dayArray.count) {
            dayIndex = self.dayArray.count - 1;
        }
    }
    
    if (self.delegate) {

        NSInteger year = [[self.yearArray objectAtIndex:yearIndex] integerValue];
        NSInteger month = [[self.monthArray objectAtIndex:monthIndex] integerValue];
        NSInteger day = [[self.dayArray objectAtIndex:dayIndex] integerValue];
        
        [self.delegate pickerView:self didSelectRow:row inComponent:component year:year month:month day:day];
    }
    
    [pickerView reloadAllComponents];
    
    
}

//根据限制 设置年数量
- (void)setYearCount {
    [self.yearArray removeAllObjects];
    for (NSInteger i = self.minYear; i <= self.maxYear; i ++) {
        [self.yearArray addObject:@(i)];
    }
}

//根据年 和最大最小限制来月滚轮
- (void)setMonthCount{
    //最小限制
    if (yearIndex == 0) {
        [self.monthArray removeAllObjects];
        for (NSInteger i = self.minMonth; i <= 12; i ++) {
            [self.monthArray addObject:@(i)];
        }
    }
    //最大限制
    if (yearIndex == self.yearArray.count - 1) {
        [self.monthArray removeAllObjects];
        for (NSInteger i = 1; i <= self.maxMonth; i ++) {
            [self.monthArray addObject:@(i)];
        }
    }
    //正常月个数
    if (yearIndex != 0 && yearIndex != self.yearArray.count - 1) {
        [self.monthArray removeAllObjects];
        for (NSInteger i = 1; i <= 12; i ++) {
            [self.monthArray addObject:@(i)];
        }
    }
    
    
}

//跟据年月和最大最小限制 来计算当年当月天数
- (void)setDayCount {
    
    [self.dayArray removeAllObjects];
    NSInteger year = [[self.yearArray objectAtIndex:yearIndex] integerValue];
    NSInteger month = [[self.monthArray objectAtIndex:monthIndex] integerValue];
    NSInteger days = [self daysCountForYear:year month:month];
    
    //正常年月 天数计算
    for (NSInteger i = 1; i <= days; i ++) {
        [self.dayArray addObject:@(i)];
    }
    
    //最小年月 天数计算
    if (yearIndex == 0 && monthIndex == 0) {
        [self.dayArray removeAllObjects];
        for (NSInteger i = self.minDay; i <= days; i ++) {
            [self.dayArray addObject:@(i)];
        }
    }
    
    //最大年月 天数计算
    if (yearIndex == self.yearArray.count - 1 && monthIndex == self.monthArray.count - 1) {
        [self.dayArray removeAllObjects];
        
        if (self.maxDay < days) {
            for (NSInteger i = 1; i <= self.maxDay; i ++) {
                [self.dayArray addObject:@(i)];
            }
        }else {
            for (NSInteger i = 1; i <= days; i ++) {
                [self.dayArray addObject:@(i)];
            }
        }
    }
    
}

/// 返回当年当月天数
/// @param year 年    ： 大于0公元后 小于零公元前 例如 ：公元前1000年  = -1000 ，公元2000年 = 2000
/// @param month 月 ：1 - 12个月 为公历计月 不是农历
- (NSInteger)daysCountForYear:(NSInteger)year month:(NSInteger)month {
    

    //月份不对
    if (month < 0 || month > 12) {
        return 0;
    }
    //31天月
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 ) {
        return 31;
    }
    //30天月
    if (month == 4 || month == 6 || month == 9 || month == 11 ) {
        return 30;
    }
     
    //判断是否是普通闰年 或者 世纪闰年
    /*
     
     闰年是为了弥补因人为历法规定造成的年度天数与地球实际公转周期的时间差而设立的。补上时间差的年份为闰年。闰年共有366天
     
     1.公元后闰年计算：
     
     普通闰年 ：公历年份是4的倍数的，且不是100的倍数，为普通闰年。（如2004、2020年就是闰年）
     世纪闰年 ：公历年份是整百数的，必须是400的倍数才是世纪闰年（如1900年不是世纪闰年，2000年是世纪闰年）
     其他年份 ：能被100整除切不能被400整除 或者不能被4整除且不能被100整除 例如 1900 1999 2100
     
     year%400 == 0 || ((year%4==0) && (year%100 != 0))
     
     2.公元前闰年计算 ：
     
     根据闰年算法，公元4年是闰年，且周期是4年，如果公元有0年，即为闰年。因为公元没有0年，那公元前1年就是是闰年。
     公元前普通闰年 ：年数除以4余数为1是闰年，即公元前1、5、9……是闰年；
     公元前世纪闰年 ：年数除以400余数为1是闰年，即公元前401、801……是闰年；
     
     absYear%400 == 1 || ( (absYear%100 != 1) && (absYear%4==1) )
     
     */
    BOOL isLeapYear = NO;
    NSInteger absYear = labs(year);
    //判断是否是公元前
    if (year > 0 ) { // 公元后
        
        if ( year%400 == 0 || ( (year%4==0) && (year%100 != 0) ) ) {
            isLeapYear = YES;
        }
        
    } else { // 公元前
        
        if (absYear%400 == 1 || ( (absYear%100 != 1) && (absYear%4==1))) {
            isLeapYear = YES;
        }
        
    }
    
    //根据是否闰年来计算二月份天数 闰年29天 非闰年 28天
    if (month == 2) {
        if (!isLeapYear) {
            return 28;
        }else {
            return 29;
        }
    }
    
    
    return 0;
}


- (NSMutableArray *)yearArray {
    
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
    }
    
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    
    if (!_monthArray) {
        _monthArray = [NSMutableArray array];
    }
    
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
    }
    
    return _dayArray;
}

- (UIPickerView *)datePicker {
    
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT, SCREEN_WIDTH - 60, 245)];
        _datePicker.showsSelectionIndicator = YES;
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
        _datePicker.backgroundColor = UIColor.whiteColor;
        _datePicker.layer.cornerRadius = 5;

    }
    
    return _datePicker;
}

@end
