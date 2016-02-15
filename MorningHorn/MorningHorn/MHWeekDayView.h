//
//  MHWeekDayView.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHHeader.h"
#import "MHAlarm.h"
#import "MHWeekDayCircleView.h"

@interface MHWeekDayView : UIView

@property (nonatomic,strong) NSMutableArray *selectedWeekDayArray;

- (void)resetSelectState;
@end
