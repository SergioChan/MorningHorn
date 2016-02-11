//
//  MHAlarm.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHAlarm.h"

@implementation MHAlarm

+ (instancetype)alarmWithSerializedString:(NSString *)string
{
    NSError *error = nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if ([jsonObject isKindOfClass:[NSDictionary class]] && error == nil) {
        NSDictionary *jsonDictionary = (NSDictionary*)jsonObject;
        
        MHAlarm *alarm = [[self alloc]init];
        alarm.timeString = [MHTimeString timeStringWithSerializedString:[jsonDictionary objectForKey:@"timeString"]];
        alarm.weekDayArray = [jsonDictionary objectForKey:@"weekDayArray"];
        alarm.soundName = [jsonDictionary objectForKey:@"soundName"];
        alarm.snoozeTime = [[jsonDictionary objectForKey:@"snoozeTime"] integerValue];
        alarm.alarmId = [[jsonDictionary objectForKey:@"alarmId"] integerValue];
        alarm.selected = [[jsonDictionary objectForKey:@"selected"] boolValue];
        
        return alarm;
    } else {
        return [[self alloc] init];
    }
}

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

- (NSString *)serializedString
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [dictionary setObject:[self.timeString serializedString] forKey:@"timeString"];
    [dictionary setObject:self.weekDayArray forKey:@"weekDayArray"];
    [dictionary setObject:self.soundName forKey:@"soundName"];
    [dictionary setObject:@(self.snoozeTime) forKey:@"snoozeTime"];
    [dictionary setObject:@(self.alarmId) forKey:@"alarmId"];
    [dictionary setObject:@(self.selected) forKey:@"selected"];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    if([jsonData length] > 0 && error == nil) {
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    } else {
        return @"";
    }
}


@end
