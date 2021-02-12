//
//  AppDelegate.m
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import "AppDelegate.h"
#import "iOSTest-Swift.h"
#import "SVProgressHUD.h"

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    MenuViewController *mainMenuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:mainMenuViewController];
    [self.navController setNavigationBarHidden:NO];
    self.window.rootViewController = self.navController;
    
    // customizes SVProgressHUD loading indicator
    [SVProgressHUD setRingRadius:1.0];
    [SVProgressHUD setForegroundColor:UIColor.blueColor];
    
    return YES;
}

- (void) configureProgressIndicator
{
    
}

@end
