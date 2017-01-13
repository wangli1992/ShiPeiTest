//
//  WLMapViewVC.m
//  
//
//  Created by Ernie Liu on 17/1/13.
//
//

#import "WLMapViewVC.h"

@interface WLMapViewVC ()
{
    BMKMapView *_mapView;
}
@end

@implementation WLMapViewVC
-(BMKGeoCodeSearch*)geocodesearch{
    if(!_geocodesearch){
        _geocodesearch=[[BMKGeoCodeSearch alloc]  init];
        _geocodesearch.delegate=self;
    }
    return _geocodesearch;
}
-(BMKLocationService*)locService{
    if(!_locService){
        _locService=[[BMKLocationService alloc]  init];
        _locService.delegate=self;
    }
    return _locService;
}
-(void)viewWillAppear:(BOOL)animated
{
    _mapView.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    _mapView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc] initWithFrame:self.mapBackView.bounds];
    // _mapView.frame = self.mapBackView.bounds;
    [_mapView setMapType:BMKMapTypeStandard];
    [_mapView setZoomEnabled:YES];//设置地图是否允许 多点缩放
    [_mapView setZoomLevel:13];//级别，3-19(13)
    _mapView.showMapScaleBar = YES;
    _mapView.centerCoordinate = (CLLocationCoordinate2D){[[UD objectForKey:@"baidu_current_lat"] floatValue],[[UD objectForKey:@"baidu_current_long"] floatValue]};
    [self.mapBackView addSubview:_mapView];
    NSLog(@"m高度为:%.1f,m宽度:%.1f",self.mapBackView.bounds.size.height,self.mapBackView.bounds.size.width);
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
