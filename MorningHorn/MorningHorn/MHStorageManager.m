//
//  MHStorageManager.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/8.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHStorageManager.h"

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

- (void)saveNewAlarm:(MHAlarm *)alram
{
    if([userDefault objectForKey:@"data"]) {
        
    } else {
        
    }
}

- (void)deleteAlarmWithAlarmId:(NSInteger)alarmId
{
    
}

- (void)changeAlarmState:(BOOL)state
{
    
}

@end
