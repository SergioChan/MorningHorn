//
//  MHWeekDayView.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHWeekDayView.h"

@interface MHWeekDayView()

@property (nonatomic,strong) MHWeekDayCircleView *MondayCircleView;
@property (nonatomic,strong) MHWeekDayCircleView *ThuesdayCircleView;
@property (nonatomic,strong) MHWeekDayCircleView *WednesdayCircleView;
@property (nonatomic,strong) MHWeekDayCircleView *ThursdayCircleView;
@property (nonatomic,strong) MHWeekDayCircleView *FridayCircleView;
@property (nonatomic,strong) MHWeekDayCircleView *SaturdayCircleView;
@property (nonatomic,strong) MHWeekDayCircleView *SundayCircleView;

@end

@implementation MHWeekDayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.selectedWeekDayArray = [NSMutableArray array];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    CGFloat margin = (self.width - 7 * self.height ) / 6.0f;
    
    self.MondayCircleView = [[MHWeekDayCircleView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.height, self.height) dayType:MHMonday];
    self.ThuesdayCircleView = [[MHWeekDayCircleView alloc]initWithFrame:CGRectMake(_MondayCircleView.right + margin, 0.0f, self.height, self.height) dayType:MHTuesDay];
    self.WednesdayCircleView = [[MHWeekDayCircleView alloc]initWithFrame:CGRectMake(_ThuesdayCircleView.right + margin, 0.0f, self.height, self.height) dayType:MHWednesday];
    self.ThursdayCircleView = [[MHWeekDayCircleView alloc]initWithFrame:CGRectMake(_WednesdayCircleView.right + margin, 0.0f, self.height, self.height) dayType:MHThursDay];
    self.FridayCircleView = [[MHWeekDayCircleView alloc]initWithFrame:CGRectMake(_ThursdayCircleView.right + margin, 0.0f, self.height, self.height) dayType:MHFriday];
    self.SaturdayCircleView = [[MHWeekDayCircleView alloc]initWithFrame:CGRectMake(_FridayCircleView.right + margin, 0.0f, self.height, self.height) dayType:MHSaturday];
    self.SundayCircleView = [[MHWeekDayCircleView alloc]initWithFrame:CGRectMake(_SaturdayCircleView.right + margin, 0.0f, self.height, self.height) dayType:MHSunday];
    
    [self.MondayCircleView addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.ThuesdayCircleView addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.WednesdayCircleView addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.ThursdayCircleView addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.FridayCircleView addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.SaturdayCircleView addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.SundayCircleView addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];

    [_MondayCircleView mh_setSelected:NO];
    [_ThuesdayCircleView mh_setSelected:NO];
    [_WednesdayCircleView mh_setSelected:NO];
    [_ThursdayCircleView mh_setSelected:NO];
    [_FridayCircleView mh_setSelected:NO];
    [_SaturdayCircleView mh_setSelected:NO];
    [_SundayCircleView mh_setSelected:NO];
    
    [self addSubview:_MondayCircleView];
    [self addSubview:_ThuesdayCircleView];
    [self addSubview:_WednesdayCircleView];
    [self addSubview:_ThursdayCircleView];
    [self addSubview:_FridayCircleView];
    [self addSubview:_SaturdayCircleView];
    [self addSubview:_SundayCircleView];
}

- (void)resetSelectState
{
    [self.selectedWeekDayArray removeAllObjects];
    [_MondayCircleView mh_setSelected:NO];
    [_ThuesdayCircleView mh_setSelected:NO];
    [_WednesdayCircleView mh_setSelected:NO];
    [_ThursdayCircleView mh_setSelected:NO];
    [_FridayCircleView mh_setSelected:NO];
    [_SaturdayCircleView mh_setSelected:NO];
    [_SundayCircleView mh_setSelected:NO];
}

- (void)buttonTapped:(id)sender
{
    MHWeekDayCircleView *view = (MHWeekDayCircleView *)sender;
    if(view.mh_selected) {
        [view mh_setSelected:NO];
        [self.selectedWeekDayArray removeObject:@(view.dayType)];
    } else {
        [view mh_setSelected:YES];
        [self.selectedWeekDayArray addObject:@(view.dayType)];
    }
}
@end
