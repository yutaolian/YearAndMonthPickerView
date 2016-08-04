//
//  CalendarView.h
//  yyg
//
//  Created by lyt on 6/21/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeYearAndMonthBlock)(NSString *year,NSString *month);

@interface CalendarView : UIView

@property(nonatomic,copy)  ChangeYearAndMonthBlock changeYearAndMonthBlock;
@end
