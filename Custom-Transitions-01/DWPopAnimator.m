//
//  DWPopAnimator.m
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 22/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "DWPopAnimator.h"

@implementation DWPopAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];

    
    NSDictionary *bindings = @{@"fromView":fromViewController.view, @"toView":toViewController.view};
    
    // From VC Constraints
    fromViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *fromViewHorizontalConstraints
        = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[fromView]-|"
                                                  options:0
                                                  metrics:nil
                                                    views:bindings];
    [fromViewController.view.superview addConstraints:fromViewHorizontalConstraints];
    
    NSArray *fromViewVerticalConstraints
        = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[fromView]-|"
                                              options:0
                                              metrics:nil
                                                views:bindings];
     [fromViewController.view.superview addConstraints:fromViewVerticalConstraints];
    
    
    // To VC Constraints
    
    
    
    
    toViewController.view.frame =  CGRectMake(-fromViewController.view.bounds.size.width, 0,
                                              fromViewController.view.bounds.size.width,
                                              fromViewController.view.bounds.size.height);
    
    CGRect endFrame = CGRectMake(fromViewController.view.bounds.size.width, 0,
                                 fromViewController.view.bounds.size.width,
                                 fromViewController.view.bounds.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:0
                     animations:^{
                         
                         toViewController.view.frame = fromViewController.view.frame;
                         fromViewController.view.frame = endFrame;
//                         NSLog(@"ANIMATING - POP. Interactive gesture recognizer takes over from here.");
                         
                     } completion:^(BOOL finished) {
                         
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         
                         if(![transitionContext transitionWasCancelled]){
                             
                             [fromViewController.view removeFromSuperview];
//                             NSLog(@"POP animation completion - %d view controllers present.\n\n", toViewController.navigationController.viewControllers.count);
                             
                         }else{
                             
//                             NSLog(@"POP animation cancelled - %d view controllers present.\n\n", fromViewController.navigationController.viewControllers.count);
                         }
                         
                     }];
}

@end
