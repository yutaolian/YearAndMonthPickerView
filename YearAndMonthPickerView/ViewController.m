//
//  ViewController.m
//  YearAndMonthPickerView
//
//  Created by cosmistar on 8/4/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "ViewController.h"
#import "CalendarView.h"

#import "CalendarViewOfYear.h"

@interface ViewController (){}

@property(nonatomic,strong) CalendarView *calendarView;
@property(nonatomic,strong) CalendarViewOfYear *calendarViewOfYear;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Test";
    
    [self.view addSubview:self.calendarView];
    
    [self.view addSubview:self.calendarViewOfYear];

}

- (CalendarView *)calendarView{
    if (!_calendarView) {
        
        _calendarView = [[CalendarView alloc] init];
        _calendarView.frame = CGRectMake(100, 110, 125, 167);
        _calendarView.changeYearAndMonthBlock = ^(NSString *year,NSString *month){
            
            NSLog(@"year--%@, month---%@",year,month);
        };
    }
    return _calendarView;
}

- (CalendarViewOfYear *)calendarViewOfYear{
    if (!_calendarViewOfYear) {
        
        _calendarViewOfYear = [[CalendarViewOfYear alloc] init];
        _calendarViewOfYear.frame = CGRectMake(100, 300, 125, 167);
        
        _calendarViewOfYear.changeYearBlock = ^(NSString *year){
            NSLog(@"year---%@",year);
        };
    }
    return _calendarViewOfYear;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
