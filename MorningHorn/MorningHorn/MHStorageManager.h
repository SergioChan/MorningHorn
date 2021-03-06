//
//  MHStorageManager.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/8.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHAlarm.h"

@interface MHStorageManager : NSObject

+ (MHStorageManager *) sharedInstance;

- (void)saveNewAlarm:(MHAlarm *)alarm;
- (void)deleteAlarmWithAlarmId:(NSString *)alarmId;
- (void)changeAlarmState:(BOOL)state alarmId:(NSString *)alarmId;
- (NSMutableArray *)getAlarmArray;
- (void)deleteAllAlarms;

@end
