//
//  MHSwitch.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/5.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHSwitch.h"

@interface MHSwitch()

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIButton *button;

@end

@implementation MHSwitch

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, (self.height/8.0f) * 3.0f, self.width, self.height/4.0f)];
    _backView.backgroundColor = MHBackgroundPurpleColor_dark;
    _backView.layer.cornerRadius = self.height/8.0f;
    [self addSubview:_backView];
    
    UIView *backShadowView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, (self.height/8.0f) * 3.0f + 0.2f, self.width, self.height/4.0f)];
    backShadowView.backgroundColor = MHBackgroundYellowColor;
    backShadowView.layer.cornerRadius = self.height/8.0f;
    backShadowView.alpha = 0.4f;
    [self addSubview:backShadowView];
    [self sendSubviewToBack:backShadowView];
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.height, self.height)];
    _button.backgroundColor = [UIColor whiteColor];
    _button.layer.cornerRadius = self.height/2.0f;
    _button.layer.shadowOffset = CGSizeMake(0, 10.0f);
    _button.layer.shadowOpacity = 0.6f;
    _button.layer.shadowRadius = 10.0f;
    _button.layer.shadowColor = [UIColor blackColor].CGColor;
    [self addSubview:_button];
}
@end
