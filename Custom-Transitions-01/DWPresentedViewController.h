//
//  DWPresentedViewController.h
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 26/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWSecondViewController.h"

@interface DWPresentedViewController : UIViewController

@property id<PresentingVC>delegate;

@end