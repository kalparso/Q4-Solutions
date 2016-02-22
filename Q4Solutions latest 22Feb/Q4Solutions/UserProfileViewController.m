//
//  UserProfileViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/1/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "UserProfileViewController.h"
#import "WebServiceConnection.h"
#import "Indicator.h"
#import "Validation.h"


@interface UserProfileViewController ()
{
    id activetextField;
    WebServiceConnection *ProfileCon;
    Indicator *indicator;
    NSString *check_status;
    NSMutableDictionary *userData;
    Validation *validation;
    NSArray *arr;
}

@end

@implementation UserProfileViewController
@synthesize firstName_text,lastName_text,email_text,mobile_text,aboutMe_text,address_text,scrollView,submitButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ProfileCon = [WebServiceConnection connectionManager];
    
    validation =[Validation validationManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];

    [[UITextField appearance]setTextColor:[UIColor blackColor]];
    
    [[UITextField appearance] setTintColor:[UIColor redColor]];
    
    [self prepareInterface];
    
    [self loadData];
    
//    [self registerForKeyboardNotifications];
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
        
        CGRect frame = firstName_text.frame;
        
        frame.size.height = hieght;
        
        firstName_text.frame = frame;
        
        frame = lastName_text.frame;
        
        frame.size.height = hieght;
        
        lastName_text.frame = frame;
        
        frame = mobile_text.frame;
        
        frame.size.height = hieght;
        
        mobile_text.frame = frame;
        
        frame = email_text.frame;
        
        frame.size.height = hieght;
        
        email_text.frame = frame;
        
        frame = address_text.frame;
        
        frame.size.height = hieght;
        
        address_text.frame = frame;
        
        frame = aboutMe_text.frame;
        
        frame.size.height = hieght;
        
        aboutMe_text.frame = frame;
        
    } else {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main.iphone" bundle:nil];
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.origin.y +50);
    }
    
    submitButton.layer.cornerRadius = 5.0f;
    
}

-(void)loadData{
    
    userData = [[NSMutableDictionary alloc]init];
    
    userData = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_Info"];
    
    firstName_text.text = [userData valueForKey:@"firstname"];
  
    lastName_text.text = [userData valueForKey:@"lastname"];
    
    email_text.text = [userData valueForKey:@"email"];
    
    mobile_text.text = [userData valueForKey:@"phone"];
    
    address_text.text = [userData valueForKey:@"address"];
    
    aboutMe_text.text = [userData valueForKey:@"about_me"];

}


-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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

- (IBAction)updateProfile:(id)sender {
    
    NSString *message;
    
    if ([firstName_text.text isEqualToString:@""]) {
        
        message =@"Please enter first name";
        
    }else if (![validation validateEmail:email_text.text]){
            
            message = @"Please enter valid email id";
        
    } else if ([lastName_text.text isEqualToString:@""]) {
        
        message=@"Please enter last name";
        
    }else if ([mobile_text.text isEqualToString:@""]) {
        
        message=@"Please enter mobile number.";
        
    }else if ([address_text.text isEqualToString:@""]) {
    
    message=@"Please enter address";
        
    }else if ([email_text.text isEqualToString:@""]) {
        
        message=@"Please enter email id";
        
    }else if ([aboutMe_text.text isEqualToString:@""]) {
        
        message=@"Please enter about me";
    }



    if ([message length]>0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Uesr Profile" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }  else {
        
        NSString *firstName = firstName_text.text;
        
        NSString *lastName = lastName_text.text;
        
        NSString *mobile = mobile_text.text;
        
        NSString *email = email_text.text;
        
        NSString *address = address_text.text;
        
        NSString *about = aboutMe_text.text;
        
        NSString *userId=[userData valueForKey:@"id"];
        

        NSDictionary *urlparam = @{@"userId":userId,@"email":email,@"firstname":firstName,@"lastname":lastName,
            @"phone":mobile,@"address":address,@"about_me":about,@"submit":@"update",};
        
        [self.view addSubview:indicator];
        
        [ProfileCon startConnectionWithString:[NSString stringWithFormat:@"edit_user_profile"] HttpMethodType:Post_Type HttpBodyType:urlparam Output:^(NSDictionary *receivedData)
         {
             [indicator removeFromSuperview];
             
             NSLog(@"%@",receivedData);
             
             if([ProfileCon responseCode]==1) {
                 
                 NSString *msg = [receivedData valueForKey:@"msg"];
                 
              if([receivedData count]>1) {
                     
                 if ([msg isEqualToString:@"success"]) {
                         
                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"User Profile" message:@"Update Successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         
                   [alert show];
                     
                     NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_Info"]);
                     
                     arr = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_Info"];
                     
                    userData = [[NSMutableDictionary alloc]init];
                     
                   [userData setValue:firstName forKey:@"firstname"];
                     
                   [userData setValue:lastName forKey:@"lastname"];
                         
                   [userData setValue:about forKey:@"about_me"];
                         
                   [userData setValue:email forKey:@"email"];
                     
                   [userData setValue:mobile forKey:@"phone"];
                         
                   [userData setValue:address forKey:@"address"];
                     
                   [userData setValue:[arr valueForKey:@"id"] forKey:@"id"];
                     
                   [userData setValue:[arr valueForKey:@"accessibility_type"] forKey:@"accessibility_type"];
                     
                   [userData setValue:[arr valueForKey:@"status"] forKey:@"status"];
                    
                     
                     
                     
                         
                   [[NSUserDefaults standardUserDefaults] setValue:userData forKey:@"user_Info"];
                         
                }else{
                         
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"User profile" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         
                 [alert show];
                  }
                     
                 }
             }
             
         }];
    }
    
}


#pragma mark-Textfield Delegate


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
//    //scroll_view.scrollIndicatorInsets = contentInsets;
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
