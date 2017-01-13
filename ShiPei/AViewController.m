//
//  AViewController.m
//  
//
//  Created by Ernie Liu on 16/12/13.
//
//
#import "AViewController.h"
#import "BViewController.h"
#import "ScrollerVCTest.h"
#import "TMTimeChooseVC.h"
#import "TMCollectionVC.h"
#import "WLDongHuaVC.h"
#import "WLMapViewVC.h"
@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
}
- (IBAction)buttonClick:(UIButton *)sender
{
    if(sender.tag ==1)
    {
       BViewController *bvc = [[BViewController alloc]init];
      [self.navigationController pushViewController:bvc animated:YES];
    }
    else if (sender.tag==2)
    {
        ScrollerVCTest *scrollerVC = [[ScrollerVCTest alloc]init];
        scrollerVC.title = @"滚动视图";
        [self.navigationController pushViewController:scrollerVC animated:YES];
    }
    else if (sender.tag==3)
    {
        TMTimeChooseVC *tvc = [[TMTimeChooseVC alloc]init];
        tvc.title = @"时间选择器";
        [self.navigationController pushViewController:tvc animated:YES];
    }
     else if (sender.tag==4)
     {
         TMCollectionVC *collectionVC = [[TMCollectionVC alloc]init];
         collectionVC.title = @"瀑布流";
         [self.navigationController pushViewController:collectionVC animated:YES];
     }
    else if(sender.tag==5)
    {
        WLDongHuaVC *dvc = [[WLDongHuaVC alloc]init];
        dvc.title = @"动画";
        [self.navigationController pushViewController:dvc animated:YES];
    }
    else
    {
        WLMapViewVC *mapVC = [[WLMapViewVC alloc]init];
        [self.navigationController pushViewController:mapVC animated:YES];
    }
    
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
