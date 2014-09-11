//
//  DWViewController.m
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 11/09/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "DWXXViewController.h"

@interface DWXXViewController ()

//@property BOOL constraintsAdded;

//@property (strong, nonatomic) UIView *backgroundView;

@end

@implementation DWXXViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.constraintsAdded = NO;
    
//        self.constraintsAdded = YES;

    
    self.view.layer.borderWidth = 2.0f;
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectZero];
    self.backgroundView.layer.borderWidth = 2.0f;
    [self.view addSubview: self.backgroundView];
    
    // Positioning Constraints
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = @{@"backgroundView":self.backgroundView};

    // Stretch horizontally - temporary insets.
    NSArray *colorViewHorizontalConstraints
    = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20@999)-[backgroundView]-(20@999)-|"
                                              options:0
                                              metrics:nil
                                                views:bindings];
    [self.view addConstraints:colorViewHorizontalConstraints];

    // Stretch vertically - temporary insets.
    NSArray *colorViewVerticalConstraints
    = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[backgroundView]-|"
                                              options:0
                                              metrics:nil
                                                views:bindings];
    [self.view addConstraints:colorViewVerticalConstraints];
    
    NSLog(@"%@ viewDidLoad - backgroundView.frame = %@",[self class], NSStringFromCGRect(self.backgroundView.frame));
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)updateViewConstraints
//{
//    
//    if(!self.constraintsAdded){
//        
//        self.constraintsAdded = YES;
//        
//        // Positioning Constraints
//        self.view.translatesAutoresizingMaskIntoConstraints = NO;
//        
//        NSDictionary *bindings = @{@"view":self.view};
//        
//        // Stretch horizontally - temporary insets.
//        NSArray *fromViewHorizontalConstraints
//        = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|"
//                                                  options:0
//                                                  metrics:nil
//                                                    views:bindings];
//        [self.view.superview addConstraints:fromViewHorizontalConstraints];
//        
//        // Stretch vertically - temporary insets.
//        NSArray *fromViewVerticalConstraints
//        = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]-|"
//                                                  options:0
//                                                  metrics:nil
//                                                    views:bindings];
//        [self.view.superview addConstraints:fromViewVerticalConstraints];
//    }
//    
//    [super updateViewConstraints];
//}

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
