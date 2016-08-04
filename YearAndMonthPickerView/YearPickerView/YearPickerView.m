//
//  YearPickerView.m
//  yyg
//
//  Created by lyt on 6/21/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "YearPickerView.h"

@interface YearPickerView(){
    
    NSInteger _oldYear;
}
@property (nonatomic, strong) NSIndexPath *todayIndexPath;
@property (nonatomic, strong) NSMutableArray *years;

@end
#define LABEL_TAG_YEAR 53
#define YEAR_ONLY ( 0 )
@implementation YearPickerView

const NSInteger bigRowCount_year = 1000;
const NSInteger minYear_year = 2016;
const NSInteger maxYear_year = 2026;
const CGFloat rowHeight_year = 40.f;
const NSInteger numberOfComponents_year = 1;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.years = [self years];
        self.todayIndexPath = [self todayPath];
        
        self.delegate = self;
        self.dataSource = self;
        
        self.userInteractionEnabled = YES;
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
    NSInteger yearCount = [self.years count];
    NSString *yearName = [self.years objectAtIndex:(row % yearCount)];
    NSString *currenrYearName  = [self currentYearName];
    if([yearName isEqualToString:currenrYearName] == YES)
    {
        selected = YES;
    }
    
    UILabel *returnView = nil;
    if(view.tag == LABEL_TAG_YEAR)
    {
        returnView = (UILabel *)view;
    }
    else
    {
        returnView = [self labelForComponent: component selected: selected];
    }
    returnView.text = [self titleForRow:row forComponent:component];
    return returnView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return rowHeight_year;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return numberOfComponents_year;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self bigRowYearCount];
}

#pragma mark - Util

-(NSInteger)bigRowYearCount
{
    return [self.years count]  * bigRowCount_year;
}

-(CGFloat)componentWidth
{
    return self.bounds.size.width / numberOfComponents_year;
}

-(NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSInteger yearCount = [self.years count];
    return [self.years objectAtIndex:(row % yearCount)];
}

-(UILabel *)labelForComponent:(NSInteger)component selected:(BOOL)selected
{
    CGRect frame = CGRectMake(0, 0, [self componentWidth],rowHeight_year);
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;
    //    label.backgroundColor = [UIColor colorWithHexString:@"31384a"];
    
    label.backgroundColor = [UIColor clearColor];
    //    label.textColor = selected ? [UIColor whiteColor] : [UIColor whiteColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    
    label.tag = LABEL_TAG_YEAR;
    
    return label;
}
-(NSArray *)years
{
    if (!_years) {
        _years = [NSMutableArray array];
        for(NSInteger year = minYear_year; year <= maxYear_year; year++){
            NSString *yearStr = [NSString stringWithFormat:@"%ld年", year];
            [_years addObject:yearStr];
        }
    }
    return _years;
}

-(void)selectToday
{
    [self selectRow: self.todayIndexPath.section
        inComponent: YEAR_ONLY
           animated: NO];
}

//选择指定日期
//-(void)selectDay:(NSDate *)theDate
//{
//    //    CGFloat row = 0.f;
//    CGFloat section = 0.f;
//    NSString *year  = [self selectedYearName:theDate];
//    for(NSString *cellYear in self.years)
//    {
//        if([cellYear isEqualToString:year])
//        {
//            section = [self.years indexOfObject:cellYear];
//            section = section + [self bigRowYearCount] / 2;
//            break;
//        }
//    }
//    _oldYear = section;
//    [self selectRow: section
//        inComponent: YEAR
//           animated: NO];
//    
//}

-(NSIndexPath *)todayPath // row - month ; section - year
{
    CGFloat row = 0.f;
    CGFloat section = 0.f;
    NSString *year  = [self currentYearName];
    for(NSString *cellYear in self.years)
    {
        if([cellYear isEqualToString:year])
        {
            section = [self.years indexOfObject:cellYear];
            section = section + [self bigRowYearCount] / 2;
            break;
        }
    }
    _oldYear = section;
    return [NSIndexPath indexPathForRow:row inSection:section];
}

-(NSString *)currentYearName
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    return [NSString stringWithFormat:@"%@年",[formatter stringFromDate:[NSDate date]]];
}

-(NSString *)selectedYearName:(NSDate *)theDate
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    return [NSString stringWithFormat:@"%@年",[formatter stringFromDate:[NSDate date]]];}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *year = 0;
    
    if (component == 0) {
        year = [self.years objectAtIndex:row%(self.years.count)] ;
        _oldYear = row;
    }
    if (_selectedYearBlock) {
        _selectedYearBlock(year);
    }
    
    NSLog(@"%@-",year);
    
}


@end
