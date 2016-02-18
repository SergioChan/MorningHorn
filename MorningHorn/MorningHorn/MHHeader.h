//
//  MHHeader.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/1/28.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#ifndef MHHeader_h
#define MHHeader_h

#import "UIView+ViewFrameGeometry.h"
#import "HexColors.h"

#define DEGREES_TO_RADIANS(d) ((d) * M_PI / 180)
#define RADIANS_TO_DEGREES(d) ((d) * 180 / M_PI)

#define MHBackgroundPurpleColor [UIColor colorWithRed:75/255.0f green:31/255.0f blue:156/255.0f alpha:1.0f];
#define MHBackgroundPurpleColor_medium [UIColor colorWithRed:94/255.0f green:49/255.0f blue:182/255.0f alpha:1.0f];
#define MHBackgroundPurpleColor_dark [UIColor colorWithRed:52/255.0f green:7/255.0f blue:130/255.0f alpha:1.0f];

#define MHBackgroundYellowColor [UIColor colorWithRed:251/255.0f green:229/255.0f blue:84/255.0f alpha:1.0f];

#define MinuteFontSize 35.0f
#define HourFontSize 55.0f
#define HightlightedFontName @"Arial Rounded MT Bold"

#define NotificationTitle @"号角正在响起!"
#endif /* MHHeader_h */
