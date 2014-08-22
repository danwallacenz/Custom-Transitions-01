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

    
    toViewController.view.frame =  CGRectMake(fromViewController.view.bounds.size.width, 0,
                                             fromViewController.view.bounds.size.width,
                                             fromViewController.view.bounds.size.height);
    
    CGRect endFrame = CGRectMake(-fromViewController.view.bounds.size.width, 0,
                                 fromViewController.view.bounds.size.width,
                                 fromViewController.view.bounds.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.5
                        options:0
                     animations:^{
                         
                         toViewController.view.frame = fromViewController.view.frame;
                         fromViewController.view.frame = endFrame;
                         
                         
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                          NSLog(@"PUSH - %d view controllers present", toViewController.navigationController.viewControllers.count);
                     }];
}

@end