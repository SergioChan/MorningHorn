//
//  MHWheelItemView.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/1/29.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHHeader.h"

@interface MHWheelItemView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) CGFloat startRadians;
@property (nonatomic, assign) CGFloat endRadians;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic) BOOL isHighlighted;

- (instancetype)initWithWidth:(CGFloat)width number:(NSInteger)number totalNumber:(NSInteger)total;

@end
