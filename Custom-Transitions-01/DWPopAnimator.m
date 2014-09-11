//
//  DWPopAnimator.m
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 22/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "DWPopAnimator.h"
#import "DWXXViewController.h"

@implementation DWPopAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    
    NSArray *fromViewControllerConstraints = ((DWXXViewController *)fromViewController).view.constraints;
    NSArray *toViewControllerConstraints = ((DWXXViewController *)toViewController).view.constraints;
    
    NSLog(@"fromViewController.view.frame = %@", NSStringFromCGRect(fromViewController.view.frame));
    NSLog(@"toViewController.view.frame = %@", NSStringFromCGRect(toViewController.view.frame));
    
//    [toViewController.view removeConstraints:toViewControllerConstraints];
    
//    NSDictionary *bindings = @{@"toBackgroundView":((DWXXViewController *)toViewController).backgroundView,
//                               @"toView":((DWXXViewController *)toViewController).view,
//                               @"fromBackgroundView":((DWXXViewController *)fromViewController).backgroundView,
//                               @"fromView":((DWXXViewController *)fromViewController).view};
    
    // Stretch horizontally - temporary insets.
//    NSDictionary *metrics = @{@"width": @(toViewController.view.frame.size.width)};
    

    CGFloat width = toViewController.view.frame.size.width;
    NSLayoutConstraint *toViewOffsetConstraint = [NSLayoutConstraint constraintWithItem:((DWXXViewController *)toViewController).backgroundView
                                                              attribute:NSLayoutAttributeTrailing
                                                              relatedBy:NSLayoutRelationLessThanOrEqual
                                                                 toItem:toViewController.view
                                                              attribute:NSLayoutAttributeTrailing
                                                             multiplier:1.0
                                                               constant:-width];

    [toViewController.view addConstraint:toViewOffsetConstraint];
    [toViewController.view layoutIfNeeded];
    //
//    toViewController.view.frame =  CGRectMake(-fromViewController.view.bounds.size.width, 0,
//                                              fromViewController.view.bounds.size.width,
//                                              fromViewController.view.bounds.size.height);
    
    
    // From VC offset
    NSLayoutConstraint *fromViewOffsetConstraint
        = [NSLayoutConstraint constraintWithItem:((DWXXViewController *)fromViewController).backgroundView
                                      attribute:NSLayoutAttributeLeading
                                      relatedBy:NSLayoutRelationLessThanOrEqual
                                         toItem:fromViewController.view
                                      attribute:NSLayoutAttributeLeading
                                     multiplier:1.0
                                       constant:0.0];
    [fromViewController.view addConstraint:fromViewOffsetConstraint];
    [fromViewController.view layoutIfNeeded];
    
    // TODO Make this frame into constraints
    CGRect endFrame = CGRectMake(fromViewController.view.bounds.size.width, 0,
                                 fromViewController.view.bounds.size.width,
                                 fromViewController.view.bounds.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:0
                     animations:^{
                         toViewOffsetConstraint.constant = 0.0;
                         [toViewController.view layoutIfNeeded];
//                         
                         fromViewOffsetConstraint.constant = -width;
                         [fromViewController.view layoutIfNeeded];
                         
//                         toViewController.view.frame = fromViewController.view.frame;
                         
                         
//                         fromViewController.view.frame = endFrame;
//                         NSLog(@"ANIMATING - POP. Interactive gesture recognizer takes over from here.");
                         
                     } completion:^(BOOL finished) {
                         
                         [toViewController.view removeConstraint:toViewOffsetConstraint];
                         [fromViewController.view removeConstraint:fromViewOffsetConstraint];
                         
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
