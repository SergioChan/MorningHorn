//
//  MHWheelPickerView.h
//  MorningHorn
//
//  Created by 叔 陈 on 16/1/29.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHHeader.h"
#import "MHRotateGestureRecognizer.h"
#import "MHWheelItemView.h"

typedef NS_ENUM(NSInteger, MHPickerType) {
    MHPickerHour = 0,
    MHPickerMinute = 1,
};

@class MHWheelPickerView;

@protocol MHWheelPickerViewDelegate <NSObject>

@optional
- (NSInteger)numberOfItemsInWheelView:(MHWheelPickerView *)wheelView;
- (void)wheelView:(MHWheelPickerView *)wheelView didSelectItemAtIndex:(NSInteger)index;
@end

@interface MHWheelPickerView : UIView

@property (nonatomic, assign, readonly) NSInteger numberOfItems;
@property (nonatomic, assign)           NSInteger selectedIndex;
@property (nonatomic, assign)           MHPickerType type;

@property (nonatomic, weak)             id<MHWheelPickerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegateSource type:(MHPickerType)type;
@end
