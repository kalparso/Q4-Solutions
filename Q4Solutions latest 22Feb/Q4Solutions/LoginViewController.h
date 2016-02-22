//
//  LoginViewController.h
//  Q4Solutions
//
//  Created by promatics on 11/26/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *email_txt;
@property (strong, nonatomic) IBOutlet UITextField *password_txt;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll_view;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIView *subView;




- (IBAction)loginbutton:(id)sender;

@end
