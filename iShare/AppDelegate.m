//
//  AppDelegate.m
//  iShare
//
//  Created by Khoa Le on 10/26/15.
//  Copyright © 2015 Khoa Le. All rights reserved.
//

#import "AppDelegate.h"
#import "GzNetworking.h"
#import "TestController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [TestController new];
    // Override point for customization after application launch.
    [[GzNetworking sharedInstance] GETCache:@"http://sentienich.aviostore.com/lottery/KQXS10Day.php?ma_tinh=1&so_lan_quay=1" parameters:nil refreshCache:YES success:^(id responseString) {
#if DEBUG
        NSLog(@"---log---> %@",responseString);
#endif
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
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
