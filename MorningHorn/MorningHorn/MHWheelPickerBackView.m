//
//  MHWheelPickerBackView.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/2/1.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHWheelPickerBackView.h"

@implementation MHWheelPickerBackView

- (instancetype)initWithFrame:(CGRect)frame type:(MHPickerType)type
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        // don't fucking try to think that using shadow will be easier, on the contrary, it will only cause more problems
        
//        self.layer.shadowOffset = CGSizeMake(0, 10);
//        self.layer.shadowOpacity = 0.3f;
//        self.layer.shadowRadius = 30.0f;
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
        
        UIView *view = [[UIView alloc]initWithFrame:self.bounds];
        view.backgroundColor = MHBackgroundPurpleColor_medium;
        view.layer.cornerRadius = self.width/2.0f;
        [self addSubview:view];
        
        UIImageView *shadowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, self.height/7.0f, self.width, self.height)];
        shadowImageView.image = [UIImage imageNamed:@"shadow"];
        shadowImageView.contentMode = UIViewContentModeScaleAspectFill;
        shadowImageView.layer.cornerRadius = self.width/2.0f;
        [self addSubview:shadowImageView];
        [self sendSubviewToBack:shadowImageView];
        
        CAGradientLayer *gradientLayer_minute = [CAGradientLayer layer];
        gradientLayer_minute.frame = self.bounds;
        gradientLayer_minute.startPoint = CGPointMake(0.0f, 0.5f);
        gradientLayer_minute.endPoint = CGPointMake(1.0f, 0.5f);
        
        if(type == MHPickerHour) gradientLayer_minute.locations = @[@(0.25f),@(0.5f),@(0.75f)];
        else gradientLayer_minute.locations = @[@(0.3f),@(0.5f),@(0.7f)];
        
        gradientLayer_minute.colors = @[(__bridge id)[UIColor colorWithRed:75/255.0f green:31/255.0f blue:156/255.0f alpha:1.0f].CGColor,(__bridge id)[UIColor colorWithRed:75/255.0f green:31/255.0f blue:156/255.0f alpha:0.0f].CGColor,(__bridge id)[UIColor colorWithRed:75/255.0f green:31/255.0f blue:156/255.0f alpha:1.0f].CGColor];
        gradientLayer_minute.cornerRadius = self.width/2.0f;
        [self.layer addSublayer:gradientLayer_minute];
    }
    return self;
}

@end
