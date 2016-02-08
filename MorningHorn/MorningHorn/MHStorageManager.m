//
//  MHStorageManager.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/8.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHStorageManager.h"

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

@end
