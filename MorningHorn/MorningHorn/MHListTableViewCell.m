//
//  MHListTableViewCell.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHListTableViewCell.h"

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
    }
    return self;
}

- (void)layoutSubviews
{
    self.alarmSwitch.frame = CGRectMake(self.width - 100.0f, self.height/4.0f, 60.0f, (self.height/4.0f) * 3.0f);
    self.alarmSwitch.alarmId = self.alarmModel.alarmId;
    
    self.dateLabel.text = [self.alarmModel.timeString serializedString];
    [self.weekDayView reloadDataByWeekDayArray:self.alarmModel.weekDayArray];
    [self.alarmSwitch updateButtonState:self.alarmModel.selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
