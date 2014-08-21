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
    
//    [[transitionContext containerView] addSubview:fromViewController.view];
    [[transitionContext containerView] addSubview:toViewController.view];
    
//    toViewController.view.alpha = 0;
    
    toViewController.view.frame =  CGRectMake(fromViewController.view.bounds.size.width, 0,
                                             fromViewController.view.bounds.size.width,
                                             fromViewController.view.bounds.size.height);
    
    CGRect endFrame = CGRectMake(-fromViewController.view.bounds.size.width, 0,
                                 fromViewController.view.bounds.size.width,
                                 fromViewController.view.bounds.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0 usingSpringWithDamping:1.0
          initialSpringVelocity:0.5
                        options:0
                     animations:^{
//                         fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
//                         fromViewController.view.transform = CGAffineTransformMakeTranslation(fromViewController.view.bounds.size.width, 0.0f);
//                         toViewController.view.alpha = 1;
                         
                         toViewController.view.frame = fromViewController.view.frame;
                         fromViewController.view.frame = endFrame;
                         
                         
                     } completion:^(BOOL finished) {
                         fromViewController.view.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}



/*
 
 newC.view.frame =  CGRectMake(self.view.bounds.size.width, 0,
 self.view.bounds.size.width,
 self.view.bounds.size.height);
 
 CGRect endFrame = CGRectMake(-self.view.bounds.size.width, 0,
 self.view.bounds.size.width,
 self.view.bounds.size.height)
 
 [self transitionFromViewController: oldC
 toViewController: newC
 duration: 0.15
 options: UIViewAnimationOptionCurveEaseOut
 animations:
 ^{
 newC.view.frame = oldC.view.frame;
 oldC.view.frame = endFrame;
 }
 completion:^(BOOL finished) {
 [oldC removeFromParentViewController];
 [newC didMoveToParentViewController:self];
 }];
 
 
 */
@end
