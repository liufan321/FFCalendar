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
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 * 测试生成当月日期数组
 */
- (void)testDateArray {
    
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

@end
