//
//  WLDongHuaVC.m
//  
//
//  Created by Ernie Liu on 17/1/11.
//
//
#define BaseStatue -2*M_PI/24
#import "WLDongHuaVC.h"
#import "WLMapViewVC.h"
@interface WLDongHuaVC ()
{
    CALayer *myLayer;
    UIView *backView ;
    UIImageView *indicateImg1;
    CGFloat angle1;
    float angle;
    CGFloat angle2;
    BOOL flag;
    NSTimer *timer;
    BMKMapView *_mapView;
}
@property (weak, nonatomic) IBOutlet UILabel *latLab;
@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UIView *mapBackView;

@end

@implementation WLDongHuaVC

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
    [self createDongHua];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.latLab.text = [NSString stringWithFormat:@"%@ , %@",[UD objectForKey:@"baidu_current_lat"],[UD objectForKey:@"baidu_current_long"]] ;
     [self.locService startUserLocationService];
    [self updateAddress];
   _mapView = [[BMKMapView alloc] initWithFrame:self.mapBackView.bounds];
   // _mapView.frame = self.mapBackView.bounds;
    [_mapView setMapType:BMKMapTypeStandard];
    [_mapView setZoomEnabled:YES];//设置地图是否允许 多点缩放
    [_mapView setZoomLevel:13];//级别，3-19(13)
    _mapView.showMapScaleBar = YES;
    _mapView.centerCoordinate = (CLLocationCoordinate2D){[[UD objectForKey:@"baidu_current_lat"] floatValue],[[UD objectForKey:@"baidu_current_long"] floatValue]};
    [self.mapBackView addSubview:_mapView];
    NSLog(@"lable的宽度为:%.1f",self.latLab.bounds.size.width);
    NSLog(@"高度为:%.1f,宽度:%.1f",self.mapBackView.bounds.size.height,self.mapBackView.bounds.size.width);
}
//根据经纬度获取当前位置 -(百度地图)
-(void)updateAddress
{
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){[[UD objectForKey:@"baidu_current_lat"] floatValue],[[UD objectForKey:@"baidu_current_long"] floatValue]};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init]; //创建检索对象
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag1 = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag1)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }


}
#pragma mark ReverseGeoCodeDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if(error==0)
    {
         NSString *city = result.addressDetail.city;
        NSString *district = result.addressDetail.district;
        NSString * street = result.addressDetail.streetName;
        NSLog(@"city==%@",city);
        self.cityLab.text = [NSString stringWithFormat:@"%@%@%@",city,district,street];
    }
}
-(void)createDongHua
{
    //    myLayer = [CALayer layer];
    //    myLayer.backgroundColor = [UIColor orangeColor].CGColor;
    //    myLayer.bounds = CGRectMake(0, 0, 80, 80);
    //    myLayer.position = CGPointMake(30, 30);
    //    myLayer.anchorPoint = CGPointMake(0, 0);
    //    [self.view.layer addSublayer:myLayer];
    backView = [[UIView alloc]initWithFrame:CGRectMake(100,280, 80, 80)];
    backView.backgroundColor = [UIColor cyanColor];
    //[self.view addSubview:backView];
    backView.layer.anchorPoint = CGPointMake(1, 1);
    backView.layer.position = CGPointMake(180, 360);
    UIImageView *tableImg = [[UIImageView alloc]initWithFrame:CGRectMake(14, 25, 136, 113)];
    tableImg.image = [UIImage imageNamed:@"RunTable"];
    [self.view addSubview:tableImg];
    
    indicateImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(19, 109, 64, 4)];
    indicateImg1.image = [UIImage imageNamed:@"indicate"];
    [self.view addSubview:indicateImg1];
    //设置锚点
    indicateImg1.layer.anchorPoint = CGPointMake(1, 0.5);//(0,0)表示左上角 (1,1)表示右下角,(0.5,0.5)中心点
    //设置旋转位置
    indicateImg1.layer.position = CGPointMake(82, 111);
    angle1 = M_PI/24;//弧度制
    angle = M_PI/120;
    indicateImg1.transform = CGAffineTransformMakeRotation(BaseStatue);//一小格大约是 π/24 表盘总度数约为:28*π/24 速度为x 对应的弧度为:x*π/120
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(afterClick) userInfo:nil repeats:YES];
    
}
-(void)afterClick
{
   int a = arc4random()%141;
   // NSLog(@"a====%d",a);
    float b = a*M_PI/120;
    angle2 = angle2 + 0.5;
        [UIView animateWithDuration:1 animations:^{
        indicateImg1.transform = CGAffineTransformMakeRotation(BaseStatue+b);
    } completion:^(BOOL finished) {
        
    }];
 if(angle2>6.28)
 {
     angle2 = 0;
 }
    //backView.transform = CGAffineTransformMakeRotation(angle2);
}
- (IBAction)animateClickMethod:(UIButton *)sender
{
    if(sender.tag ==1)
    {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:5];
//       backView.backgroundColor = [UIColor redColor];
//        // myLayer.bounds = CGRectMake(0, 0, 160, 160);
//        [UIView commitAnimations];
//        WLMapViewVC *mapVC = [[WLMapViewVC alloc]init];
//        [self.navigationController pushViewController:mapVC animated:YES];
       
    }
    else if (sender.tag==2)//旋转动画
    {
        
        [UIView animateWithDuration:1 animations:^{
            indicateImg1.transform = CGAffineTransformMakeRotation(BaseStatue+12*angle1);
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        
        if(flag==NO)
        {
         [timer invalidate];
          timer = nil;
            flag = YES;
        }
      else  if(flag ==YES)
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(afterClick) userInfo:nil repeats:YES];
            flag = NO;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //myLayer.backgroundColor = [UIColor redColor].CGColor;
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
