//
//  WelcomeViewController.m
//  Q4Solutions
//
//  Created by promatics on 1/27/16.
//  Copyright © 2016 promatics. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()
{
    WelcomeViewController *welcomeviewcontroller;
    UIView *newview;
}

@end

@implementation WelcomeViewController
@synthesize  welcome_lbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = welcome_lbl.frame;
    
    frame.origin.x = (self.view.frame.size.width-welcome_lbl.frame.size.width)/2;
    
    welcome_lbl.frame = frame;
    
    frame = welcome_lbl.frame;
    
    frame.origin.y = (self.view.frame.size.height-welcome_lbl.frame.size.height)/2;
    
    welcome_lbl.frame = frame;

    
     newview = [[UIView alloc] initWithFrame:self.view.frame];
    
     
    
     //welcome_lbl.lineBreakMode = YES;
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedScreenright:)];
    
   swipeGesture.delegate = self;
    
   swipeGesture.numberOfTouchesRequired = 1;
    
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeGesture];
    
    self.view.userInteractionEnabled = YES;
    
     
}

- (void)swipedScreenright:(UISwipeGestureRecognizer*) swipeGesture {
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"login"] isEqualToString:@"1"]) {
        
        [self performSegueWithIdentifier:@"tabBar" sender:self];
        
    } else {
        
        [self performSegueWithIdentifier:@"loginHomeSegue" sender:self];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)textTapped:(UITapGestureRecognizer *)recognizer
{
    
   // NSLog(@"hello");
    
}

@end
