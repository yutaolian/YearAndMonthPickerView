//
//  CalendarView.m
//  yyg
//
//  Created by lyt on 6/21/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import "CalendarViewOfYear.h"
#import "YearPickerView.h"

@interface CalendarViewOfYear(){}

@property(nonatomic,strong) UIImageView *triangleImageView;
@property(nonatomic,strong) YearPickerView *pickerView;

@end

@implementation CalendarViewOfYear

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor  = [UIColor greenColor];
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

- (YearPickerView *)pickerView{
    
    if (!_pickerView) {
        _pickerView = [[YearPickerView alloc] init];
        _pickerView.translatesAutoresizingMaskIntoConstraints = NO;
        
        __weak CalendarViewOfYear *weakSelf = self;
        _pickerView.selectedYearBlock = ^(NSString *year){
            if (weakSelf.changeYearBlock) {
                weakSelf.changeYearBlock(year);
            }
        };
    }
    return _pickerView;
    
}

@end
