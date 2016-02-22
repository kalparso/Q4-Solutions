//
//  WelcomeViewController.h
//  Q4Solutions
//
//  Created by promatics on 1/27/16.
//  Copyright © 2016 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *welcome_lbl;

@end
