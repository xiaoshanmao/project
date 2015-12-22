//
//  AppDelegate.m
//  buDing —1
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 TabBarController. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ThirdViewController.h"
#import "ViewController.h"
#import "LeftViewController.h"
#import "SeconderViewController.h"

#import "MMDrawerController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *firstVC = [ViewController new];
    //也会在导航条上面显示。
    //firstVC.title = @"fanzu";
    SeconderViewController *secondeVC = [SeconderViewController new];
    ThirdViewController *thirdVC = [ThirdViewController new];
    LeftViewController *leftVC = [LeftViewController new];
    
    UINavigationController *fristNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
     UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondeVC];
     UINavigationController *thirdNav = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.viewControllers = @[fristNav, secondNav, thirdNav];
    
//    UITabBarItem *item1 = tabBarController.tabBar.items[0];
//    UITabBarItem *item2 = tabBarController.tabBar.items[1];
//    UITabBarItem *item3 = tabBarController.tabBar.items[2];
//    
//    item1.title = @"番组";
//    item2.title = @"时间线";
//    item3.title = @"异次元";
    
    UIImage *thirdImage1 = [UIImage imageNamed:@"global_footer_btn_dimension_normal"];
    thirdImage1 = [thirdImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *thirdImage2 = [UIImage imageNamed:@"global_footer_btn_dimension_selected"];
    thirdImage2 = [thirdImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:thirdImage1 selectedImage:thirdImage2];
   
    
    UIImage *fristImage1 = [UIImage imageNamed:@"global_footer_btn_new_normal"];
    fristImage1 = [fristImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *fristImage2 = [UIImage imageNamed:@"global_footer_btn_new_selected"];
    fristImage2 = [fristImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fristNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:fristImage1 selectedImage:fristImage2];
    
    
    UIImage *secondImage1 = [UIImage imageNamed:@"global_footer_btn_timeline_normal"];
    secondImage1 = [secondImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *secondImage2 = [UIImage imageNamed:@"global_footer_btn_timeline_selected"];
    secondImage2 = [secondImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    secondNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:secondImage1 selectedImage:secondImage2];
    
    MMDrawerController *drswerController = [[MMDrawerController alloc] initWithCenterViewController:tabBarController leftDrawerViewController:leftVC];
    //去除left与第一个页面接触部分的阴影
    drswerController.shadowRadius = 1;
    drswerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drswerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    self.window.rootViewController = drswerController;
    [self.window makeKeyAndVisible];
    return YES;
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
}

@end
