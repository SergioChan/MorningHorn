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
        if(RADIANS_TO_DEGREES(start_degree) >= 180.0f) {
            start_degree = - (DEGREES_TO_RADIANS(360.0f) - start_degree);
        } else if (RADIANS_TO_DEGREES(start_degree) <= -180.0f) {
            start_degree = start_degree + DEGREES_TO_RADIANS(360.0f);
        }
        
        CGFloat degree = RADIANS_TO_DEGREES(start_degree);
        if(degree < 0) degree = 360.0f + degree;
        
        NSInteger index = self.numberOfItems - floorf(floorf(degree/ (degree_per_item/2.0f)) / 2.0f);
        if(index >= self.numberOfItems) index = index%self.numberOfItems;
        
        for(NSInteger i=0;i<_itemViewArray.count;i++) {
            MHWheelItemView *item = [_itemViewArray objectAtIndex:i];
            if(i == index) {
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
        
        self.transform = CGAffineTransformRotate(self.transform, rotateGR.degrees);
    }
    else if(rotateGR.state == UIGestureRecognizerStateEnded) {//tap

        CGFloat degree = RADIANS_TO_DEGREES(start_degree);
        if(degree < 0) degree = 360.0f + degree;

        NSInteger index = floorf(floorf(degree/ (degree_per_item/2.0f)) / 2.0f);
        
        if(index > self.numberOfItems / 2.0f) {
            start_degree = DEGREES_TO_RADIANS(- (self.numberOfItems - index) * degree_per_item);
        } else {
            start_degree = DEGREES_TO_RADIANS(index * degree_per_item);
        }
        
        _selectedIndex = self.numberOfItems - index;
        if(self.selectedIndex >= self.numberOfItems) self.selectedIndex = self.selectedIndex%self.numberOfItems;
        
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

- (void)updateToIndex:(NSInteger)index animated:(BOOL)animated
{
    start_degree = -DEGREES_TO_RADIANS(index * degree_per_item);

    _selectedIndex = index;
    [UIView animateWithDuration:0.5f animations:^{
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
    }];
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
