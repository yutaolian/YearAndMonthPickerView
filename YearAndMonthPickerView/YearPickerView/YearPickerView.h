//
//  YearPickerView.h
//  yyg
//
//  Created by lyt on 6/21/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedYearBlock)(NSString *year);

@interface YearPickerView : UIPickerView<UIPickerViewDelegate, UIPickerViewDataSource>


@property(nonatomic,copy)SelectedYearBlock selectedYearBlock;
@end
