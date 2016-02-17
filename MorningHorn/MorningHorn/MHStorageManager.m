//
//  MHStorageManager.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/8.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHStorageManager.h"
#import "MHLocalNotificationManager.h"

@interface MHStorageManager()
{
    NSUserDefaults *userDefault;
}
@end

@implementation MHStorageManager

+ (MHStorageManager *) sharedInstance
{
    static dispatch_once_t  onceToken;
    static MHStorageManager * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MHStorageManager alloc]init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        userDefault = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)saveNewAlarm:(MHAlarm *)alarm
{
    if([userDefault objectForKey:@"data"]) {
        NSMutableDictionary *dataDictionary = [[userDefault objectForKey:@"data"] mutableCopy];
        [dataDictionary setObject:[alarm serializedString] forKey:alarm.alarmId];
        [[MHLocalNotificationManager sharedInstance] registerAlarm:alarm];
        [userDefault setValue:dataDictionary forKey:@"data"];
    } else {
        NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionary];
        [dataDictionary setObject:[alarm serializedString] forKey:alarm.alarmId];
        [[MHLocalNotificationManager sharedInstance] registerAlarm:alarm];
        [userDefault setObject:dataDictionary forKey:@"data"];
    }
}

- (void)deleteAlarmWithAlarmId:(NSString *)alarmId
{
    if([userDefault objectForKey:@"data"]) {
        NSMutableDictionary *dataDictionary = [[userDefault objectForKey:@"data"] mutableCopy];
        [dataDictionary removeObjectForKey:alarmId];
        [[MHLocalNotificationManager sharedInstance] cancelAlarm:alarmId];
        [userDefault setValue:dataDictionary forKey:@"data"];
    }
}

- (void)changeAlarmState:(BOOL)state alarmId:(NSString *)alarmId
{
    if([userDefault objectForKey:@"data"]) {
        NSMutableDictionary *dataDictionary = [[userDefault objectForKey:@"data"] mutableCopy];
        MHAlarm *t = [MHAlarm alarmWithSerializedString:[dataDictionary objectForKey:alarmId]];
        t.selected = state;
        [dataDictionary setValue:[t serializedString] forKey:alarmId];
        [userDefault setValue:dataDictionary forKey:@"data"];
        
        if(state) {
            [[MHLocalNotificationManager sharedInstance] registerAlarm:t];
        } else {
            [[MHLocalNotificationManager sharedInstance] cancelAlarm:alarmId];
        }
    }
}

- (NSMutableArray *)getAlarmArray
{
    if([userDefault objectForKey:@"data"]) {
        NSMutableDictionary *dataDictionary = [userDefault objectForKey:@"data"];
        NSMutableArray *resultArray = [NSMutableArray array];
        for(NSString *key in dataDictionary.allKeys) {
            MHAlarm *tmp = [MHAlarm alarmWithSerializedString:[dataDictionary objectForKey:key]];
            [resultArray addObject:tmp];
        }
        return resultArray;
    } else {
        return [NSMutableArray array];
    }
}

- (void)deleteAllAlarms
{
    [userDefault setValue:[NSMutableDictionary dictionary] forKey:@"data"];
}
@end
