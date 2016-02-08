//
//  MHSwitch.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/5.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHHeader.h"

@interface MHSwitch : UIView

@property (nonatomic,copy) void (^didUpdateState)(BOOL selected);

- (void)updateButtonState:(BOOL)selected animated:(BOOL)animated;
- (BOOL)isSelected;

@end
