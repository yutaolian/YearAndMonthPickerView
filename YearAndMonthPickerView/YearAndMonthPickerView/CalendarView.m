//
//  CalendarView.m
//  yyg
//
//  Created by lyt on 6/21/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "CalendarView.h"
#import "YearAndMonthPickerView.h"

@interface CalendarView(){}

@property(nonatomic,strong) UIImageView *triangleImageView;
@property(nonatomic,strong) YearAndMonthPickerView *pickerView;

@end

@implementation CalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor  = [UIColor greenColor];
//        self.backgroundColor  = kRandomColor;
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews{
    
    [self addSubview:self.triangleImageView];
    [self addSubview:self.pickerView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_triangleImageView(7)][_pickerView(160)]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_triangleImageView,_pickerView)]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[_triangleImageView(14)]-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_triangleImageView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_pickerView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_pickerView)]];
    
    
}

- (UIImageView *)triangleImageView{
    
    if (!_triangleImageView) {
        _triangleImageView = [[UIImageView alloc] init];
        _triangleImageView.translatesAutoresizingMaskIntoConstraints = NO;

        _triangleImageView.image = [UIImage imageNamed:@"triangle"];
    }
    return _triangleImageView;
}

- (YearAndMonthPickerView *)pickerView{
    
    if (!_pickerView) {
        _pickerView = [[YearAndMonthPickerView alloc] init];
        _pickerView.translatesAutoresizingMaskIntoConstraints = NO;
        
        __weak CalendarView *weakSelf = self;
        _pickerView.selectedYearAndMonthBlock = ^(NSString *year,NSString *month){
            if (weakSelf.changeYearAndMonthBlock) {
                weakSelf.changeYearAndMonthBlock(year,month);
            }
        };
    }
    return _pickerView;
    
}

@end
