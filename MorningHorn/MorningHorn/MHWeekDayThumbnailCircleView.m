//
//  MHWeekDayThumbnailCircleView.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/6.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHWeekDayThumbnailCircleView.h"

@interface MHWeekDayThumbnailCircleView()

@end

@implementation MHWeekDayThumbnailCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.circleView = [[UIView alloc] initWithFrame:self.bounds];
        self.circleView.layer.cornerRadius = self.width/2.0f;
        self.circleView.backgroundColor = MHBackgroundPurpleColor_dark;
        [self addSubview:self.circleView];
        
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.3f, self.width, self.height)];
        self.backView.layer.cornerRadius = self.width/2.0f;
        self.backView.backgroundColor = MHBackgroundYellowColor;
        [self addSubview:self.backView];
        [self sendSubviewToBack:self.backView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected color:(UIColor *)color
{
    self.circleView.backgroundColor = color;
    
    if(selected) {
        self.backView.hidden = YES;
    } else {
        self.backView.hidden = NO;
    }
}
@end
