//
//  ZMDatePickerView.h
//  日期选择器
//
//  Created by 明 on 2020/9/22.
//  Copyright © 2020 mengxianjin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZMDatePickerView;
@protocol ZMDatePickerViewDelegate <NSObject>

@optional
- (void)pickerView:(ZMDatePickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end


@interface ZMDatePickerView : UIView

@property (nonatomic,weak)id<ZMDatePickerViewDelegate> delegate;

- (void)show;
/// 限制最大可选年 月 日
/// @param maxYear 年
/// @param maxMonth 月
/// @param maxDay 日
- (void)setMaxYear:(NSInteger)maxYear maxMonth:(NSInteger)maxMonth maxDay:(NSInteger)maxDay;
/// 限制最小可选年 月 日
/// @param minYear 年
/// @param minMonth 月
/// @param minDay 日
- (void)setMinYear:(NSInteger)minYear minMonth:(NSInteger)minMonth minDay:(NSInteger)minDay;
/// 设置默认选择年月日
/// @param year 年
/// @param month 月
/// @param day 日
/// 该值不设置 默认当前时间
- (void)setDefaultYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;



@end

NS_ASSUME_NONNULL_END
