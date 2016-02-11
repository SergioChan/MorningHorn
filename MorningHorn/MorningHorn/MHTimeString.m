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

+ (instancetype)timeStringWithSerializedString:(NSString *)string
{
    NSRange range = [string rangeOfString:@":"];
    if(range.length == 0) {
        return [[self alloc]initWithHour:0 minute:0];
    } else {
        NSInteger hour = [[string substringToIndex:range.location] integerValue];
        NSInteger minute = [[string substringFromIndex:range.location + 1] integerValue];
        return [[self alloc]initWithHour:hour minute:minute];
    }
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

- (NSString *)serializedString
{
    return [NSString stringWithFormat:@"%ld:%ld",self.hour,self.minute];
}

@end
