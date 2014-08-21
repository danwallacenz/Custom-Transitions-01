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

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [secondBtn addTarget:self  action:@selector(secondButtonPressed) forControlEvents:UIControlEventTouchUpInside];
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
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.title = @"First";
    
//    DWNavigationControllerDelegate *dwNavigationControllerDelegate = [[DWNavigationControllerDelegate alloc] init];//]WithNavigationController:self.navigationController];
//    
//    self.navigationController.delegate = dwNavigationControllerDelegate;
}


-(void) secondButtonPressed
{
    NSLog(@"secondButtonPressed");
    UIViewController *second = [[DWSecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
