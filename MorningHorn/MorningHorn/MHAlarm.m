//
//  MHAlarm.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHAlarm.h"

@implementation MHAlarm

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        // Putting default values into properties
        
        self.timeString = [MHTimeString timeStringWithHour:0 minute:0];
        self.weekDayArray = [NSMutableArray array];
        self.soundName = @"";
        self.snoozeTime = 0;
        self.alarmId = [NSDate timeIntervalSinceReferenceDate];
        self.selected = YES;
    }
    return self;
}
@end
