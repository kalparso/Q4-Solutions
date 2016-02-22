//
//  ForgotPasswordViewController.m
//  Q4Solutions
//
//  Created by promatics on 11/26/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "WebServiceConnection.h"
#import "Indicator.h"
#import "Validation.h"

@interface ForgotPasswordViewController ()
{
     WebServiceConnection *forgotConnection;
     Indicator *indicator;
     id activetextField;
     Validation *validation;
}

@end

@implementation ForgotPasswordViewController
@synthesize  subView,scrollView,email_txt,submitButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame=subView.frame;
    
    frame.origin.x=self.view.frame.size.width/2-subView.frame.size.width/2;
    
    subView.frame = frame;
    
    forgotConnection = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    validation = [Validation validationManager];
    
     [[UITextField appearance]setTextColor:[UIColor blackColor]];
    
     [[UITextField appearance]setTintColor:[UIColor redColor]];
    
     [self prepareInterface];

    
//     [self registerForKeyboardNotifications];
//    
//    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
//    
//    tapScroll.cancelsTouchesInView = NO;
//    
//    [scrollView addGestureRecognizer:tapScroll];
    
    // Do any additional setup after loading the view.
}
-(void)prepareInterface {
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main.ipad" bundle:nil];
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.origin.y +60);
        
        CGFloat hieght = 45.0f;
        
        CGRect frame = email_txt.frame;
        
        frame.size.height = hieght;
        
        email_txt.frame = frame;
        
    } else {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main.iphone" bundle:nil];
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.origin.y +50);
    }
    
    submitButton.layer.cornerRadius = 5.0f;
    
    
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

- (IBAction)sumitButton:(id)sender {
    
    NSString *message;
    
    if ([email_txt.text isEqualToString:@""]) {
        
        message =@"Please enter email id";
        
      }
//else if ([validation validateEmail:email_txt.text])
//    {
//       message =@"Please enter valid email id";
//    }
    
    if ([message length]>0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Forgot password" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else{
        
        NSString *email = email_txt.text;
        
        
        NSDictionary *urlparam = @{
                                   @"email":email,
                                   @"submit":@"forgot"
                                   };
        
        NSLog(@"%@",urlparam);
        
         [self.view addSubview:indicator];
        
        [forgotConnection startConnectionWithString:[NSString stringWithFormat:@"forgotPassword"] HttpMethodType:Post_Type HttpBodyType:urlparam Output:^(NSDictionary *receivedData)
         {
             
            [indicator removeFromSuperview];
             
           // NSString *msg;
             
             NSLog(@"%@",receivedData);
             
        if([forgotConnection responseCode]==1) {
                 
            NSString *msg = [receivedData valueForKey:@"msg"];
            
                 
                 if([msg isEqual:@"Please check your mail for your password"]) {
                     
                    email_txt.text = @"";
                     
                  //msg= @"Link has been sent to your email-id";
                     
                  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"forgot" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     
                      [alert show];
                     
                     }else{
                     
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"forgot" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     
                     [alert show];
                     
                 }
             }
         }];
    }
}

#pragma TextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    activetextField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
   
    activetextField = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}

//- (void)registerForKeyboardNotifications
//{
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
//    
//}
//
//
//- (void)keyboardWasShown:(NSNotification*)aNotification {
//    
//    NSDictionary* info = [aNotification userInfo];
//    
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    float kbHeight = 0.0;
//    
//    if (kbSize.width > kbSize.height) {
//        
//        kbHeight = kbSize.height;
//        
//    } else {
//        
//        kbHeight = kbSize.width;
//    }
//    
//    NSLog(@"%f", self.view.frame.origin.x);
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeight-self.view.frame.origin.x, 0.0);
//    
//    //  [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
//    
//    scrollView.contentInset = contentInsets;
//    
//    CGRect aRect = self.view.frame;
//    
//    aRect.size.height -= kbHeight;
//    
//    UIView *activeView = activetextField;
//    
//    if (!CGRectContainsPoint(aRect, activeView.frame.origin) ) {
//        
//        [scrollView scrollRectToVisible: activeView.frame  animated:YES];
//        
//    }
//}
//
//// Called when the UIKeyboardWillHideNotification is sent
//
//- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    
//    scrollView.contentInset = contentInsets;
//    
//    scrollView.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);
//    
//
// scroll_view.scrollIndicatorInsets = contentInsets;
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//    [super touchesBegan:touches withEvent:event];
//}
//
//- (void)hideKeyboard {
//    
//    [self.view endEditing:YES];
//}
//

@end
