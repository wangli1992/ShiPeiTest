//
//  WLCustomerVC.m
//  
//
//  Created by Ernie Liu on 16/12/20.
//
//

#import "WLCustomerVC.h"

@interface WLCustomerVC ()

@end

@implementation WLCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBarTintColor:TMGlobalBg];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]init];
    item1.title = @"返回";
    //item1.tintColor = [UIColor whiteColor];
    
    self.navigationItem.backBarButtonItem = item1;
    
    
    
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
