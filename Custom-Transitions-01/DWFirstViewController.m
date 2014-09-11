//
//  DWFirstViewController.m
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 21/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "DWFirstViewController.h"
#import "DWSecondViewController.h"
#import "DWNavigationControllerDelegate.h"

@interface DWFirstViewController ()

@end

@implementation DWFirstViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    // Positioning Constraints
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    NSDictionary *bindings = @{@"view":self.view};
//    
//    // Stretch horizontally - temporary insets.
//    NSArray *fromViewHorizontalConstraints
//    = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|"
//                                              options:0
//                                              metrics:nil
//                                                views:bindings];
//    [self.view.superview addConstraints:fromViewHorizontalConstraints];
//    
//    // Stretch vertically - temporary insets.
//    NSArray *fromViewVerticalConstraints
//    = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]-|"
//                                              options:0
//                                              metrics:nil
//                                                views:bindings];
//    [self.view.superview addConstraints:fromViewVerticalConstraints];
    
    
    // Add a button.
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [secondBtn addTarget:self  action:@selector(secondButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:secondBtn];

    [secondBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Center button in view.
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:secondBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:secondBtn
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                          multiplier:1
                                                           constant:0]];
    self.backgroundView.backgroundColor = [UIColor orangeColor];
//    self.view.backgroundColor = [UIColor blueColor]; //[self.backgroundView.backgroundColor colorWithAlphaComponent:0.6];


//    [self.colorView setBackgroundColor: [[UIColor lightGrayColor] colorWithAlphaComponent:0.2]];

    
    self.title = @"First";
    
    // Initially show the second VC.
    UIViewController *second = [[DWSecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:NO];
}


-(void) secondButtonPressed
{
    UIViewController *second = [[DWSecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
