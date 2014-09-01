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
        
        // NSUserDefaultsDidChangeNotification
        [[NSNotificationCenter defaultCenter] addObserverForName: NSUserDefaultsDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            BOOL showNavBars = [[NSUserDefaults standardUserDefaults] boolForKey:@"show_nav_bars"];
            [self.navigationController setNavigationBarHidden:!showNavBars animated:YES];
        }];
        
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
    
    
    // Began.
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        BOOL panMovingRight = [recognizer velocityInView:view].x > 0;
        BOOL panMovingLeft = [recognizer velocityInView:view].x < 0;
        
        CGPoint location = [recognizer locationInView:view];
        BOOL panBeganInLeftSide = location.x <= CGRectGetMidX(view.bounds);
        BOOL panBeganInRightSide = !panBeganInLeftSide;
        
        
        // Pops.
        if (panBeganInLeftSide && panMovingRight) { // left half
            
            // Pop to previous VC.
            if([self.navigationController.topViewController isKindOfClass:[DWSecondViewController class]]
               || [self.navigationController.topViewController isKindOfClass:[DWThirdViewController class]]){
                
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    
        // Pushes.
        if (panBeganInRightSide && panMovingLeft) { // right half
            
            // Push Second VC.
            if([self.navigationController.topViewController isKindOfClass:[DWFirstViewController class]]){
                
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController pushViewController: [[DWSecondViewController alloc] init] animated:YES];
            
            // Push Third VC.
            }else if([self.navigationController.topViewController isKindOfClass:[DWSecondViewController class]]){
                
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController pushViewController: [[DWThirdViewController alloc] init] animated:YES];
            }
        }
    
        
    // Changed.
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
        
    
    // Ended.
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if(self.interactionController.percentComplete > .3){
            [self.interactionController finishInteractiveTransition];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        
        self.interactionController = nil;
        
        
    // Cancelled.
        
    } else if (recognizer.state == UIGestureRecognizerStateCancelled) {
        
     
    // Other states.
        
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

            default:
                break;
        }
        
        // WTFF
        if(recognizer.state == UIGestureRecognizerStateRecognized){
            recognizerState = @"UIGestureRecognizerStateRecognized";
        }
        if(recognizer.state == UIGestureRecognizerStateEnded){
            recognizerState = @"UIGestureRecognizerStateEnded";
        }
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}
@end
