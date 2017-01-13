//
//  TMTimeChooseVC.m
//  
//
//  Created by Ernie Liu on 16/12/30.
//
//

#import "TMTimeChooseVC.h"

@interface TMTimeChooseVC ()
{
    NSTimer *timer;
    UIDatePicker *myDatePicker;
}
@property(nonatomic,retain)NSString *recordTime;
@end

@implementation TMTimeChooseVC
@synthesize recordTime;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextSecond) userInfo:nil repeats:YES];
}
//弹出时间选择框
- (IBAction)hideDatePicker:(UIButton *)sender {
    if(sender.tag==1)
    {
        myDatePicker.hidden = NO;
    }
    else
    {
        myDatePicker.hidden = YES;
        if([recordTime isEqualToString:@""]||recordTime==nil)
        {
            recordTime = [self getChooseTime];
            
        }
        self.chooseLab.text = recordTime;
    }
}
-(void)nextSecond
{
    [self getNowTime];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
    timer = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor lightGrayColor];
   myDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(10, 60, 300, 216)];
    //日期选择类型
    myDatePicker.datePickerMode = UIDatePickerModeDate;
    [myDatePicker addTarget:self action:@selector(chooseTime:) forControlEvents:  UIControlEventValueChanged ];
    //myDatePicker.minuteInterval = 0.5;
    myDatePicker.hidden = YES;
    [self.view addSubview:myDatePicker];
   
      [self getNowTime];
}
-(void)chooseTime:(UIDatePicker *)datePicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //设置日期格式
    [formatter setAMSymbol:@"上午"];
    [formatter setPMSymbol:@"下午"];
    NSArray *weekArr = [NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五", @"星期六",nil];
    [formatter setWeekdaySymbols:weekArr];
    [formatter setDateFormat:@"yyyy-MM-dd eeee "];
    NSString *nowTime = [formatter stringFromDate:datePicker.date];
    recordTime = nowTime;
 
}
-(void)getNowTime
{
    NSDate *date = [NSDate date];
    NSLog(@"1美国当前时间为:%@",date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //设置日期格式
    [formatter setAMSymbol:@"上午"];
    [formatter setPMSymbol:@"下午"];
    NSArray *weekArr = [NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五", @"星期六",nil];
    [formatter setWeekdaySymbols:weekArr];
    [formatter setDateFormat:@"yyyy-MM-dd eeee a hh:mm:ss"];
    NSString *nowTime = [formatter stringFromDate:date];
    self.timeLab.text = nowTime;
}
-(NSString *)getChooseTime
{
    NSDate *date = [NSDate date];
    NSLog(@"2美国当前时间为:%@",date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //设置日期格式
    [formatter setAMSymbol:@"上午"];
    [formatter setPMSymbol:@"下午"];
    NSArray *weekArr = [NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五", @"星期六",nil];
    [formatter setWeekdaySymbols:weekArr];
    [formatter setDateFormat:@"yyyy-MM-dd eeee "];
    NSString *nowTime = [formatter stringFromDate:date];
    return nowTime;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
