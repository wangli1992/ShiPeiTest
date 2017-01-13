//
//  TMCollectionVC.h
//  
//
//  Created by Ernie Liu on 17/1/3.
//
//

#import <UIKit/UIKit.h>
#import "WLCustomerVC.h"

@interface TMCollectionVC : WLCustomerVC<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollection;

@end
