//
//  YearAndMonthPickerView.m
//  yyg
//
//  Created by lyt on 6/21/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "YearAndMonthPickerView.h"

#define MONTH ( 1 )
#define YEAR ( 0 )


// Identifies for component views
#define LABEL_TAG 43


@interface YearAndMonthPickerView(){
    
    NSInteger _oldYear;
    NSInteger _oldMonth;
}

@property (nonatomic, strong) NSIndexPath *todayIndexPath;
@property (nonatomic, strong) NSArray *months;
@property (nonatomic, strong) NSMutableArray *years;



@end

@implementation YearAndMonthPickerView

const NSInteger bigRowCount = 1000;
const NSInteger minYear = 2016;
const NSInteger maxYear = 2026;
const CGFloat rowHeight = 40.f;
const NSInteger numberOfComponents = 2;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.months = [self months];
        self.years = [self years];
        self.todayIndexPath = [self todayPath];
        self.delegate = self;
        self.dataSource = self;
        
        self.layer.cornerRadius = 8;
        self.backgroundColor = [UIColor grayColor];
        
        [self selectToday];
    }
    return self;
}

#pragma mark - UIPickerViewDelegate

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return [self componentWidth];
}

-(UIView *)pickerView: (UIPickerView *)pickerView
           viewForRow: (NSInteger)row
         forComponent: (NSInteger)component
          reusingView: (UIView *)view
{
    BOOL selected = NO;
    if(component == MONTH)
    {
        NSInteger monthCount = [self.months count];
        NSString *monthName = [self.months objectAtIndex:(row % monthCount)];
        NSString *currentMonthName = [self currentMonthName];
        if([monthName isEqualToString:currentMonthName] == YES)
        {
            selected = YES;
        }
    }
    else
    {
        NSInteger yearCount = [self.years count];
        NSString *yearName = [self.years objectAtIndex:(row % yearCount)];
        NSString *currenrYearName  = [self currentYearName];
        if([yearName isEqualToString:currenrYearName] == YES)
        {
            selected = YES;
        }
    }
    
    UILabel *returnView = nil;
    if(view.tag == LABEL_TAG)
    {
        returnView = (UILabel *)view;
    }
    else
    {
        returnView = [self labelForComponent: component selected: selected];
    }
    
    //    returnView.textColor = selected ? [UIColor blackColor] : [UIColor blackColor];
    returnView.text = [self titleForRow:row forComponent:component];
    return returnView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return rowHeight;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return numberOfComponents;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == MONTH)
    {
        return [self bigRowMonthCount];
    }
    return [self bigRowYearCount];
}

#pragma mark - Util

-(NSInteger)bigRowMonthCount
{
    return [self.months count]  * bigRowCount;
}

-(NSInteger)bigRowYearCount
{
    return [self.years count]  * bigRowCount;
}

-(CGFloat)componentWidth
{
    return self.bounds.size.width / numberOfComponents;
}

-(NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == MONTH)
    {
        NSInteger monthCount = [self.months count];
        return [self.months objectAtIndex:(row % monthCount)];
    }
    NSInteger yearCount = [self.years count];
    return [self.years objectAtIndex:(row % yearCount)];
}

-(UILabel *)labelForComponent:(NSInteger)component selected:(BOOL)selected
{
    CGRect frame = CGRectMake(0, 0, [self componentWidth],rowHeight);
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;
    //label.backgroundColor = [UIColor colorWithHexString:@"31384a"];
    
    label.backgroundColor = [UIColor clearColor];
    // label.textColor = selected ? [UIColor whiteColor] : [UIColor whiteColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.tag = LABEL_TAG;
    
    return label;
}

-(NSArray *)months
{
    return @[@"01月", @"02月", @"03月", @"04月", @"05月", @"06月", @"07月", @"08月", @"09月", @"10月", @"11月", @"12月"];
}

-(NSArray *)years
{
    if (!_years) {
        _years = [NSMutableArray array];
        for(NSInteger year = minYear; year <= maxYear; year++){
            NSString *yearStr = [NSString stringWithFormat:@"%ld年", year];
            [_years addObject:yearStr];
        }
    }
    return _years;
}

-(void)selectToday
{
    [self selectRow: self.todayIndexPath.row
        inComponent: MONTH
           animated: NO];
    
    [self selectRow: self.todayIndexPath.section
        inComponent: YEAR
           animated: NO];
}

//选择指定日期
-(void)selectDay:(NSDate *)theDate
{
    CGFloat row = 0.f;
    CGFloat section = 0.f;
    
    NSString *month = [self selectedMonthName:theDate];
    NSString *year  = [self selectedYearName:theDate];
    
    //set table on the middle
    for(NSString *cellMonth in self.months)
    {
        if([cellMonth isEqualToString:month])
        {
            row = [self.months indexOfObject:cellMonth];
            row = row + [self bigRowMonthCount] / 2;
            
            _oldMonth = row;
            break;
        }
    }
    
    for(NSString *cellYear in self.years)
    {
        if([cellYear isEqualToString:year])
        {
            section = [self.years indexOfObject:cellYear];
            section = section + [self bigRowYearCount] / 2;
            
            _oldYear = section;
            break;
        }
    }
    
    [self selectRow: row
        inComponent: MONTH
           animated: NO];
    
    [self selectRow: section
        inComponent: YEAR
           animated: NO];
    
}

-(NSIndexPath *)todayPath // row - month ; section - year
{
    CGFloat row = 0.f;
    CGFloat section = 0.f;
    
    NSString *month = [self currentMonthName];
    NSString *year  = [self currentYearName];
    
    //set table on the middle
    for(NSString *cellMonth in self.months)
    {
        if([cellMonth isEqualToString:month])
        {
            row = [self.months indexOfObject:cellMonth];
            row = row + [self bigRowMonthCount] / 2;
            _oldMonth = row;
            break;
        }
    }
    
    for(NSString *cellYear in self.years)
    {
        if([cellYear isEqualToString:year])
        {
            section = [self.years indexOfObject:cellYear];
            section = section + [self bigRowYearCount] / 2;
            
            _oldYear = section;
            break;
        }
    }
    
    return [NSIndexPath indexPathForRow:row inSection:section];
}

-(NSString *)currentMonthName
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    [formatter setDateFormat:@"MM"];
    return [NSString stringWithFormat:@"%@月",[formatter stringFromDate:[NSDate date]]];
}

-(NSString *)currentYearName
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    return [NSString stringWithFormat:@"%@年",[formatter stringFromDate:[NSDate date]]];
}

-(NSString *)selectedMonthName:(NSDate *)theDate
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    [formatter setDateFormat:@"MM"];
    return [NSString stringWithFormat:@"%@月",[formatter stringFromDate:[NSDate date]]];
}

-(NSString *)selectedYearName:(NSDate *)theDate
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    return [NSString stringWithFormat:@"%@年",[formatter stringFromDate:[NSDate date]]];}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *year = 0;
    NSString *month = 0;
    
    if (component == 1) {
        month = [self.months objectAtIndex:row%12];
        year = [self.years objectAtIndex:_oldYear%(self.years.count)];
        _oldMonth = row;
    }else{
        year = [self.years objectAtIndex:row%(self.years.count)] ;
        month = [self.months objectAtIndex:_oldMonth%12];
        _oldYear = row;
    }
    
    if (_selectedYearAndMonthBlock) {
        _selectedYearAndMonthBlock(year,month);
    }
    
    NSLog(@"%@--%@",year,month);
    
}


@end
