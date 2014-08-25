//
//  DWAppDelegate.m
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 21/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "DWAppDelegate.h"
#import "DWFirstViewController.h"
#import "DWNavigationControllerDelegate.h"


@interface DWAppDelegate()

// You will have to keep the delegate object alive yourself. Normally objects do not retain their delegates.
@property (strong, nonatomic) DWNavigationControllerDelegate *dwNavigationControllerDelegate;

@end

@implementation DWAppDelegate


#pragma mark - App lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UIViewController *first = [[DWFirstViewController alloc] init];
    UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController: first];
    
    id<UINavigationControllerDelegate> dwNavigationControllerDelegate = [[DWNavigationControllerDelegate alloc] initWithNavigationController: navController];
    // You will have to keep the delegate object alive yourself. Normally objects do not retain their delegates.
    self.dwNavigationControllerDelegate = dwNavigationControllerDelegate;
    navController.delegate = dwNavigationControllerDelegate;
    
    [self.window setRootViewController:navController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
