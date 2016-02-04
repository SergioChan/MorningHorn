//
//  MHLocalNotificationManager.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHLocalNotificationManager.h"

@implementation MHLocalNotificationManager

+ (MHLocalNotificationManager *) sharedInstance
{
    static dispatch_once_t  onceToken;
    static MHLocalNotificationManager * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MHLocalNotificationManager alloc]init];
    });
    return sharedInstance;
}

- (void)registerNewAlarm:(MHAlarm *)alarm
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil)
    {
        NSDate *now=[NSDate new];
        
        notification.fireDate = [now dateByAddingTimeInterval:5];
        notification.timeZone=[NSTimeZone systemTimeZone];
        
        if(![alarm.soundName isEqualToString:@""]) notification.soundName = alarm.soundName;
        else notification.soundName = UILocalNotificationDefaultSoundName;
        
        notification.applicationIconBadgeNumber = 0;
        
        notification.alertAction = @"Open"; 
        notification.hasAction = YES;
        notification.alertBody = [NSString stringWithFormat:@"Horn is rising!"];
        
        NSDictionary* info = [NSDictionary dictionaryWithObjects:@[@(alarm.alarmId),alarm] forKeys:@[@"id",@"object"]];
        notification.userInfo = info;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

- (void)cancelAlarmWithId:(NSInteger)alarmId
{
    
}

@end
