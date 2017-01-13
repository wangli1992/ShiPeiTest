//
//  WLCustomerVC.h
//  
//
//  Created by Ernie Liu on 16/12/20.
//
//
#define UD   [NSUserDefaults standardUserDefaults]
#define Screen_Width self.view.bounds.size.width
#define Screen_Height self.view.bounds.size.height
#define TMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:0.9]
#define TMGlobalBg TMColor(40, 110, 236)
#import <UIKit/UIKit.h>
#import "UIViewController+MBProgressHUD.h"

@interface WLCustomerVC : UIViewController

@end
