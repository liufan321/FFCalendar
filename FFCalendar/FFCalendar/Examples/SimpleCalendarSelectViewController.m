//
//  SimpleCalendarSelectViewController.m
//  FFCalendar
//
//  Created by 刘凡 on 2016/7/25.
//  Copyright © 2016年 joyios. All rights reserved.
//

#import "SimpleCalendarSelectViewController.h"
#import "FFCalendarView.h"

@interface SimpleCalendarSelectViewController ()

@end

@implementation SimpleCalendarSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    FFCalendarView *calendarView = [FFCalendarView new];
    [self.view addSubview:calendarView];
    
    calendarView.translatesAutoresizingMaskIntoConstraints = NO;
    id topLayoutGuide = self.topLayoutGuide;
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(calendarView, topLayoutGuide);
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[calendarView]-0-|"
                                             options:0
                                             metrics:nil
                                               views:viewDict]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[topLayoutGuide]-0-[calendarView(300)]"
                                             options:0
                                             metrics:nil
                                               views:viewDict]];
}

@end
