//
//  DWSecondViewController.h
//  Custom-Transitions-01
//
//  Created by Daniel Wallace [DATACOM] on 21/08/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PresentingVC <NSObject>

-(void) dismissPresentedVC:(UIViewController *) presentedVC;

@end

@interface DWSecondViewController : UIViewController<PresentingVC>

@end
