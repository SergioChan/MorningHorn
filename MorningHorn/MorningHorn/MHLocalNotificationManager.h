//
//  MHLocalNotificationManager.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MHAlarm.h"
#import "MHHeader.h"

@interface MHLocalNotificationManager : NSObject

+ (MHLocalNotificationManager *) sharedInstance;

- (void)registerAlarm:(MHAlarm *)alarm;
- (void)cancelAlarm:(NSInteger)alarmId;
@end
