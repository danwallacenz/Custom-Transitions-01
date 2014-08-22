//
//  DWPushAnimator.m
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 22/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "DWPushAnimator.h"

@implementation DWPushAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];

    NSLog(@"initialFrameForViewController:fromViewController = %@", NSStringFromCGRect([transitionContext initialFrameForViewController:fromViewController]));
    NSLog(@"initialFrameForViewController:toViewController = %@", NSStringFromCGRect([transitionContext initialFrameForViewController:toViewController]));
    
    
    NSLog(@"finalFrameForViewController:fromViewController = %@", NSStringFromCGRect([transitionContext finalFrameForViewController:fromViewController]));
    NSLog(@"finalFrameForViewController:toViewController = %@", NSStringFromCGRect([transitionContext finalFrameForViewController:toViewController]));
    
    NSLog(@"isAnimated = %@", [transitionContext isAnimated]?@"YES":@"NO");
    NSLog(@"isInteractive = %@", [transitionContext isInteractive]?@"YES":@"NO");
    
    toViewController.view.frame =  CGRectMake(fromViewController.view.bounds.size.width, 0,
                                             fromViewController.view.bounds.size.width,
                                             fromViewController.view.bounds.size.height);
    
    CGRect endFrame = CGRectMake(-fromViewController.view.bounds.size.width, 0,
                                 fromViewController.view.bounds.size.width,
                                 fromViewController.view.bounds.size.height);
    
//    toViewController.view.userInteractionEnabled = NO;
//    fromViewController.view.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:0
                     animations:^{
                         
                         toViewController.view.frame = fromViewController.view.frame;
                         fromViewController.view.frame = endFrame;
                         
                         
                     } completion:^(BOOL finished) {
                         
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         
                         if(![transitionContext transitionWasCancelled]){
                             [fromViewController.view removeFromSuperview];
                             toViewController.navigationController.title = toViewController.title;
                         }
                         
//                         toViewController.view.userInteractionEnabled = YES;
//                         fromViewController.view.userInteractionEnabled = YES;
                          NSLog(@"PUSH - %d view controllers present", toViewController.navigationController.viewControllers.count);
                     }];
}

@end