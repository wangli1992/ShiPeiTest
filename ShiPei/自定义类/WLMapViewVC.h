//
//  WLMapViewVC.h
//  
//
//  Created by Ernie Liu on 17/1/13.
//
//

#import <UIKit/UIKit.h>
#import "WLCustomerVC.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

@interface WLMapViewVC :WLCustomerVC<BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,BMKMapViewDelegate>
@property(nonatomic,strong) BMKGeoCodeSearch* geocodesearch;
@property (nonatomic,strong) BMKLocationService* locService;
@property (weak, nonatomic) IBOutlet UIView *mapBackView;
@end
