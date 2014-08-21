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
//#import "DWSecondViewController.h"
//#import "DWAnimator.h"


@interface DWAppDelegate()

//@property (strong, nonatomic) DWAnimator *animator;
//@property (strong, nonatomic) UINavigationController *navigationController;
//@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@property (strong, nonatomic) DWNavigationControllerDelegate *dwNavigationControllerDelegate;

@end

@implementation DWAppDelegate


#pragma mark - UINavigationControllerDelegate

//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                  animationControllerForOperation:(UINavigationControllerOperation)operation
//                                               fromViewController:(UIViewController *)fromVC
//                                                 toViewController:(UIViewController *)toVC
//{
////    if (operation == UINavigationControllerOperationPush) {
//        return self.animator;
////    }
////    return nil;
//
//}
//
//-(DWAnimator *)animator
//{
//    if(!_animator){
//        _animator = [[DWAnimator alloc] init];
//    }
//    return _animator;
//}


#pragma mark - App lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    UIViewController *first = [[DWFirstViewController alloc] init];
    UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController: first];
//    self.navigationController = navController;
    
//    navController.delegate = self;
    
    id<UINavigationControllerDelegate> dwNavigationControllerDelegate = [[DWNavigationControllerDelegate alloc] initWithNavigationController: navController];
    // You will have to keep the delegate object alive yourself. Normally objects do not retain their delegates.
    self.dwNavigationControllerDelegate = dwNavigationControllerDelegate;
    navController.delegate = dwNavigationControllerDelegate;
    
    [self.window setRootViewController:navController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//    [navController.view addGestureRecognizer:panRecognizer];
    
    return YES;
}

//-(void)pan:(UIPanGestureRecognizer*)recognizer
//{
//    NSLog(@"pan:");
// 
//    UIView *view = self.navigationController.topViewController.view;
//
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        CGPoint location = [recognizer locationInView:view];
//        
//        if (location.x <  CGRectGetMidX(view.bounds) && self.navigationController.viewControllers.count > 1) { // left half
//            if([self.navigationController.topViewController isKindOfClass:[DWSecondViewController class]]){
//                self.interactionController = [UIPercentDrivenInteractiveTransition new];
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//        }
//        
//        if (location.x >  CGRectGetMidX(view.bounds) && self.navigationController.viewControllers.count == 1) { // right half
//            if([self.navigationController.topViewController isKindOfClass:[DWFirstViewController class]]){
//                self.interactionController = [UIPercentDrivenInteractiveTransition new];
//                [self.navigationController pushViewController: [[DWSecondViewController alloc] init] animated:YES];
//            }
//        }
//
//    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
//        
//        CGPoint translation = [recognizer translationInView:view];
//        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
//        [self.interactionController updateInteractiveTransition:d];
//        
//    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
//        
//        NSLog(@"velocityInView = %f", [recognizer velocityInView:view].x);
//        
//        if(self.navigationController.viewControllers.count > 1){ //pop
//            if([recognizer velocityInView:view].x < 0  && self.interactionController.percentComplete > .5){
//                [self.interactionController finishInteractiveTransition];
//            } else {
//                [self.interactionController cancelInteractiveTransition];
//            }
//        }else{ // push
//            if([recognizer velocityInView:view].x > 0 && self.interactionController.percentComplete > .5){
//                [self.interactionController finishInteractiveTransition];
//            } else {
//                [self.interactionController cancelInteractiveTransition];
//            }
//        }
//        
////        if (([recognizer velocityInView:view].x > 0 && [self.navigationController.topViewController isKindOfClass:[DWSecondViewController class]])) {
////            [self.interactionController finishInteractiveTransition];
////        } else {
////            [self.interactionController cancelInteractiveTransition];
////        }
////        
////        if(([recognizer velocityInView:view].x < 0 && [self.navigationController.topViewController isKindOfClass:[DWFirstViewController class]])) {
////            [self.interactionController finishInteractiveTransition];
////        } else {
////            [self.interactionController cancelInteractiveTransition];
////        }
//        
//        self.interactionController = nil;
//    }
//}

//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
//    return self.interactionController;
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
