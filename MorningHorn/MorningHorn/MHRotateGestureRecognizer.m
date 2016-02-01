//
//  MHRotateGestureRecognizer.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/1/29.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHRotateGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation MHRotateGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.state = (touches.count == 1) ? UIGestureRecognizerStateBegan : UIGestureRecognizerStateFailed;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    CGPoint currentLocation = [touch locationInView:self.view];
    CGPoint previousLocation = [touch previousLocationInView:self.view];
    
    self.degrees = atan2((currentLocation.y - center.y), (currentLocation.x - center.x)) - atan2((previousLocation.y - center.y), (previousLocation.x - center.x));
    self.state = UIGestureRecognizerStateChanged;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateEnded;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateCancelled;
}

@end
