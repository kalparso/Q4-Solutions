//
//  UserProfileViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/1/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstName_text;
@property (weak, nonatomic) IBOutlet UITextField *lastName_text;
@property (weak, nonatomic) IBOutlet UITextField *mobile_text;

@property (weak, nonatomic) IBOutlet UITextField *email_text;
@property (weak, nonatomic) IBOutlet UITextField *address_text;
@property (weak, nonatomic) IBOutlet UITextField *aboutMe_text;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)updateProfile:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
