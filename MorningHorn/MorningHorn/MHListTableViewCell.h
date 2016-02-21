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
#import "MHSwitch.h"

@interface MHListTableViewCell : UITableViewCell

@property (nonatomic,copy) void (^didDeleteAlarm)(MHAlarm *alarm);

@property (nonatomic,strong) UILabel                    *dateLabel;
@property (nonatomic,strong) UIButton                   *deleteButton;

@property (nonatomic,strong) MHAlarm                    *alarmModel;
@property (nonatomic,strong) MHWeekDayThumbnailView     *weekDayView;
@property (nonatomic,strong) MHSwitch                   *alarmSwitch;

@end
