//
//  ScrollerVCTest.h
//  
//
//  Created by Ernie Liu on 16/12/29.
//
//

#import <UIKit/UIKit.h>
#import "WLCustomerVC.h"
@interface ScrollerVCTest : WLCustomerVC<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollerView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
