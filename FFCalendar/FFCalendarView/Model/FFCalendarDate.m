//
//  FFCalendarDate.m
//  FFCalendar
//
//  Created by 刘凡 on 2016/7/25.
//  Copyright © 2016年 joyios. All rights reserved.
//

#import "FFCalendarDate.h"

/**
 * 公历日历
 */
static NSCalendar *calendar;
/**
 * 农历日历
 */
static NSCalendar *lunarCalendar;

@implementation FFCalendarDate

+ (void)initialize {
    if (self == [FFCalendarDate self]) {
        calendar = [NSCalendar currentCalendar];
        lunarCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    }
}

#pragma mark - 实例化方法
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSDate *date = [calendar dateWithEra:1 year:year month:month day:day hour:0 minute:0 second:0 nanosecond:0];
    
    return [self dateWithDate:date];
}

+ (instancetype)dateWithDate:(NSDate *)date {
    
    FFCalendarDate *calendarDate = [self new];
    calendarDate.date = date;
    
    return calendarDate;
}

#pragma mark - 设置日期，计算日期属性
- (void)setDate:(NSDate * _Nonnull)date {
    _date = date;
    
    if (_date == nil) {
        return;
    }
    
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    {
        NSDateComponents *components = [calendar components:units fromDate:date];
        
        _year = components.year;
        _month = components.month;
        _day = components.day;
        _weekday = components.weekday;
    }
    
    {
        NSDateComponents *components = [lunarCalendar components:units fromDate:date];
        
        _lunarYear = components.year;
        _lunarMonth = components.month;
        _lunarLeap = components.isLeapMonth;
        _lunarDay = components.day;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> {%04zd-%02zd-%02zd[weekday %zd], lunar: %02zd-(%d)%02zd-%02zd}",
            self.class,
            self,
            _year,
            _month,
            _day,
            _weekday,
            _lunarYear,
            _lunarLeap,
            _lunarMonth,
            _lunarDay];
}

#pragma mark - 日期处理方法
- (instancetype)nextDate {
    if (_date == nil) {
        return  nil;
    }
    
    return [FFCalendarDate dateWithYear:_year month:_month day:(_day + 1)];
}

- (instancetype)previousDate {
    if (_date == nil) {
        return nil;
    }
    
    return [FFCalendarDate dateWithYear:_year month:_month day:(_day - 1)];
}

#pragma mark - 类方法
+ (NSArray<NSString *> *)weekdaySymbols {
    return calendar.shortWeekdaySymbols;
}

+ (NSArray<FFCalendarDate *> *)dateArrayWithYear:(NSInteger)year month:(NSInteger)month {
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    FFCalendarDate *date = [self dateWithYear:year month:month day:1];
    if (date == nil) {
        return arrayM.copy;
    }
    
    NSInteger offset = date.weekday - 2;
    
    for (NSInteger i = 0; i < 42; i++) {
        FFCalendarDate *day = [self dateWithYear:year month:month day:(i - offset)];
        
        if (day == nil || (day.month != month && i > 0 && day.weekday == 1)) {
            break;
        }
        [arrayM addObject:day];
    }
    
    return arrayM.copy;
}


+ (NSArray<FFCalendarDate *> *)dateArrayInWeekWithDate:(FFCalendarDate *)date {
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    return arrayM.copy;
}

+ (NSInteger)monthDifferenceBetweenDate1:(FFCalendarDate *)date1 andDate2:(FFCalendarDate *)date2 {
    NSInteger yearDelta = date2.year - date1.year;
    NSInteger monthDelta = date2.month - date1.month;
    
    NSInteger delta = ABS(yearDelta) * 12 + 1;
    
    if ((yearDelta < 0 && monthDelta > 0) || (yearDelta > 0 && monthDelta < 0)) {
        delta -= ABS(monthDelta);
    } else {
        delta += ABS(monthDelta);
    }
    
    return delta;
}

@end
