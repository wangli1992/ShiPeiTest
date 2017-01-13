//
//  BViewController.m
//  
//
//  Created by Ernie Liu on 16/12/20.
//
//
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
#import "BViewController.h"
#import "BCell.h"

@interface BViewController ()

@property (strong, nonatomic) NSMutableArray *fakeData;

@end

@implementation BViewController

-(NSMutableArray *)fakeData
{
    if(!_fakeData)
    {
        self.fakeData = [NSMutableArray array];
        for (int i = 0; i<7; i++) {
            [self.fakeData addObject:MJRandomData];
        }

    }
    return _fakeData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二页";
    UIView *footView = [[UIView alloc]initWithFrame:CGRectZero];
    
   // footView.backgroundColor = [UIColor whiteColor];
    self.myTable.tableFooterView = footView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fakeData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCell"];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BCell" owner:nil options:nil] objectAtIndex:0];
    }
    UIImage *getImage = [UIImage imageNamed:@"B_gas"];
    cell.headImge.image = getImage;
    NSData *imageData = UIImageJPEGRepresentation(getImage, 1);
    float length = [imageData length]/1024;
    cell.testLab .text = self.fakeData[indexPath.row];        NSLog(@"图片大小为:%.2fKB ",length);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row==self.fakeData.count-1)
//    {
//       // [self hideHUD];
//    }else
//    {
//        [self showHUD];
//        for(int a;a<5;a++)
//        {
//            [self.fakeData addObject: MJRandomData];
//        }
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 刷新表格
//            //[self.myTable reloadData];
//            
//            
//            [self hideHUD];
//        });
//
//    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
