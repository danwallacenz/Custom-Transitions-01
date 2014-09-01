//
//  DWSecondViewController.m
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 21/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "DWSecondViewController.h"
#import "DWThirdViewController.h"

@interface DWSecondViewController ()

@end

@implementation DWSecondViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *firstBtn = [UIButton  buttonWithType:UIButtonTypeContactAdd];
    [firstBtn addTarget:self  action:@selector(firstButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
    
    [firstBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Center button in view.
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:firstBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:firstBtn
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    
    
    UIButton *thirdBtn = [UIButton  buttonWithType:UIButtonTypeContactAdd];
    [thirdBtn addTarget:self  action:@selector(thirdButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdBtn];
    
    [thirdBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Center button in view.
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:thirdBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:thirdBtn
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:40]];

    
    self.view.backgroundColor = [UIColor redColor];
    
    self.title = @"Second";
}

-(void) firstButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) thirdButtonPressed
{
    DWThirdViewController *dwThirdViewController = [[DWThirdViewController alloc] init];
    [self.navigationController pushViewController:dwThirdViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
