//
//  MHCreateFormView.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/13.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHCreateFormView.h"

@implementation MHCreateFormView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        UILabel *repeatTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 80.0f, 100.0f, 23.0f)];
        repeatTitleLabel.font = [UIFont fontWithName:HightlightedFontName size:20.0f];
        repeatTitleLabel.textColor = MHBackgroundPurpleColor_dark;
        repeatTitleLabel.text = @"REPEAT";
        repeatTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:repeatTitleLabel];
        
        self.weekDayView = [[MHWeekDayView alloc]initWithFrame:CGRectMake(40.0f, repeatTitleLabel.bottom + 10.0f, ScreenWidth - 80.0f, (self.width - 140.0f)/7.0f)];
        [self addSubview:_weekDayView];
        
        UILabel *soundTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, _weekDayView.bottom + 40.0f, 100.0f, 23.0f)];
        soundTitleLabel.font = [UIFont fontWithName:HightlightedFontName size:20.0f];
        soundTitleLabel.textColor = MHBackgroundPurpleColor_dark;
        soundTitleLabel.text = @"SOUND";
        soundTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:soundTitleLabel];
        
        UILabel *soundNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, soundTitleLabel.bottom + 10.0f, ScreenWidth - 80.0f, 40.0f)];
        soundNameLabel.font = [UIFont fontWithName:HightlightedFontName size:30.0f];
        soundNameLabel.textColor = [UIColor whiteColor];
        soundNameLabel.text = @"MORNING HORN";
        soundNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:soundNameLabel];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(40.0f, self.height - 50.0f, 100.0f, 30.0f)];
        cancelButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        cancelButton.titleLabel.font = [UIFont fontWithName:HightlightedFontName size:27.0f];
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorWithRed:251/255.0f green:229/255.0f blue:84/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
    }
    return self;
}

- (void)cancel:(id)sender
{
    if(self.didCancel) {
        self.didCancel();
        [self.weekDayView resetSelectState];
    }
}
@end
