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

- (void)registerAlarm:(MHAlarm *)alarm
{
    // According to this issue on http://stackoverflow.com/questions/21301964/uilocalnotification-set-repeatcalendar , you can only set either repeat daily (every day), monthly (every month) or hourly (every hour). So the only feasible solution for this issue is that if you want to set an alarm on Sunday, Monday and Tuesday then you have to set 3 alarms (one each for Sunday ,Monday and Tuesday) rather than one alarm.
    
    if(alarm.weekDayArray.count > 0) {
        // Repeatable
        for(id day in alarm.weekDayArray) {
            NSInteger value = [day integerValue];
            UILocalNotification *notification=[[UILocalNotification alloc] init];
            if (notification)
            {
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                NSDate *now = [NSDate date];
                NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear | NSCalendarUnitWeekOfYear|  NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate: now];
                
                [componentsForFireDate setWeekday:value];
                [componentsForFireDate setHour:alarm.timeString.hour];
                [componentsForFireDate setMinute:alarm.timeString.minute];
                [componentsForFireDate setSecond:0];
                
                NSDate *fireDateOfNotification = [calendar dateFromComponents: componentsForFireDate];
                
                notification = [self notificationWithFireDate:fireDateOfNotification notification:notification repeatable:YES alarm:alarm];
                
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            }
        }
    } else {
        // non-Repeatable, only create once
        UILocalNotification *notification=[[UILocalNotification alloc] init];
        if (notification)
        {
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDate *now = [NSDate date];
            NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear | NSCalendarUnitWeekOfYear|  NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate: now];
            
            [componentsForFireDate setHour:alarm.timeString.hour];
            [componentsForFireDate setMinute:alarm.timeString.minute];
            [componentsForFireDate setSecond:0];
            
            NSDate *fireDateOfNotification = [calendar dateFromComponents: componentsForFireDate];
            
            notification = [self notificationWithFireDate:fireDateOfNotification notification:notification repeatable:NO alarm:alarm];
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    }
}

- (void)cancelAlarm:(NSString *)alarmId
{
    NSMutableArray *noticationsToCancel = [NSMutableArray array];
    
    for(UILocalNotification *aNotif in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if([[aNotif.userInfo objectForKey:@"id"] isEqualToString:alarmId]) {
            [noticationsToCancel addObject:aNotif];
        }
    }
    for(UILocalNotification *aNotif in noticationsToCancel) {
        [[UIApplication sharedApplication] cancelLocalNotification:aNotif];
    }
}

#pragma mark - Utils

- (UILocalNotification *)notificationWithFireDate:(NSDate *)date notification:(UILocalNotification *)notification repeatable:(BOOL)repeatable alarm:(MHAlarm *)alarm
{
    notification.fireDate = date;
    notification.timeZone=[NSTimeZone systemTimeZone];
    
    if(![alarm.soundName isEqualToString:@""]) notification.soundName = alarm.soundName;
    else notification.soundName = UILocalNotificationDefaultSoundName;
    
    if(repeatable) {
        notification.repeatInterval = NSCalendarUnitWeekOfYear;
    }
    
    notification.applicationIconBadgeNumber = 0;
    
    notification.alertAction = @"Open";
    notification.hasAction = YES;
    notification.alertBody = [NSString stringWithFormat:NotificationTitle];
    
    NSDictionary* info = [NSDictionary dictionaryWithObjects:@[alarm.alarmId,alarm] forKeys:@[@"id",@"object"]];
    notification.userInfo = info;
    
    return notification;
}

@end
