//
//  DWThirdViewController.m
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 27/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "DWThirdViewController.h"

@interface DWThirdViewController ()

@end

@implementation DWThirdViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *secondBtn = [UIButton  buttonWithType:UIButtonTypeContactAdd];
    [secondBtn addTarget:self  action:@selector(secondBtnPressed)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];
    
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
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.title = @"Third";
}

-(void) secondBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
