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
        _weekday = components.weekday - 1;
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

- (instancetype)nextWeekDate {
    if (_date == nil) {
        return  nil;
    }
    
    return [FFCalendarDate dateWithYear:_year month:_month day:(_day + 7)];
}

- (instancetype)previousWeekDate {
    if (_date == nil) {
        return nil;
    }
    
    return [FFCalendarDate dateWithYear:_year month:_month day:(_day - 7)];
}

- (instancetype)firstWeekday {
    if (_date == nil) {
        return nil;
    }
    
    return [FFCalendarDate dateWithYear:_year month:_month day:_day - _weekday];
}

- (instancetype)lastWeekDay {
    if (_date == nil) {
        return nil;
    }
    
    return [FFCalendarDate dateWithYear:_year month:_month day:(_day - _weekday + 6)];
}

#pragma mark - 类方法
+ (NSArray<NSString *> *)weekdaySymbols {
    return calendar.shortWeekdaySymbols;
}

+ (NSArray<FFCalendarDate *> *)dateArrayInWeekWithDate:(FFCalendarDate *)date {
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    FFCalendarDate *day = [self dateWithYear:date.year month:date.month day:(date.day - date.weekday)];
    
    for (NSInteger i = 0; i < 7; i++) {
        if (day == nil) {
            break;
        }
        
        [arrayM addObject:day];
        day = day.nextDate;
    }
    
    return arrayM.copy;
}

+ (NSArray<FFCalendarDate *> *)dateArrayInMonthWithDate:(FFCalendarDate *)date {
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    FFCalendarDate *firstDay = [self dateWithYear:date.year month:date.month day:1];
    FFCalendarDate *day = [self dateWithYear:firstDay.year month:firstDay.month day:(firstDay.day - firstDay.weekday)];
    
    for (NSInteger i = 0; i < 42; i++) {
        if (day == nil || (day.month != firstDay.month && i > 0 && day.weekday == 0)) {
            break;
        }
        
        [arrayM addObject:day];
        day = day.nextDate;
    }
    
    return arrayM.copy;
}

+ (NSArray<FFCalendarDate *> *)dateArrayWithYear:(NSInteger)year month:(NSInteger)month {
    
    FFCalendarDate *firstDay = [self dateWithYear:year month:month day:1];
    
    return [self dateArrayInMonthWithDate:firstDay];
}

+ (NSInteger)weekDifferenceBetweenDate1:(FFCalendarDate *)date1 andDate2:(FFCalendarDate *)date2 {
    
    FFCalendarDate *firstDay = nil;
    FFCalendarDate *lastDate = nil;
    
    if ([date1.date compare:date2.date] == NSOrderedAscending) {
        firstDay = date1.firstWeekday;
        lastDate = date2.lastWeekDay;
    } else {
        firstDay = date2.firstWeekday;
        lastDate = date1.lastWeekDay;
    }
    
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:firstDay.date toDate:lastDate.date options:0];
    
    return (components.day + 1) / 7;
}

+ (NSInteger)monthDifferenceBetweenDate1:(FFCalendarDate *)date1 andDate2:(FFCalendarDate *)date2 {
    
    FFCalendarDate *firstDay = nil;
    FFCalendarDate *lastDate = nil;
    
    if ([date1.date compare:date2.date] == NSOrderedAscending) {
        firstDay = date1;
        lastDate = date2;
    } else {
        firstDay = date2;
        lastDate = date1;
    }
    
    NSInteger yearDelta = lastDate.year - firstDay.year;
    NSInteger monthDelta = lastDate.month - firstDay.month;
    
    return yearDelta * 12 + monthDelta + 1;
}

@end
