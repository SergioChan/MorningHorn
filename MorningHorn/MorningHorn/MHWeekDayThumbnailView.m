//
//  MHWeekDayThumbnailView.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHWeekDayThumbnailView.h"

@interface MHWeekDayThumbnailView()

// Only for private access

@property (nonatomic,strong) UIView *MondayCircleView;
@property (nonatomic,strong) UIView *ThuesdayCircleView;
@property (nonatomic,strong) UIView *WednesdayCircleView;
@property (nonatomic,strong) UIView *ThursdayCircleView;
@property (nonatomic,strong) UIView *FridayCircleView;
@property (nonatomic,strong) UIView *SaturdayCircleView;
@property (nonatomic,strong) UIView *SundayCircleView;

@end

@implementation MHWeekDayThumbnailView

- (instancetype)initWithFrame:(CGRect)frame weekDayArray:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.MondayCircleView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.height, self.height)];
        _MondayCircleView.layer.cornerRadius = _MondayCircleView.height/2.0f;
    }
    return self;
}

- (void)reloadDataByWeekDayArray:(NSMutableArray *)array
{
    
}

@end
