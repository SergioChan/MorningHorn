//
//  MHListTableViewCell.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHListTableViewCell.h"

@interface MHListTableViewCell()
{
    UIPanGestureRecognizer *pan;
}

@end

@implementation MHListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 0.0f, 200.0f, 45.0f)];
        _dateLabel.font = [UIFont fontWithName:HightlightedFontName size:40.0f];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_dateLabel];
        
        self.weekDayView = [[MHWeekDayThumbnailView alloc]initWithFrame:CGRectMake(40.0f, _dateLabel.bottom + 10.0f, 150.0f, 15.0f) weekDayArray:[NSMutableArray array]];
        [self.contentView addSubview:_weekDayView];
        
        self.alarmSwitch = [[MHSwitch alloc]initWithFrame:CGRectMake(self.width - 100.0f, self.height/4.0f, 60.0f, (self.height/4.0f) * 3.0f)];
        [self.contentView addSubview:_alarmSwitch];
        
        self.deleteButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_deleteButton setBackgroundColor:[UIColor colorWithRed:75/255.0f green:31/255.0f blue:156/255.0f alpha:1.0f]];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteButton];
        
        pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerHandler:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)layoutSubviews
{
    self.alarmSwitch.frame = CGRectMake(self.width - 100.0f, self.height/4.0f, 60.0f, (self.height/4.0f) * 3.0f);
    self.deleteButton.frame = CGRectMake(self.width, self.height/4.0f, self.height/3.0f, self.height/3.0f);
    self.alarmSwitch.alarmId = self.alarmModel.alarmId;
    
    self.dateLabel.text = [self.alarmModel.timeString serializedString];
    [self.weekDayView reloadDataByWeekDayArray:self.alarmModel.weekDayArray];
    [self.alarmSwitch updateButtonState:self.alarmModel.selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(pan == gestureRecognizer) {
        CGPoint point = [pan translationInView:self];
        return fabs(point.x) > 0;
    } else {
        return YES;
    }
}

- (void)panGestureRecognizerHandler:(UIPanGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [gestureRecognizer translationInView:self];
            CGFloat offset = point.x;
            if (offset < -0) {
                if(self.alarmSwitch.left < self.width) {
                    [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.deleteButton.left = self.width - 90.0f;
                        self.alarmSwitch.left = self.width + 20.0f;
                    } completion:^(BOOL finished) {
                    }];
                }
            } else if (offset > 0) {
                if(self.deleteButton.left < self.width) {
                    [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.deleteButton.left = self.width + 20.0f;
                        self.alarmSwitch.left = self.width - 100.0f;
                    } completion:^(BOOL finished) {
                    }];
                }
            }
            break;
        }
        default:
            break;
    }
}

- (void)deleteButtonPressed:(id)sender
{
    if(self.didDeleteAlarm) {
        self.didDeleteAlarm(self.alarmModel);
    }
}

@end
