//
//  ScrollerVCTest.m
//  
//
//  Created by Ernie Liu on 16/12/29.
//
//
#define  aWidth [UIScreen mainScreen].bounds.size.width
#define myWidth aWidth-60
#define myHeight self.backView.bounds.size.height
#import "ScrollerVCTest.h"

@interface ScrollerVCTest ()
{
    int speed;
    UIPageControl *page;
    NSTimer *timer;
    UIScrollView *myScroller;
}
@end

@implementation ScrollerVCTest

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"++%.1f",myWidth);
    timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    myScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, aWidth-60, myHeight)];
    myScroller.delegate = self;
    [self.backView addSubview:myScroller];
    myScroller.contentSize = CGSizeMake((aWidth-60)*4, 0);
    NSLog(@"scrollWidrth=%f,backWidth=%f,screenWidth=%f screenHeight=%f,mainScreen = %f",self.backView.bounds.size.width,myWidth,Screen_Width,Screen_Height,aWidth);
    for(int a=0;a<4;a++)
    {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(a*(aWidth-60), 0, aWidth-60, 157)];
        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"DF_0%d.jpg",a+1]];
        [myScroller addSubview:img];
    }
    myScroller.showsHorizontalScrollIndicator = NO;
   myScroller.showsVerticalScrollIndicator = NO;
    myScroller.pagingEnabled = YES;//是否分页显示
    page = [[UIPageControl alloc]initWithFrame:CGRectMake(aWidth-60-80 , 137, 10, 10)];
    page.pageIndicatorTintColor = [UIColor whiteColor];
    page.currentPageIndicatorTintColor = [UIColor blueColor];
    page.currentPage = 0;
    page.numberOfPages = 4;
    [self.backView addSubview:page];
    //设置page方法
    [page addTarget:self action:@selector(changePageNumber) forControlEvents:UIControlEventTouchUpInside];

}
-(void)changePageNumber
{
    myScroller.contentOffset = CGPointMake(page.currentPage*(aWidth-60), 0);
    
}
-(void)nextPage
{
    //2.5秒后
    if(page.currentPage == 0)
    {
      speed = 1;
    }
    if(page.currentPage == 3)
    {
        speed = -1;
    }
    page.currentPage = page.currentPage+speed;
    myScroller.contentOffset = CGPointMake((aWidth-60)*page.currentPage, 0);//偏移量
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"将要开始拖拽了");
    [timer invalidate];
    timer = nil;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"将要结束拖拽了,将要减速");
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"将要减速了");
   
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"结束减速了");
     page.currentPage = scrollView.contentOffset.x/(aWidth-60);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
