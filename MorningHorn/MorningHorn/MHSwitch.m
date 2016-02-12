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
@property (nonatomic,strong) UIImageView *shadowView;

@property (nonatomic,strong) UIButton *button;
@property (nonatomic) BOOL selected;

@end

@implementation MHSwitch

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.selected = NO;
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
    
    UIView *backShadowView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, (self.height/8.0f) * 3.0f + 0.25f, self.width, self.height/4.0f)];
    backShadowView.backgroundColor = MHBackgroundYellowColor;
    backShadowView.layer.cornerRadius = self.height/8.0f;
    backShadowView.alpha = 1.0f;
    [self addSubview:backShadowView];
    [self sendSubviewToBack:backShadowView];
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.height, self.height)];
    _button.backgroundColor = [UIColor whiteColor];
    _button.layer.cornerRadius = self.height/2.0f;
    
    [_button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchDown];
    
    self.shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(-5.0f, self.height - 30.0f, self.height + 10.0f, 43.0f)];
    _shadowView.image = [UIImage imageNamed:@"shadow"];
    _shadowView.alpha = 0.4f;
    _shadowView.contentMode = UIViewContentModeScaleToFill;
    _shadowView.layer.cornerRadius = self.height/2.0f;
    
    [self addSubview:_button];
    [self addSubview:_shadowView];
    [self sendSubviewToBack:_shadowView];
}

- (void)updateButtonState:(BOOL)selected animated:(BOOL)animated
{
    if(animated) {
        [UIView animateWithDuration:0.25f animations:^{
            if(!selected) {
                _button.left = 0.0f;
                _shadowView.left = _button.left - 5.0f;
                _button.backgroundColor = [UIColor whiteColor];
            } else {
                _button.left = self.width - _button.height;
                _shadowView.left = _button.left - 5.0f;
                _button.backgroundColor = MHBackgroundYellowColor;
            }

        } completion:^(BOOL finished) {
            self.selected = selected;
        }];
    } else {
        if(!selected) {
            _button.left = 0.0f;
            _shadowView.left = _button.left - 5.0f;
            _button.backgroundColor = [UIColor whiteColor];
        } else {
            _button.left = self.width - _button.height;
            _shadowView.left = _button.left - 5.0f;
            _button.backgroundColor = MHBackgroundYellowColor;
        }
        self.selected = selected;
    }
}

- (void)buttonTap:(id)sender
{
    if(self.selected) {
        [self updateButtonState:NO animated:YES];
    } else {
        [self updateButtonState:YES animated:YES];
    }
    if(self.didUpdateState) {
        self.didUpdateState(self.selected);
    }
}

- (BOOL)isSelected
{
    return self.selected;
}
@end
