//
//  MHWheelItemView.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/1/29.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHWheelItemView.h"

@implementation MHWheelItemView

- (instancetype)initWithWidth:(CGFloat)width number:(NSInteger)number totalNumber:(NSInteger)total
{
    _radius = width/2;
    _startRadians = DEGREES_TO_RADIANS(90.0 - ((360/total)/2));
    _endRadians = DEGREES_TO_RADIANS(90.0 + ((360/total)/2));
    _isHighlighted = NO;
    
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_radius, _radius) radius:_radius startAngle:_startRadians endAngle:_endRadians clockwise:YES];
    
    CGRect frame = CGRectMake(0, 0, arcPath.bounds.size.width + 7, _radius);
    
    
    if (self = [super initWithFrame:frame]) {
        self.layer.anchorPoint = CGPointMake(0.5, (_radius/2)/frame.size.height);
        self.layer.masksToBounds = NO;
        self.backgroundColor = [UIColor clearColor];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 15.0f, self.frame.size.width, 55.0f)];
        if(number < 10) {
            _titleLabel.text = [NSString stringWithFormat:@"0%ld",number];
        } else {
            _titleLabel.text = [NSString stringWithFormat:@"%ld",number];
        }
        _titleLabel.textColor = MHBackgroundPurpleColor;
        _titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:HourFontSize];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        
        [self addSubview:_titleLabel];
    }
    
    
    return self;
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGRect frameSize = self.bounds;
//    
//    CGFloat delta_arc = _radius - sqrtf(_radius * _radius - (frameSize.size.width / 2.0f) * (frameSize.size.width / 2.0f)) + 2.5f;
//    
//    CGContextMoveToPoint(context, 0, delta_arc);
//    CGContextAddQuadCurveToPoint(context, frameSize.size.width/2.0f, 0.0f, frameSize.size.width, delta_arc);
//    CGContextAddLineToPoint (context, frameSize.size.width, frameSize.size.height);
//    //CGContextAddQuadCurveToPoint(context, frameSize.size.width/2.0f,  frameSize.size.height + 60.0f, 0.0f,  frameSize.size.height);
//    CGContextAddLineToPoint (context, 0, frameSize.size.height);
//    CGContextClosePath(context);
//    
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:116/255.0f green:78/255.0f blue:195/255.0f alpha:1.0f].CGColor);
//    CGContextDrawPath(context, kCGPathFill);
//}


@end
