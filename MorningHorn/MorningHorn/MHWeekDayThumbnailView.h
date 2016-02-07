//
//  MHWeekDayThumbnailView.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHHeader.h"
#import "MHAlarm.h"
#import "MHWeekDayThumbnailCircleView.h"

@interface MHWeekDayThumbnailView : UIView

@property (nonatomic,strong) NSMutableArray *weekDayArray;

- (instancetype)initWithFrame:(CGRect)frame weekDayArray:(NSMutableArray *)array;
- (void)reloadDataByWeekDayArray:(NSMutableArray *)array;

@end
