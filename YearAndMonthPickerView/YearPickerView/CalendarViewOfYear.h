//
//  CalendarView.h
//  yyg
//
//  Created by lyt on 6/21/16.
//  Copyright © 2016 lyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeYearBlock)(NSString *year);

@interface CalendarViewOfYear : UIView

@property(nonatomic,copy)  ChangeYearBlock changeYearBlock;
@end
