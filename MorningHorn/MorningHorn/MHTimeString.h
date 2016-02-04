//
//  MHTimeString.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHTimeString : NSObject

@property (nonatomic) NSInteger hour;
@property (nonatomic) NSInteger minute;

+ (instancetype)timeStringWithHour:(NSInteger)hour minute:(NSInteger)minute;

@end
