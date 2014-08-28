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
#import "DWThirdViewController.h"


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
        NSLog(@"\n");
        NSLog(@"UIGestureRecognizerStateBegan");
        NSLog(@"self.navigationController.viewControllers.count = %d", self.navigationController.viewControllers.count);
        NSLog(@"topViewController = %@",[self.navigationController.topViewController class]);
        
        CGPoint location = [recognizer locationInView:view];
        BOOL panBeganInLeftSide = location.x <= CGRectGetMidX(view.bounds);
        BOOL panBeganInRightSide = !panBeganInLeftSide;
        
        
//        if (panBeganInLeftSide && self.navigationController.viewControllers.count >= 2) { // left half
        if (panBeganInLeftSide) { // left half
            if([self.navigationController.topViewController isKindOfClass:[DWSecondViewController class]]
               || [self.navigationController.topViewController isKindOfClass:[DWThirdViewController class]]){
                
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    
        if (panBeganInRightSide) { // right half
            if([self.navigationController.topViewController isKindOfClass:[DWFirstViewController class]]){
                
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController pushViewController: [[DWSecondViewController alloc] init] animated:YES];
            }else if([self.navigationController.topViewController isKindOfClass:[DWSecondViewController class]]){
                
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController pushViewController: [[DWThirdViewController alloc] init] animated:YES];
            }
        }
    
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
//        NSLog(@"UIGestureRecognizerStateChanged");
        NSLog(@"Moving %@",[recognizer velocityInView:view].x > 0?@"right": @"left");
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
        
        
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        
        NSLog(@"UIGestureRecognizerStateEnded");
        NSLog(@"self.navigationController.viewControllers.count = %d", self.navigationController.viewControllers.count);
        NSLog(@"Pan ended moving %@",[recognizer velocityInView:view].x > 0?@"right == pop": @"left == push");
        NSLog(@"topViewController = %@",[self.navigationController.topViewController class]);
        
        NSLog(@"percent complete %f%%", self.interactionController.percentComplete);
        NSLog(@"\n");
        
        BOOL panEndedMovingRight = [recognizer velocityInView:view].x < 0;
        BOOL panEndedMovingLeft = [recognizer velocityInView:view].x > 0;
        

        if(self.interactionController.percentComplete > .3){
            [self.interactionController finishInteractiveTransition];
            NSLog(@"FINISH INTERACTIVE TRANSITION");
        } else {
            [self.interactionController cancelInteractiveTransition];
                NSLog(@"CANCEL INTERACTIVE TRANSITION");
        }

        
//        if(self.navigationController.viewControllers.count > 1){
//            //push
//            if([recognizer velocityInView:view].x < 0  && self.interactionController.percentComplete > .3){
//                [self.interactionController finishInteractiveTransition];
//            } else {
//                [self.interactionController cancelInteractiveTransition];
//            }
//        }else{ // pop
//            
//            if([recognizer velocityInView:view].x > 0 && self.interactionController.percentComplete > .3){
//                [self.interactionController finishInteractiveTransition];
//            } else {
//                [self.interactionController cancelInteractiveTransition];
//            }
//        }
        
        self.interactionController = nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}
@end
