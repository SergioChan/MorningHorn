//
//  MHWeekDayCircleView.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/14.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHWeekDayCircleView.h"

@implementation MHWeekDayCircleView

- (instancetype)initWithFrame:(CGRect)frame dayType:(MHWeekDay)type
{
    self = [super initWithFrame:frame];
    if(self) {
        self.mh_selected = NO;
        self.dayType = type;
        
        self.circleView = [[UIView alloc] initWithFrame:self.bounds];
        _circleView.layer.cornerRadius = self.width/2.0f;
        _circleView.backgroundColor = MHBackgroundPurpleColor_dark;
        [_circleView makeInsetShadowWithRadius:self.width/3.0f Alpha:0.2];
        [self addSubview:_circleView];
        _circleView.userInteractionEnabled = NO;
        
        self.shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(-10.0f, self.height - 30.0f, self.width + 20.0f, 45.0f)];
        _shadowView.image = [UIImage imageNamed:@"shadow"];
        _shadowView.alpha = 0.4f;
        _shadowView.contentMode = UIViewContentModeScaleToFill;
        _shadowView.layer.cornerRadius = self.width/2.0f;
        _shadowView.hidden = YES;
        [self addSubview:_shadowView];
        
        self.selectedView = [[UILabel alloc] initWithFrame:self.bounds];
        _selectedView.textColor = [UIColor whiteColor];
        _selectedView.textAlignment = NSTextAlignmentCenter;
        _selectedView.backgroundColor = [UIColor clearColor];
        _selectedView.font = [UIFont fontWithName:HightlightedFontName size:self.height - 18.0f];
        switch (type) {
            case MHMonday:
                _selectedView.text = @"M";
                break;
            case MHWednesday:
                _selectedView.text = @"W";
                break;
            case MHTuesDay:
            case MHThursDay:
                _selectedView.text = @"T";
                break;
            case MHFriday:
                _selectedView.text = @"F";
                break;
            case MHSaturday:
            case MHSunday:
                _selectedView.text = @"S";
                break;
            default:
                break;
        }
        _selectedView.hidden = YES;
        _selectedView.userInteractionEnabled = NO;
        
        self.selectedBackView = [[UIView alloc]initWithFrame:_selectedView.frame];
        _selectedBackView.layer.cornerRadius = self.width/2.0f;
        _selectedBackView.hidden = YES;
        _selectedBackView.backgroundColor = MHBackgroundYellowColor;
        _selectedBackView.userInteractionEnabled = NO;
        
        [self addSubview:_selectedBackView];
        [self addSubview:_selectedView];
        [self sendSubviewToBack:_shadowView];
    }
    return self;
}

- (void)mh_setSelected:(BOOL)selected
{
    self.mh_selected = selected;
    self.selectedBackView.hidden = !selected;
    self.selectedView.hidden = !selected;
    self.shadowView.hidden = !selected;
}

@end
