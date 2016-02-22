//
//  ContectUsViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/1/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *subView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *supportEmail_text;
@property (weak, nonatomic) IBOutlet UITextField *subject_text;
@property (weak, nonatomic) IBOutlet UITextField *query_text;
@property (weak, nonatomic) IBOutlet UIButton *submit_button;
- (IBAction)submitButton:(id)sender;

@end
