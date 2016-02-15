//
//  MHListViewController.m
//  MorningHorn
//
//  Created by 叔 陈 on 16/1/28.
//  Copyright © 2016年 叔 陈. All rights reserved.
//

#import "MHListViewController.h"
#import "MHHeader.h"
#import "MHWheelPickerBackView.h"
#import "MHListTableViewCell.h"
#import "MHRotateGestureRecognizer.h"
#import "MHWheelPickerView.h"
#import "MHWheelItemView.h"
#import "MHCreateFormView.h"

@interface MHListViewController ()<MHWheelPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGFloat tableViewTopConstant;
}
@property (nonatomic, strong) MHWheelPickerView *hourPickerView;
@property (nonatomic, strong) MHWheelPickerView *minutePickerView;
@property (nonatomic, strong) UITableView       *listTableView;
@property (nonatomic, strong) UIButton          *lightButton;
@property (nonatomic, strong) UILabel           *lightTitleLabel;

@property (nonatomic, strong) MHCreateFormView  *createFormView;
@property (nonatomic, strong) NSMutableArray    *alarmArray;

@property (nonatomic) NSInteger                 selectedHour;
@property (nonatomic) NSInteger                 selectedMinute;

@end

@implementation MHListViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.selectedHour = 0;
        self.selectedMinute = 0;
        self.alarmArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MHBackgroundPurpleColor;
    self.alarmArray = [NSMutableArray arrayWithObjects:
                       [MHAlarm alarmWithTimeString:[MHTimeString timeStringWithHour:9 minute:45] weekDayArray:[NSMutableArray arrayWithObjects:@(MHMonday),@(MHTuesDay),@(MHWednesday),@(MHThursDay), nil] soundName:@"" snoozeTime:0],
                       [MHAlarm alarmWithTimeString:[MHTimeString timeStringWithHour:20 minute:30] weekDayArray:[NSMutableArray arrayWithObjects:@(MHMonday),@(MHTuesDay),@(MHSaturday),@(MHSunday), nil] soundName:@"" snoozeTime:0],
                       [MHAlarm alarmWithTimeString:[MHTimeString timeStringWithHour:5 minute:46] weekDayArray:[NSMutableArray arrayWithObjects:@(MHMonday),@(MHTuesDay),@(MHFriday), nil] soundName:@"" snoozeTime:0],
                       [MHAlarm alarmWithTimeString:[MHTimeString timeStringWithHour:9 minute:30] weekDayArray:[NSMutableArray arrayWithObjects:@(MHMonday),@(MHTuesDay),@(MHWednesday), nil] soundName:@"" snoozeTime:0],
                       [MHAlarm alarmWithTimeString:[MHTimeString timeStringWithHour:7 minute:23] weekDayArray:[NSMutableArray arrayWithObjects:@(MHMonday),@(MHTuesDay),@(MHSaturday),@(MHSunday), nil] soundName:@"" snoozeTime:0],nil];
    
    
    self.hourPickerView = [[MHWheelPickerView alloc]initWithFrame:CGRectMake(-150.0f, - (ScreenWidth + 300.0f)/2.0f - 200.0f, ScreenWidth + 300.0f, ScreenWidth + 300.0f) delegate:self type:MHPickerHour];

    MHWheelPickerBackView *hourBackView = [[MHWheelPickerBackView alloc]initWithFrame:_hourPickerView.frame type:MHPickerHour];
    
    self.minutePickerView = [[MHWheelPickerView alloc]initWithFrame:CGRectMake(-450.0f, - (ScreenWidth + 900.0f)/2.0f - 400.0f, ScreenWidth + 900.0f, ScreenWidth + 900.0f) delegate:self type:MHPickerMinute];
    
    MHWheelPickerBackView *minuteBackView = [[MHWheelPickerBackView alloc]initWithFrame:_minutePickerView.frame type:MHPickerMinute];

    [self.view addSubview:minuteBackView];
    [self.view addSubview:_minutePickerView];
    
    [self.view addSubview:hourBackView];
    [self.view addSubview:_hourPickerView];
    
    _hourPickerView.userInteractionEnabled = NO;
    _minutePickerView.userInteractionEnabled = NO;
    
    tableViewTopConstant = _minutePickerView.bottom - 30.0f;
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, _minutePickerView.bottom - 30.0f, ScreenWidth, ScreenHeight - _minutePickerView.bottom + 30.0f) style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = MHBackgroundPurpleColor;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTableView.showsHorizontalScrollIndicator = NO;
    self.listTableView.showsVerticalScrollIndicator = NO;
    self.listTableView.bounces = YES;
    self.listTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _listTableView.width, 80.0f)];
    self.listTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _listTableView.width, 130.0f)];
    [self.view insertSubview:_listTableView belowSubview:minuteBackView];

    self.createFormView = [[MHCreateFormView alloc] initWithFrame:CGRectMake(0.0f, ScreenHeight, ScreenWidth, ScreenHeight - _minutePickerView.bottom + 30.0f)];
    self.createFormView.backgroundColor = MHBackgroundPurpleColor;
    [self.view insertSubview:_createFormView belowSubview:minuteBackView];
    
    self.lightButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 150.0f, ScreenHeight - 150.0f, 300.0f, 300.0f)];
    _lightButton.layer.cornerRadius = 150.0f;
    _lightButton.backgroundColor = MHBackgroundYellowColor;
    _lightButton.layer.shadowColor = [UIColor colorWithRed:251/255.0f green:229/255.0f blue:84/255.0f alpha:1.0f].CGColor;
    _lightButton.layer.shadowOffset = CGSizeMake(-5, -5);
    _lightButton.layer.shadowOpacity = 0.6f;
    _lightButton.layer.shadowRadius = 30.0f;
    [_lightButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lightButton];
    
    self.lightTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 110.0f, ScreenHeight - 110.0f, 100.0f, 100.0f)];
    _lightTitleLabel.text = @"+";
    _lightTitleLabel.textColor = [UIColor whiteColor];
    _lightTitleLabel.font = [UIFont fontWithName:HightlightedFontName size:70.0f];
    _lightTitleLabel.textAlignment = NSTextAlignmentCenter;
    _lightTitleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_lightTitleLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - MHWheelPickerViewDelegate

- (NSInteger)numberOfItemsInWheelView:(MHWheelPickerView *)wheelView
{
    if(wheelView.type == MHPickerHour) return 24;
    else return 60;
}

- (void)wheelView:(MHWheelPickerView *)wheelView didSelectItemAtIndex:(NSInteger)index
{
    if(wheelView.type == MHPickerHour) self.selectedHour = index;
    else self.selectedMinute = index;
}

# pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.alarmArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    if(!cell)
    {
        cell = [[MHListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
        cell.alarmSwitch.didUpdateState = ^(BOOL selected,NSString *alarmId) {
            for(NSInteger i=0;i<self.alarmArray.count;i++) {
                MHAlarm *alarm = [self.alarmArray objectAtIndex:i];
                if([alarm.alarmId isEqualToString:alarmId]) {
                    alarm.selected = selected;
                    [self.alarmArray replaceObjectAtIndex:i withObject:alarm];
                }
            }
        };
    }
    cell.alarmModel = [self.alarmArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHTimeString *t = [[self.alarmArray objectAtIndex:indexPath.row] timeString];
    [self.hourPickerView updateToIndex:t.hour animated:YES];
    [self.minutePickerView updateToIndex:t.minute animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)ButtonPressed:(id)sender
{
    if([_lightTitleLabel.text isEqualToString:@"+"]) {
        // Animate from list to create form
        
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _listTableView.top = ScreenHeight;
            _createFormView.top = tableViewTopConstant;
            _lightTitleLabel.text = @"OK";
        } completion:^(BOOL finished) {
            _hourPickerView.userInteractionEnabled = YES;
            _minutePickerView.userInteractionEnabled = YES;
        }];
    } else {
        // Animate from create form to list
        
        NSLog(@"selected week day:%@",_createFormView.weekDayView.selectedWeekDayArray);
        
        [_createFormView.weekDayView resetSelectState];
        
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _lightTitleLabel.text = @"+";
            _createFormView.top = ScreenHeight;
            _listTableView.top = tableViewTopConstant;
        } completion:^(BOOL finished) {
            _hourPickerView.userInteractionEnabled = NO;
            _minutePickerView.userInteractionEnabled = NO;
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
