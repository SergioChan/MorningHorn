//
//  MHAlarm.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTimeString.h"

@interface MHAlarm : NSObject

@property (nonatomic,strong) MHTimeString *timeString;
@property (nonatomic,strong) NSMutableArray *weekDayArray;
@property (nonatomic,strong) NSString *soundName;
@property (nonatomic) NSInteger snoozeTime;
@property (nonatomic) NSInteger alarmId;

@end
