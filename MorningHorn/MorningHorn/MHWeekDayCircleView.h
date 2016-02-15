//
//  MHWeekDayCircleView.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/14.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHHeader.h"
#import "MHAlarm.h"
#import "UIView+Shadow.h"

@interface MHWeekDayCircleView : UIButton

@property (nonatomic,strong) UIView         *circleView;
@property (nonatomic,strong) UILabel        *selectedView;
@property (nonatomic,strong) UIView         *selectedBackView;
@property (nonatomic,strong) UIImageView    *shadowView;
@property (nonatomic) BOOL                  mh_selected;
@property (nonatomic) MHWeekDay             dayType;

- (instancetype)initWithFrame:(CGRect)frame dayType:(MHWeekDay)type;
- (void)mh_setSelected:(BOOL)selected;

@end
