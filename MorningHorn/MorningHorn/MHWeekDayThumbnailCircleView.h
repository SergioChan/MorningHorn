//
//  MHWeekDayThumbnailCircleView.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/6.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHHeader.h"

@interface MHWeekDayThumbnailCircleView : UIView

@property (nonatomic,strong) UIView *circleView;
@property (nonatomic,strong) UIView *backView;

- (void)setSelected:(BOOL)selected color:(UIColor *)color;
@end
