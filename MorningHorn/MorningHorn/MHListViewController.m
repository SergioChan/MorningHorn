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

@interface MHListViewController ()<MHWheelPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) MHWheelPickerView *hourPickerView;
@property (nonatomic, strong) MHWheelPickerView *minutePickerView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *alarmArray;
@end

@implementation MHListViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MHBackgroundPurpleColor;
    self.alarmArray = [NSMutableArray arrayWithObjects:@"09:45",@"20:30",@"05:46",nil];
    
    self.hourPickerView = [[MHWheelPickerView alloc]initWithFrame:CGRectMake(-150.0f, - (ScreenWidth + 300.0f)/2.0f - 200.0f, ScreenWidth + 300.0f, ScreenWidth + 300.0f) delegate:self type:MHPickerHour];

    MHWheelPickerBackView *hourBackView = [[MHWheelPickerBackView alloc]initWithFrame:_hourPickerView.frame type:MHPickerHour];
    
    self.minutePickerView = [[MHWheelPickerView alloc]initWithFrame:CGRectMake(-450.0f, - (ScreenWidth + 900.0f)/2.0f - 400.0f, ScreenWidth + 900.0f, ScreenWidth + 900.0f) delegate:self type:MHPickerMinute];
    
    MHWheelPickerBackView *minuteBackView = [[MHWheelPickerBackView alloc]initWithFrame:_minutePickerView.frame type:MHPickerMinute];

    [self.view addSubview:minuteBackView];
    [self.view addSubview:hourBackView];
    
    [self.view addSubview:_minutePickerView];
    [self.view addSubview:_hourPickerView];
    
//    _hourPickerView.userInteractionEnabled = NO;
//    _minutePickerView.userInteractionEnabled = NO;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, _minutePickerView.bottom + 80.0f, ScreenWidth, ScreenHeight - _minutePickerView.bottom - 80.0f) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = YES;
    
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfItemsInWheelView:(MHWheelPickerView *)wheelView
{
    if(wheelView.type == MHPickerHour)
        return 24;
    else
        return 60;
}

- (void)wheelView:(MHWheelPickerView *)wheelView didSelectItemAtIndex:(NSInteger)index
{
    if(wheelView.type == MHPickerHour)
        NSLog(@"hour :%ld",index);
    else
        NSLog(@"minute: %ld",index);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    if(!cell)
    {
        cell = [[MHListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
    }
    cell.dateLabel.text = [self.alarmArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
