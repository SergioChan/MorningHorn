//
//  MHTimeString.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHTimeString.h"

@implementation MHTimeString

+ (instancetype)timeStringWithHour:(NSInteger)hour minute:(NSInteger)minute
{
    return [[self alloc]initWithHour:hour minute:minute];
}

- (instancetype)initWithHour:(NSInteger)hour minute:(NSInteger)minute
{
    self = [super init];
    if(self)
    {
        self.hour = hour;
        self.minute = minute;
    }
    return self;
}
@end
