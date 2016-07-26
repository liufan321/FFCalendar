//
//  FFCalendarDateTests.m
//  FFCalendar
//
//  Created by 刘凡 on 2016/7/25.
//  Copyright © 2016年 joyios. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FFCalendarDate.h"

@interface FFCalendarDateTests : XCTestCase

@end

@implementation FFCalendarDateTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testWeekDay {
    {
        FFCalendarDate *date = [FFCalendarDate dateWithDate:[NSDate date]];
        
        XCTAssert(date.firstWeekday.weekday == 0);
        XCTAssert(date.lastWeekDay.weekday == 6);
    }
}

/**
 * 测试指定日期的一周数组
 */
- (void)testDateArrayInWeek {
    
    {
        FFCalendarDate *date = [FFCalendarDate dateWithDate:[NSDate date]];
        NSArray <FFCalendarDate *>*array = [FFCalendarDate dateArrayInWeekWithDate:date];
        
        XCTAssert(array.count == 7);
        XCTAssert(array.firstObject.weekday == 0 && array.lastObject.weekday == 6);
        
        NSLog(@"%@", array);
    }
    {
        FFCalendarDate *date = [FFCalendarDate dateWithYear:2016 month:1 day:1];
        NSArray <FFCalendarDate *>*array = [FFCalendarDate dateArrayInWeekWithDate:date];
        
        XCTAssert(array.count == 7);
        XCTAssert(array.firstObject.weekday == 0 && array.lastObject.weekday == 6);
        
        NSLog(@"%@", array);
    }
    {
        FFCalendarDate *date = [FFCalendarDate dateWithYear:2016 month:1 day:31];
        NSArray <FFCalendarDate *>*array = [FFCalendarDate dateArrayInWeekWithDate:date];
        
        XCTAssert(array.count == 7);
        XCTAssert(array.firstObject.weekday == 0 && array.lastObject.weekday == 6);
        
        NSLog(@"%@", array);
    }
}

/**
 * 测试指定日期的一月数组
 */
- (void)testDateArrayInMonth {
    {
        FFCalendarDate *date = [FFCalendarDate dateWithDate:[NSDate date]];
        NSArray <FFCalendarDate *>*array = [FFCalendarDate dateArrayInMonthWithDate:date];
        
        XCTAssert(array.count == 42);
        XCTAssert(array.firstObject.weekday == 0 && array.lastObject.weekday == 6);
        
        NSLog(@"%@", array);
    }
    {
        FFCalendarDate *date = [FFCalendarDate dateWithYear:2016 month:1 day:1];
        NSArray <FFCalendarDate *>*array = [FFCalendarDate dateArrayInMonthWithDate:date];
        
        XCTAssert(array.count == 42);
        XCTAssert(array.firstObject.weekday == 0 && array.lastObject.weekday == 6);
        
        NSLog(@"%@", array);
    }
    {
        FFCalendarDate *date = [FFCalendarDate dateWithYear:2015 month:12 day:1];
        NSArray <FFCalendarDate *>*array = [FFCalendarDate dateArrayInMonthWithDate:date];
        
        XCTAssert(array.count == 35);
        XCTAssert(array.firstObject.weekday == 0 && array.lastObject.weekday == 6);
        
        NSLog(@"%@", array);
    }
}

/**
 * 测试生成当月日期数组
 */
- (void)testDateArrayWithYearAndMonth {
    
    for (NSInteger month = 1; month <= 12; month++) {
        NSArray *array = [FFCalendarDate dateArrayWithYear:2016 month:month];
        
        if (month == 1 || month == 7 || month == 10) {
            XCTAssert(array.count == 42, "%zd should be %zd", month, array.count);
        } else {
            XCTAssert(array.count == 35, "%zd should be %zd", month, array.count);
        }
    }
    
    for (NSInteger month = 1; month <= 12; month++) {
        NSArray *array = [FFCalendarDate dateArrayWithYear:2017 month:month];
        
        if (month == 4 || month == 7 || month == 12) {
            XCTAssert(array.count == 42, "%zd should be %zd", month, array.count);
        } else {
            XCTAssert(array.count == 35, "%zd should be %zd", month, array.count);
        }
    }
}

/**
 * 测试两个日期之间的星期差值
 */
- (void)testWeekDiffence {
    
    {
        FFCalendarDate *date1 = [FFCalendarDate dateWithDate:[NSDate date]];
        FFCalendarDate *date2 = date1.nextWeekDate;
        
        XCTAssert([FFCalendarDate weekDifferenceBetweenDate1:date1 andDate2:date2] == 2);
    }
    {
        FFCalendarDate *date1 = [FFCalendarDate dateWithDate:[NSDate date]];
        FFCalendarDate *date2 = date1.previousWeekDate;
        
        XCTAssert([FFCalendarDate weekDifferenceBetweenDate1:date1 andDate2:date2] == 2);
    }
    {
        FFCalendarDate *date1 = [FFCalendarDate dateWithYear:2016 month:7 day:26];
        FFCalendarDate *date2 = date1.nextDate;
        
        XCTAssert([FFCalendarDate weekDifferenceBetweenDate1:date1 andDate2:date2] == 1);
    }
    {
        FFCalendarDate *date1 = [FFCalendarDate dateWithYear:2016 month:7 day:26];
        FFCalendarDate *date2 = date1.previousDate;
        
        XCTAssert([FFCalendarDate weekDifferenceBetweenDate1:date1 andDate2:date2] == 1);
    }
}

/**
 * 测试两个日期之间的月度差值
 */
- (void)testMonthDiffence {
    {
        FFCalendarDate *date1 = [FFCalendarDate dateWithYear:2016 month:1 day:31];
        FFCalendarDate *date2 = [FFCalendarDate dateWithYear:2016 month:2 day:1];
        XCTAssert([FFCalendarDate monthDifferenceBetweenDate1:date1 andDate2:date2] == 2);
    }
    {
        FFCalendarDate *date1 = [FFCalendarDate dateWithYear:2016 month:2 day:1];
        FFCalendarDate *date2 = [FFCalendarDate dateWithYear:2016 month:2 day:1];
        XCTAssert([FFCalendarDate monthDifferenceBetweenDate1:date1 andDate2:date2] == 1);
    }
    {
        FFCalendarDate *date1 = [FFCalendarDate dateWithYear:2016 month:2 day:1];
        FFCalendarDate *date2 = [FFCalendarDate dateWithYear:2016 month:2 day:28];
        XCTAssert([FFCalendarDate monthDifferenceBetweenDate1:date1 andDate2:date2] == 1);
    }
    {
        FFCalendarDate *date1 = [FFCalendarDate dateWithYear:2016 month:2 day:1];
        FFCalendarDate *date2 = [FFCalendarDate dateWithYear:2016 month:3 day:1];
        XCTAssert([FFCalendarDate monthDifferenceBetweenDate1:date1 andDate2:date2] == 2);
    }
    {
        FFCalendarDate *date1 = [FFCalendarDate dateWithYear:2016 month:2 day:1];
        FFCalendarDate *date2 = [FFCalendarDate dateWithYear:2016 month:3 day:31];
        XCTAssert([FFCalendarDate monthDifferenceBetweenDate1:date1 andDate2:date2] == 2);
    }
    {
        FFCalendarDate *date1 = [FFCalendarDate dateWithYear:2016 month:2 day:1];
        FFCalendarDate *date2 = [FFCalendarDate dateWithYear:2016 month:1 day:31];
        XCTAssert([FFCalendarDate monthDifferenceBetweenDate1:date1 andDate2:date2] == 2);
    }
    {
        for (NSInteger month = 0; month <= 12; month++) {
            
            FFCalendarDate *date1 = [FFCalendarDate dateWithYear:2016 month:1 day:1];
            FFCalendarDate *date2 = [FFCalendarDate dateWithYear:2015 month:month day:1];
            
            XCTAssert([FFCalendarDate monthDifferenceBetweenDate1:date1 andDate2:date2] == (14 - month));
        }
    }
    {
        for (NSInteger month = -24; month <= 24; month++) {
            
            FFCalendarDate *date1 = [FFCalendarDate dateWithYear:2015 month:1 day:1];
            FFCalendarDate *date2 = [FFCalendarDate dateWithYear:2015 month:month day:28];
            
            if (month <= 0) {
                XCTAssert([FFCalendarDate monthDifferenceBetweenDate1:date1 andDate2:date2] == ABS(month) + 2);
            } else {
                XCTAssert([FFCalendarDate monthDifferenceBetweenDate1:date1 andDate2:date2] == month);
            }
        }
    }
}

@end
