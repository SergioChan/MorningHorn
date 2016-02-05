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
        [self initSubViews];
        [self processWeekDayArray:array];
    }
    return self;
}

- (void)initSubViews
{
    CGFloat margin = (self.width - 7 * self.height ) / 6.0f;
    CGFloat height = self.height / 2.0f;
    CGFloat shadowOffset = 0.5f;
    CGFloat shadowOpacity = 0.4f;
    CGFloat shadowRadius = 0.3f;
    
    self.MondayCircleView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.height, self.height)];
    _MondayCircleView.layer.cornerRadius = height;
    _MondayCircleView.layer.shadowOffset = CGSizeMake(0, shadowOffset);
    _MondayCircleView.layer.shadowOpacity = shadowOpacity;
    _MondayCircleView.layer.shadowRadius = shadowRadius;
    _MondayCircleView.layer.shadowColor = [UIColor colorWithRed:251/255.0f green:229/255.0f blue:84/255.0f alpha:1.0f].CGColor;
    
    self.ThuesdayCircleView = [[UIView alloc]initWithFrame:CGRectMake(_MondayCircleView.right + margin, 0.0f, self.height, self.height)];
    _ThuesdayCircleView.layer.cornerRadius = height;
    _ThuesdayCircleView.layer.shadowOffset = CGSizeMake(0, shadowOffset);
    _ThuesdayCircleView.layer.shadowOpacity = shadowOpacity;
    _ThuesdayCircleView.layer.shadowRadius = shadowRadius;
    _ThuesdayCircleView.layer.shadowColor = [UIColor colorWithRed:251/255.0f green:229/255.0f blue:84/255.0f alpha:1.0f].CGColor;
    
    self.WednesdayCircleView = [[UIView alloc]initWithFrame:CGRectMake(_ThuesdayCircleView.right + margin, 0.0f, self.height, self.height)];
    _WednesdayCircleView.layer.cornerRadius = height;
    _WednesdayCircleView.layer.shadowOffset = CGSizeMake(0, shadowOffset);
    _WednesdayCircleView.layer.shadowOpacity = shadowOpacity;
    _WednesdayCircleView.layer.shadowRadius = shadowRadius;
    _WednesdayCircleView.layer.shadowColor = [UIColor colorWithRed:251/255.0f green:229/255.0f blue:84/255.0f alpha:1.0f].CGColor;
    
    self.ThursdayCircleView = [[UIView alloc]initWithFrame:CGRectMake(_WednesdayCircleView.right + margin, 0.0f, self.height, self.height)];
    _ThursdayCircleView.layer.cornerRadius = height;
    _ThursdayCircleView.layer.shadowOffset = CGSizeMake(0, shadowOffset);
    _ThursdayCircleView.layer.shadowOpacity = shadowOpacity;
    _ThursdayCircleView.layer.shadowRadius = shadowRadius;
    _ThursdayCircleView.layer.shadowColor = [UIColor colorWithRed:251/255.0f green:229/255.0f blue:84/255.0f alpha:1.0f].CGColor;
    
    self.FridayCircleView = [[UIView alloc]initWithFrame:CGRectMake(_ThursdayCircleView.right + margin, 0.0f, self.height, self.height)];
    _FridayCircleView.layer.cornerRadius = height;
    _FridayCircleView.layer.shadowOffset = CGSizeMake(0, shadowOffset);
    _FridayCircleView.layer.shadowOpacity = shadowOpacity;
    _FridayCircleView.layer.shadowRadius = shadowRadius;
    _FridayCircleView.layer.shadowColor = [UIColor colorWithRed:251/255.0f green:229/255.0f blue:84/255.0f alpha:1.0f].CGColor;
    
    self.SaturdayCircleView = [[UIView alloc]initWithFrame:CGRectMake(_FridayCircleView.right + margin, 0.0f, self.height, self.height)];
    _SaturdayCircleView.layer.cornerRadius = height;
    _SaturdayCircleView.layer.shadowOffset = CGSizeMake(0, shadowOffset);
    _SaturdayCircleView.layer.shadowOpacity = shadowOpacity;
    _SaturdayCircleView.layer.shadowRadius = shadowRadius;
    _SaturdayCircleView.layer.shadowColor = [UIColor colorWithRed:251/255.0f green:229/255.0f blue:84/255.0f alpha:1.0f].CGColor;
    
    self.SundayCircleView = [[UIView alloc]initWithFrame:CGRectMake(_SaturdayCircleView.right + margin, 0.0f, self.height, self.height)];
    _SundayCircleView.layer.cornerRadius = height;
    _SundayCircleView.layer.shadowOffset = CGSizeMake(0, shadowOffset);
    _SundayCircleView.layer.shadowOpacity = shadowOpacity;
    _SundayCircleView.layer.shadowRadius = shadowRadius;
    _SundayCircleView.layer.shadowColor = [UIColor colorWithRed:251/255.0f green:229/255.0f blue:84/255.0f alpha:1.0f].CGColor;
    
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
    _MondayCircleView.backgroundColor = MHBackgroundPurpleColor_dark;
    _ThursdayCircleView.backgroundColor = MHBackgroundPurpleColor_dark;
    _WednesdayCircleView.backgroundColor = MHBackgroundPurpleColor_dark;
    _ThuesdayCircleView.backgroundColor = MHBackgroundPurpleColor_dark;
    _FridayCircleView.backgroundColor = MHBackgroundPurpleColor_dark;
    _SaturdayCircleView.backgroundColor = MHBackgroundPurpleColor_dark;
    _SundayCircleView.backgroundColor = MHBackgroundPurpleColor_dark;
    
    for(id object in array) {
        switch ([object integerValue]) {
            case MHMonday:
                _MondayCircleView.backgroundColor = MHBackgroundYellowColor;
                break;
            case MHTuesDay:
                _ThuesdayCircleView.backgroundColor = MHBackgroundYellowColor;
                break;
            case MHWednesday:
                _WednesdayCircleView.backgroundColor = MHBackgroundYellowColor;
                break;
            case MHThursDay:
                _ThursdayCircleView.backgroundColor = MHBackgroundYellowColor;
                break;
            case MHFriday:
                _FridayCircleView.backgroundColor = MHBackgroundYellowColor;
                break;
            case MHSaturday:
                _SaturdayCircleView.backgroundColor = [UIColor whiteColor];
                break;
            case MHSunday:
                _SundayCircleView.backgroundColor = [UIColor whiteColor];
                break;
            default:
                break;
        }
    }
}
@end
