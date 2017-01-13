//
//  AppDelegate.m
//  ShiPei
//
//  Created by Ernie Liu on 16/12/13.
//  Copyright (c) 2016年 Ernie Liu. All rights reserved.
//

#import "AppDelegate.h"
#import "AViewController.h"


@interface AppDelegate ()

@property(nonatomic,strong) BMKMapManager   *mapManager;
@property (nonatomic,strong) BMKLocationService* locService;
@end

@implementation AppDelegate

#pragma  makr - locService
-(BMKLocationService*)locService{
    if(!_locService){
        _locService=[[BMKLocationService alloc]  init];
        _locService.delegate=self;
    }
    return _locService;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    AViewController *vc = [[AViewController alloc]init];
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nv;
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    
    _mapManager=[[BMKMapManager alloc]  init];
    
    BOOL ret=[_mapManager start: @"4LZuVbGVbKdbNp65bNkKWvPfKM6biXG2" generalDelegate:nil];
    if(!ret){
        NSLog(@"Baidu Map Manager Start failed!");
        
        //init baidu navigation
    }
    _locService =[[BMKLocationService alloc]init];
   _locService.delegate = self;
    [_locService startUserLocationService];
    return YES;
}
-(void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
//    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

#pragma  make - implement location delegate
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    //    NSTimeInterval howRecent = [userLocation..timestamp timeIntervalSinceNow];
    //    if(howRecent < -10) return; //离上次更新的时间少于10秒
    //    if(newLocation.horizontalAccuracy > 100) return; //精度> 100米
    
    //        [_mapView updateLocationData:userLocation];
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,
          userLocation.location.coordinate.longitude);
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f", userLocation.location.coordinate.longitude] forKey:@"baidu_current_long"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude]  forKey:@"baidu_current_lat"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //展示用户位置
   // _mapView.showsUserLocation = YES;
    //更新用户当前的坐标。
   // [_mapView updateLocationData:userLocation];
    //追到当前位置之后 就停止定位
    [_locService stopUserLocationService];
    
    //    _mapView.centerCoordinate=userLocation.location.coordinate;
    
    //    _mapView.showsUserLocation=NO;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "-17lng.com.ShiPei" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ShiPei" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ShiPei.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
