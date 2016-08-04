//
//  YearAndMonthPickerView.h
//  yyg
//
//  Created by lyt on 6/21/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedYearAndMonthBlock)(NSString *year,NSString *month);

@interface YearAndMonthPickerView : UIPickerView<UIPickerViewDelegate, UIPickerViewDataSource>


@property(nonatomic,copy)SelectedYearAndMonthBlock selectedYearAndMonthBlock;

@end
