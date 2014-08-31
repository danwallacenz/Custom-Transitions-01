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
@property (strong, nonatomic) UIPanGestureRecognizer* panRecognizer;

@end


@implementation DWNavigationControllerDelegate


-(instancetype) initWithNavigationController: (UINavigationController *)navigationController
{
    self = [super init];
    if (self) {
        
        self.navigationController = navigationController;
        
        self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self.navigationController.view addGestureRecognizer:self.panRecognizer];
        
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
//    NSLog(@"Entering pan: The top view controller is %@", [self.navigationController.topViewController class]);
//    UIView *view = recognizer.view;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
//        NSLog(@"\n");
//        NSLog(@"UIGestureRecognizerStateBegan");
//        NSLog(@"self.navigationController.viewControllers.count = %d", self.navigationController.viewControllers.count);
//        NSLog(@"topViewController = %@",[self.navigationController.topViewController class]);
        
        BOOL panMovingRight = [recognizer velocityInView:view].x > 0;
        BOOL panMovingLeft = [recognizer velocityInView:view].x < 0;
//        NSLog(@"Moving %@", panMovingRight?@"right":@"left");
        
        
        CGPoint location = [recognizer locationInView:view];
        BOOL panBeganInLeftSide = location.x <= CGRectGetMidX(view.bounds);
        BOOL panBeganInRightSide = !panBeganInLeftSide;
        
        if (panBeganInLeftSide && panMovingRight) { // left half
            if([self.navigationController.topViewController isKindOfClass:[DWSecondViewController class]]
               || [self.navigationController.topViewController isKindOfClass:[DWThirdViewController class]]){
                
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    
        if (panBeganInRightSide && panMovingLeft) { // right half
            if([self.navigationController.topViewController isKindOfClass:[DWFirstViewController class]]){
                
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController pushViewController: [[DWSecondViewController alloc] init] animated:YES];
            }else if([self.navigationController.topViewController isKindOfClass:[DWSecondViewController class]]){
                
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController pushViewController: [[DWThirdViewController alloc] init] animated:YES];
            }
        }
    
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {

//        NSLog(@"Moving %@",[recognizer velocityInView:view].x > 0?@"right": @"left");
        
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        
//        NSLog(@"UIGestureRecognizerStateEnded");
//        NSLog(@"self.navigationController.viewControllers.count = %d", self.navigationController.viewControllers.count);
//        NSLog(@"Pan ended moving %@",[recognizer velocityInView:view].x > 0?@"right == pop": @"left == push");
//        NSLog(@"topViewController = %@",[self.navigationController.topViewController class]);
//        
//        NSLog(@"percent complete %f%%", self.interactionController.percentComplete);
//        NSLog(@"\n");
        
//        BOOL panEndedMovingRight = [recognizer velocityInView:view].x > 0;
//        BOOL panEndedMovingLeft = [recognizer velocityInView:view].x < 0;
        

        if(self.interactionController.percentComplete > .3){
            [self.interactionController finishInteractiveTransition];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
//            BOOL isIgnoringInteractionEvents = [[UIApplication sharedApplication] isIgnoringInteractionEvents];
//            NSLog(@"FINISH INTERACTIVE TRANSITION Ignoring user interaction %@", isIgnoringInteractionEvents?@"yes":@"no");
        } else {
            [self.interactionController cancelInteractiveTransition];
//                NSLog(@"CANCEL INTERACTIVE TRANSITION");
        }
        
        self.interactionController = nil;
        
        // Let the animation complete uninterrupted.
        
        
        
    } else if (recognizer.state == UIGestureRecognizerStateCancelled) {
        
//        NSLog(@"UIGestureRecognizerStateCancelled");
    
    }else{
        NSString *recognizerState = @"UNKNOWN";
        
        switch (recognizer.state) {
            case UIGestureRecognizerStatePossible:
                recognizerState = @"UIGestureRecognizerStatePossible";
                break;
            case UIGestureRecognizerStateBegan:
                recognizerState = @"UIGestureRecognizerStateBegan";
                break;
            case UIGestureRecognizerStateChanged:
                recognizerState = @"UIGestureRecognizerStateChanged";
                break;
            case UIGestureRecognizerStateEnded:
                recognizerState = @"UIGestureRecognizerStateEnded";
                break;
            case UIGestureRecognizerStateCancelled:
                recognizerState = @"UIGestureRecognizerStateCancelled";
                break;
            case UIGestureRecognizerStateFailed:
                recognizerState = @"UIGestureRecognizerStateFailed";
                break;
                
                // WTFF
//            case UIGestureRecognizerStateRecognized || UIGestureRecognizerStateEnded :
//                recognizerState = @"UIGestureRecognizerStateRecognized";
//                break;
//            case UIGestureRecognizerStateEnded:
//                recognizerState = @"UIGestureRecognizerStateEnded";
//                break;
                
            default:
                break;
        }
        
        if(recognizer.state == UIGestureRecognizerStateRecognized){
            recognizerState = @"UIGestureRecognizerStateRecognized";
        }
        if(recognizer.state == UIGestureRecognizerStateEnded){
            recognizerState = @"UIGestureRecognizerStateEnded";
        }

        
//        NSLog(@"%@",recognizerState);
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}
@end
