//
//  MHWheelPickerView.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/1/29.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHWheelPickerView.h"

@interface MHWheelPickerView()
{
    CGFloat start_degree;
    NSMutableArray *_itemViewArray;
    CGFloat degree_per_item;
    CGFloat circle_radius;
}

@end

@implementation MHWheelPickerView
@synthesize numberOfItems = _numberOfItems;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegateSource type:(MHPickerType)type
{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        
        self.delegate = delegateSource;
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = NO;
        degree_per_item = 360.0f/ self.numberOfItems;
        circle_radius = self.width/2.0f;
        
        [self setup];
        [self initSubView];
    }
    
    return self;
}

- (void)setup
{
    self.selectedIndex = 0;
    start_degree = 0.0f;
    _itemViewArray = [NSMutableArray array];
    
    MHRotateGestureRecognizer *rotateGR = [[MHRotateGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotateGesture:)];
    [self addGestureRecognizer:rotateGR];
}

- (void)initSubView
{
    CGFloat radius = self.height/2;
    CGFloat degrees = 90.0f;//the above is the starting point
    
    for (int i = 0; i < self.numberOfItems; i++) {

        MHWheelItemView *item = [[MHWheelItemView alloc] initWithWidth:self.width number:i totalNumber:self.numberOfItems];
        item.tag = i;
        
        CGFloat centerX = radius + (radius/2 * cos(DEGREES_TO_RADIANS(degrees)));
        CGFloat centerY = radius + (radius/2 * sin(DEGREES_TO_RADIANS(degrees)));
        
        item.center = CGPointMake(centerX, centerY);
        item.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS((degrees + 90.0f)));
    
        if(self.type == MHPickerHour){
            item.titleLabel.font = [UIFont fontWithName:HightlightedFontName size:HourFontSize];
        } else {
            item.titleLabel.font = [UIFont fontWithName:HightlightedFontName size:MinuteFontSize];
        }
        
        if(i == 0){
            item.isHighlighted = YES;
            item.titleLabel.font = [UIFont fontWithName:HightlightedFontName size:HourFontSize];
            if(self.type == MHPickerHour){
                item.titleLabel.textColor = MHBackgroundYellowColor;
            } else {
               item.titleLabel.textColor = [UIColor whiteColor];
            }
        }
    
        [self addSubview:item];
        [_itemViewArray addObject:item];
        degrees += degree_per_item;
    }
}

- (void)handleRotateGesture:(MHRotateGestureRecognizer *)rotateGR
{
    if (rotateGR.state == UIGestureRecognizerStateChanged) {//rotate
        
        start_degree += rotateGR.degrees;
        if(RADIANS_TO_DEGREES(start_degree) >= 180.0f || RADIANS_TO_DEGREES(start_degree) <= -180.0f) start_degree = -start_degree;
        
        CGFloat degree = RADIANS_TO_DEGREES(start_degree);
        NSInteger index = self.selectedIndex;
        
        int t = (int)floorf(fabs(degree)/degree_per_item);
        int ct = (int)ceilf(fabs(degree)/degree_per_item);
        
        NSLog(@"last time t:%d,ct:%d,rt:%f,st:%f",t,ct,rotateGR.degrees,degree);
        
        if(start_degree >= 0) {
            if(rotateGR.degrees >= 0.0f) {
                // From right to left
                index = self.numberOfItems - t;
            } else {
                // From left to right
                index = self.numberOfItems - ct;
            }
        } else {
            if(rotateGR.degrees > 0.0f) {
                // From right to left
                index = 0 + ct;
            } else {
                // From left to right
                index = 0 + t;
            }
        }
        
        if(index >= self.numberOfItems) index = index%self.numberOfItems;
        
//        NSLog(@"temp index:%ld",index);
        
        for(NSInteger i=0;i<_itemViewArray.count;i++) {
            MHWheelItemView *item = [_itemViewArray objectAtIndex:i];
            if(i == index) {
                if(!item.isHighlighted) {
//                    if(self.type == MHPickerHour){
//                        item.titleLabel.textColor = MHBackgroundYellowColor;
//                    } else {
//                        item.titleLabel.textColor = [UIColor whiteColor];
//                    }
//                    item.titleLabel.font = [UIFont fontWithName:HightlightedFontName size:HourFontSize];
//                    item.isHighlighted = YES;
                }
            } else {
                if(item.isHighlighted) {
                    item.isHighlighted = NO;
                    if(self.type == MHPickerHour){
                        item.titleLabel.textColor = MHBackgroundPurpleColor;
                        item.titleLabel.font = [UIFont fontWithName:HightlightedFontName size:HourFontSize];
                    } else {
                        item.titleLabel.textColor = MHBackgroundPurpleColor;
                        item.titleLabel.font = [UIFont fontWithName:HightlightedFontName size:MinuteFontSize];
                    }
                }
            }
        }
        
        self.transform = CGAffineTransformRotate(self.transform, rotateGR.degrees);
    }
    else if(rotateGR.state == UIGestureRecognizerStateEnded) {//tap

        CGFloat degree = RADIANS_TO_DEGREES(start_degree);
        int t = (int)floorf(fabs(degree)/degree_per_item);
        int ct = (int)ceilf(fabs(degree)/degree_per_item);
        if(start_degree >= 0) {
            if(rotateGR.degrees > 0) {
                // From right to left
                _selectedIndex = self.numberOfItems - t;
                start_degree = DEGREES_TO_RADIANS(t * degree_per_item);
            } else {
                // From left to right
                _selectedIndex = self.numberOfItems - ct;
                start_degree = DEGREES_TO_RADIANS(ct * degree_per_item);
            }
        } else {
            if(rotateGR.degrees > 0) {
                // From right to left
                _selectedIndex = 0 + ct;
                start_degree = DEGREES_TO_RADIANS(-ct * degree_per_item);
            } else {
                // From left to right
                _selectedIndex = 0 + t;
                start_degree = DEGREES_TO_RADIANS(-t * degree_per_item);
            }
        }
        
        if(self.selectedIndex >= self.numberOfItems) self.selectedIndex = self.selectedIndex%self.numberOfItems;
        
//        NSLog(@"index: %ld, %f",self.selectedIndex,floorf(fabs(degree)/degree_per_item));
        
        [UIView animateWithDuration:0.3f animations:^{
            for(NSInteger i=0;i<_itemViewArray.count;i++) {
                MHWheelItemView *item = [_itemViewArray objectAtIndex:i];
                if(i == _selectedIndex) {
                    if(!item.isHighlighted) {
                        if(self.type == MHPickerHour){
                            item.titleLabel.textColor = MHBackgroundYellowColor;
                        } else {
                            item.titleLabel.textColor = [UIColor whiteColor];
                        }
                        item.titleLabel.font = [UIFont fontWithName:HightlightedFontName size:HourFontSize];
                        item.isHighlighted = YES;
                    }
                } else {
                    if(item.isHighlighted) {
                        item.isHighlighted = NO;
                        if(self.type == MHPickerHour){
                            item.titleLabel.textColor = MHBackgroundPurpleColor;
                            item.titleLabel.font = [UIFont fontWithName:HightlightedFontName size:HourFontSize];
                        } else {
                            item.titleLabel.textColor = MHBackgroundPurpleColor;
                            item.titleLabel.font = [UIFont fontWithName:HightlightedFontName size:MinuteFontSize];
                        }
                    }
                }
            }
            self.layer.transform = CATransform3DMakeRotation(start_degree, 0, 0, 1);
        } completion:^(BOOL finished) {
            if ([self.delegate respondsToSelector:@selector(wheelView:didSelectItemAtIndex:)]) {
                [self.delegate wheelView:self didSelectItemAtIndex:self.selectedIndex];
            }
        }];
    }
}

- (NSInteger)numberOfItems
{
    if ([self.delegate respondsToSelector:@selector(numberOfItemsInWheelView:)]) {
        _numberOfItems = [self.delegate numberOfItemsInWheelView:self];
    }
    
    return _numberOfItems;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // Calculate the touch area using distance between touch point and the center of the circle
    
    CGPoint centerPoint = self.center;
    CGPoint superPoint = [self convertPoint:point toView:self.superview];
    CGFloat distance = sqrt(powf((centerPoint.x - superPoint.x), 2) + powf(centerPoint.y - superPoint.y, 2));
    
    if (distance < circle_radius) {
        return YES;
    } else {
        return NO;
    }
}
@end
