//
//  BViewController.h
//  
//
//  Created by Ernie Liu on 16/12/20.
//
//

#import <UIKit/UIKit.h>
#import "WLCustomerVC.h"
@interface BViewController : WLCustomerVC<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@end
