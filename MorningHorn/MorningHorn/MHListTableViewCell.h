//
//  MHListTableViewCell.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHAlarm.h"
#import "MHHeader.h"
#import "MHWeekDayThumbnailView.h"

@interface MHListTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) MHAlarm *alarmModel;
@property (nonatomic,strong) MHWeekDayThumbnailView *weekDayView;

@end
