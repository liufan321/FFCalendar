//
//  FFCalendarDate.h
//  FFCalendar
//
//  Created by 刘凡 on 2016/7/25.
//  Copyright © 2016年 joyios. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 日历日期类
 */
@interface FFCalendarDate : NSObject

#pragma mark - 实例化方法
/**
 * 使用年/月/日实例化日期对象
 */
+ (nullable instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
/**
 * 使用 NSDate 实例化日期对象
 */
+ (nullable instancetype)dateWithDate:(nullable NSDate *)date;

#pragma mark - 日期处理方法
/**
 * 当前日期的下一天
 */
- (nullable instancetype)nextDate;
/**
 * 当前日期的前一天
 */
- (nullable instancetype)previousDate;

/**
 * 当前日期递增一周的日期
 */
- (nullable instancetype)nextWeekDate;

/**
 * 当前日期递减一周的日期
 */
- (nullable instancetype)previousWeekDate;

/**
 * 当前日期所在周的第一天
 */
- (nullable instancetype)firstWeekday;

/**
 * 当前日期所在周的最后一天
 */
- (nullable instancetype)lastWeekDay;

#pragma mark - 类方法
/**
 * 星期符号数组
 */
+ (nonnull NSArray<NSString *> *)weekdaySymbols;

/**
 * 指定日期所在周的完整日期数组
 *
 * @param date 日期
 *
 * @return 日期数组，数组首位包含非本月的日期
 */
+ (nonnull NSArray<FFCalendarDate *> *)dateArrayInWeekWithDate:(nonnull FFCalendarDate *)date;

/**
 * 指定日期所在月的完整日期数组
 *
 * @param date 日期
 *
 * @return 日期数组，数组首位包含非本月的日期
 */
+ (nonnull NSArray<FFCalendarDate *> *)dateArrayInMonthWithDate:(nonnull FFCalendarDate *)date;

/**
 * 指定年月的完整日期数组
 *
 * @param year  年
 * @param month 月
 *
 * @return 日期数组，数组首位包含非本月的日期
 */
+ (nonnull NSArray<FFCalendarDate *> *)dateArrayWithYear:(NSInteger)year month:(NSInteger)month;

/**
 * 计算两个日期之间的星期差值
 *
 * @param date1 日期1
 * @param date2 日期2
 *
 * @return 星期差值的绝对值
 */
+ (NSInteger)weekDifferenceBetweenDate1:(nonnull FFCalendarDate *)date1 andDate2:(nonnull FFCalendarDate *)date2;

/**
 * 计算两个日期之间的月度差值
 *
 * @param date1 日期1
 * @param date2 日期2
 *
 * @return 月度差值的绝对值
 */
+ (NSInteger)monthDifferenceBetweenDate1:(nonnull FFCalendarDate *)date1 andDate2:(nonnull FFCalendarDate *)date2;

#pragma mark - 日期属性
/**
 * 日期对象
 */
@property (nullable, nonatomic, strong, readonly) NSDate *date;
/**
 * 年
 */
@property (nonatomic, assign, readonly) NSInteger year;
/**
 * 月
 */
@property (nonatomic, assign, readonly) NSInteger month;
/**
 * 日
 */
@property (nonatomic, assign, readonly) NSInteger day;
/**
 * 星期
 */
@property (nonatomic, assign, readonly) NSInteger weekday;
/**
 * 农历年
 */
@property (nonatomic, assign, readonly) NSInteger lunarYear;
/**
 * 农历月
 */
@property (nonatomic, assign, readonly) NSInteger lunarMonth;
/**
 * 是否农历闰月
 */
@property (nonatomic, assign, readonly) BOOL lunarLeap;
/**
 * 农历日
 */
@property (nonatomic, assign, readonly) NSInteger lunarDay;

@end
