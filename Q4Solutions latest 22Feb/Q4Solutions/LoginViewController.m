//
//  LoginViewController.m
//  Q4Solutions
//
//  Created by promatics on 11/26/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "LoginViewController.h"
#import "WebServiceConnection.h"
#import "Indicator.h"
#import "Validation.h"
#import "LoginViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController
{
    
    
    WebServiceConnection *loginConnection,*connection_account_valid;
    Indicator *indicator;
    id activetextField;
    NSString *check_status;
    NSArray *userData;
    Validation *validation;
}
@synthesize email_txt,password_txt,scroll_view,subView,loginButton;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    loginConnection = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    validation =[Validation validationManager];
    
    CGRect frame=subView.frame;
    
    frame.origin.x=self.view.frame.size.width/2-subView.frame.size.width/2;
    
    subView.frame = frame;
    
    [[UITextField appearance]setTextColor:[UIColor blackColor]];
    
    [[UITextField appearance]setTintColor:[UIColor redColor]];
  
//   
//    [self registerForKeyboardNotifications];
//    
//    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
//    
//    tapScroll.cancelsTouchesInView = NO;
//    
//    [scroll_view addGestureRecognizer:tapScroll];
    
    [self prepareInterface];
    
 }


-(void)viewWillAppear:(BOOL)animated{

        [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
        
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)prepareInterface {
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main.ipad" bundle:nil];
        
        scroll_view.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.origin.y +60);
        
        CGFloat hieght = 45.0f;
        
        CGRect frame = email_txt.frame;
        
        frame.size.height = hieght;
        
        email_txt.frame = frame;
        
        frame = password_txt.frame;
        
        frame.size.height = hieght;
        
        password_txt.frame = frame;
        
    } else {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main.iphone" bundle:nil];
        
        scroll_view.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.origin.y +50);
    }
    
    loginButton.layer.cornerRadius = 5.0f;
    

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



- (IBAction)loginbutton:(id)sender {
    
    NSString *message;
    
  
    if ([email_txt.text isEqualToString:@""]) {
        
        message =@"Please enter email id";
    }

//    else if ([password_txt.text isEqualToString:@""]) {
//        
//        message=@"Please enter password";
//    }

    if ([message length]>0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }  else {
        
       NSString *email = email_txt.text;
        
        NSString *password = password_txt.text;
        
       // NSString *login;
        NSDictionary *urlparam = @{
                                   @"email":email,
                                   @"password":password,
                                   @"login":@"login"
                                   };
        
        NSLog(@"%@",urlparam);
        
        [self.view addSubview:indicator];
        
        [loginConnection startConnectionWithString:[NSString stringWithFormat:@"signin"] HttpMethodType:Post_Type HttpBodyType:urlparam Output:^(NSDictionary *receivedData)
         {
            [indicator removeFromSuperview];
             
             NSLog(@"%@",receivedData);
             
             if([loginConnection responseCode]==1) {
                 
                 NSString *msg = [receivedData valueForKey:@"msg"];
                 
                 NSDictionary *data=[receivedData valueForKey:@"member_data"];
                 
                 userData=[receivedData valueForKey:@"member_data"];
                 
                 if([data count]>1) {
                     
                     email_txt.text = @"";
                     
                    password_txt.text = @"";
                     
                    check_status=[data valueForKey:@"status"];
                     
                    if ([check_status isEqualToString:@"Y"]) {
                         
                          [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"login"];
                        
                         [[NSUserDefaults standardUserDefaults] setValue:userData forKey:@"user_Info"];
                         
                         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Q4 Solutions" message:@"Login Successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         
                         [alert show];
                         
                        [self performSegueWithIdentifier:@"Login_identifier" sender:self];
                     }
                     
                    } else {
                     
         //    msg =[[receivedData valueForKey:@"Message"] valueForKey:@"errMsg"];
                     
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     
                     [alert show];
                 }
             }
         }];
    }
    
    }
    
#pragma mark-Textfield Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    activetextField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    activetextField = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == email_txt) {
        
        [password_txt becomeFirstResponder];
        
    } else if (textField == password_txt) {
        
        [textField resignFirstResponder];
        
        [self loginbutton:self];
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}

#pragma mark-registerForKeyboardNotifications

//- (void)registerForKeyboardNotifications
//{
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//     selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
//    
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
//    
//}
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
//    [scroll_view setContentSize:CGSizeMake(self.view.frame.size.width, 568)];
//    
//    scroll_view.contentInset = contentInsets;
//    
//    CGRect aRect = self.view.frame;
//    
//    aRect.size.height -= kbHeight;
//    
//    
//}
//
//// Called when the UIKeyboardWillHideNotification is sent
//
//- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    
//    scroll_view.contentInset = contentInsets;
//    
//    scroll_view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);
//    
//    scroll_view.scrollIndicatorInsets = contentInsets;
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

@end
