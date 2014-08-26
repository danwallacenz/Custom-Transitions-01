//
//  DWNavigationControllerDelegate.m
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 22/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "DWNavigationControllerDelegate.h"
#import "DWPushAnimator.h"
#import "DWPopAnimator.h"
#import "DWFirstViewController.h"
#import "DWSecondViewController.h"


@interface DWNavigationControllerDelegate()

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end


@implementation DWNavigationControllerDelegate


-(instancetype) initWithNavigationController: (UINavigationController *)navigationController
{
    self = [super init];
    if (self) {
        
        self.navigationController = navigationController;
        
        UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self.navigationController.view addGestureRecognizer:panRecognizer];
        
    }
    return self;
}


#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [[DWPushAnimator alloc] init];
    }
    if (operation == UINavigationControllerOperationPop) {
        return [[DWPopAnimator alloc] init];
    }
    return nil;
    
}


-(void)pan:(UIPanGestureRecognizer*)recognizer
{
    UIView *view = self.navigationController.topViewController.view;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint location = [recognizer locationInView:view];
        
        if (location.x <  CGRectGetMidX(view.bounds) && self.navigationController.viewControllers.count > 1) { // left half
            if([self.navigationController.topViewController isKindOfClass:[DWSecondViewController class]]){
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    
        if (location.x >  CGRectGetMidX(view.bounds) && self.navigationController.viewControllers.count == 1) { // right half
            if([self.navigationController.topViewController isKindOfClass:[DWFirstViewController class]]){
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController pushViewController: [[DWSecondViewController alloc] init] animated:YES];
            }
        }
    
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if(self.navigationController.viewControllers.count > 1){
            //push
            if([recognizer velocityInView:view].x < 0  && self.interactionController.percentComplete > .3){
                [self.interactionController finishInteractiveTransition];
            } else {
                [self.interactionController cancelInteractiveTransition];
            }
        }else{ // pop
            
            if([recognizer velocityInView:view].x > 0 && self.interactionController.percentComplete > .3){
                [self.interactionController finishInteractiveTransition];
            } else {
                [self.interactionController cancelInteractiveTransition];
            }
        }
        
        self.interactionController = nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}
@end
