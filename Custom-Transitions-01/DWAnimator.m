//
//  DWAnimator.m
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 21/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "DWAnimator.h"

@implementation DWAnimator


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    
    toViewController.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0 usingSpringWithDamping:1.0
          initialSpringVelocity:0.5
                        options:0
                     animations:^{
                         fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
                         toViewController.view.alpha = 1;
                     } completion:^(BOOL finished) {
                         fromViewController.view.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        toViewController.view.alpha = 1;
//    } completion:^(BOOL finished) {
//        fromViewController.view.transform = CGAffineTransformIdentity;
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
    
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    if(transitionCompleted){
        NSLog(@"animationEnded OK ");
    }else{
         NSLog(@"animationEnded NOT OK ");
    }
}

@end


