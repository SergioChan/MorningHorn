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

@property (nonatomic,strong) MHWeekDayThumbnailCircleView *MondayCircleView;
@property (nonatomic,strong) MHWeekDayThumbnailCircleView *ThuesdayCircleView;
@property (nonatomic,strong) MHWeekDayThumbnailCircleView *WednesdayCircleView;
@property (nonatomic,strong) MHWeekDayThumbnailCircleView *ThursdayCircleView;
@property (nonatomic,strong) MHWeekDayThumbnailCircleView *FridayCircleView;
@property (nonatomic,strong) MHWeekDayThumbnailCircleView *SaturdayCircleView;
@property (nonatomic,strong) MHWeekDayThumbnailCircleView *SundayCircleView;

@end

@implementation MHWeekDayThumbnailView

- (instancetype)initWithFrame:(CGRect)frame weekDayArray:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initSubViews];
        [self processWeekDayArray:array];
    }
    return self;
}

- (void)initSubViews
{
    CGFloat margin = (self.width - 7 * self.height ) / 6.0f;
    
    self.MondayCircleView = [[MHWeekDayThumbnailCircleView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.height, self.height)];
    self.ThuesdayCircleView = [[MHWeekDayThumbnailCircleView alloc]initWithFrame:CGRectMake(_MondayCircleView.right + margin, 0.0f, self.height, self.height)];
    self.WednesdayCircleView = [[MHWeekDayThumbnailCircleView alloc]initWithFrame:CGRectMake(_ThuesdayCircleView.right + margin, 0.0f, self.height, self.height)];
    self.ThursdayCircleView = [[MHWeekDayThumbnailCircleView alloc]initWithFrame:CGRectMake(_WednesdayCircleView.right + margin, 0.0f, self.height, self.height)];
    self.FridayCircleView = [[MHWeekDayThumbnailCircleView alloc]initWithFrame:CGRectMake(_ThursdayCircleView.right + margin, 0.0f, self.height, self.height)];
    self.SaturdayCircleView = [[MHWeekDayThumbnailCircleView alloc]initWithFrame:CGRectMake(_FridayCircleView.right + margin, 0.0f, self.height, self.height)];
    self.SundayCircleView = [[MHWeekDayThumbnailCircleView alloc]initWithFrame:CGRectMake(_SaturdayCircleView.right + margin, 0.0f, self.height, self.height)];
   
    [self addSubview:_MondayCircleView];
    [self addSubview:_ThuesdayCircleView];
    [self addSubview:_WednesdayCircleView];
    [self addSubview:_ThursdayCircleView];
    [self addSubview:_FridayCircleView];
    [self addSubview:_SaturdayCircleView];
    [self addSubview:_SundayCircleView];
}

- (void)reloadDataByWeekDayArray:(NSMutableArray *)array
{
    [self processWeekDayArray:array];
}

- (void)processWeekDayArray:(NSMutableArray *)array
{
    UIColor *darkPurple = MHBackgroundPurpleColor_dark;
    UIColor *yellow = MHBackgroundYellowColor;
    [_MondayCircleView setSelected:NO color:darkPurple];
    [_ThursdayCircleView setSelected:NO color:darkPurple];
    [_WednesdayCircleView setSelected:NO color:darkPurple];
    [_ThuesdayCircleView setSelected:NO color:darkPurple];
    [_FridayCircleView setSelected:NO color:darkPurple];
    [_SaturdayCircleView setSelected:NO color:darkPurple];
    [_SundayCircleView setSelected:NO color:darkPurple];
    
    for(id object in array) {
        switch ([object integerValue]) {
            case MHMonday:
                [_MondayCircleView setSelected:YES color:yellow];
                break;
            case MHTuesDay:
                [_ThuesdayCircleView setSelected:YES color:yellow];
                break;
            case MHWednesday:
                [_WednesdayCircleView setSelected:YES color:yellow];
                break;
            case MHThursDay:
                [_ThursdayCircleView setSelected:YES color:yellow];
                break;
            case MHFriday:
                [_FridayCircleView setSelected:YES color:yellow];
                break;
            case MHSaturday:
                [_SaturdayCircleView setSelected:YES color:[UIColor whiteColor]];
                break;
            case MHSunday:
                [_SundayCircleView setSelected:YES color:[UIColor whiteColor]];
                break;
            default:
                break;
        }
    }
}
@end
