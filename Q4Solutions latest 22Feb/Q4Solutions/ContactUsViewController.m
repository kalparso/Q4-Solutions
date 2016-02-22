//
//  ContectUsViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/1/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "ContactUsViewController.h"
#import "WebServiceConnection.h"
#import "Indicator.h"
#import "Validation.h"


@interface ContactUsViewController ()
{
    WebServiceConnection *contactUsCon;
    Indicator *indicator;
    NSString *check_status;
    id activetextField;
    Validation *validation;
}
@end

@implementation ContactUsViewController
@synthesize query_text,scrollView,subject_text,submit_button,supportEmail_text,subView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = subView.frame;
    
    frame.size.width = self.view.frame.size.width;
    
    subView.frame = frame;
    
    frame = subView.frame;
    
    frame.origin.x = (self.view.frame.size.width-subView.frame.size.width)/2;
    
    subView.frame =frame;
    
    contactUsCon = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    validation =[Validation validationManager];
    
    [[UITextField appearance]setTextColor:[UIColor blackColor]];
    
    [[UITextField appearance] setTintColor:[UIColor redColor]];
    
    [self prepareInterface];

    
    
//    [self registerForKeyboardNotifications];
//    
//    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
//    
//    tapScroll.cancelsTouchesInView = NO;
//    
//    [scrollView addGestureRecognizer:tapScroll];
//    
    
    
    // Do any additional setup after loading the view.
}

-(void)prepareInterface {
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main.ipad" bundle:nil];
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.origin.y +60);
        
        CGFloat hieght = 45.0f;
        
        CGRect frame = supportEmail_text.frame;
        
        frame.size.height = hieght;
        
       supportEmail_text.frame = frame;
        
        frame = subject_text.frame;
        
        frame.size.height = hieght;
        
        subject_text.frame = frame;
        
        frame = query_text.frame;
        
        frame.size.height = hieght;
        
        query_text.frame = frame;
        
    } else {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main.iphone" bundle:nil];
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.origin.y +50);
    }
    
    submit_button.layer.cornerRadius = 5.0f;
  
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

- (IBAction)submitButton:(id)sender {
   
    NSString *message;
    
    NSUserDefaults   *userData = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_Info"];
    
     NSString *email   = [userData valueForKey:@"email"];
    
    //if ([supportEmail_text.text isEqualToString:@""]) {
        
      //  message =@"Please enter email id";
        
        
    
     if ([subject_text.text isEqualToString:@""]) {
        
        message=@"Please enter subject";
        
    }else if ([query_text.text isEqualToString:@""]) {
        
        message=@"Please enter query";
    }
    
    
    if ([message length]>0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ContactUs" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }  else {
        
       // NSString *email = supportEmail_text.text;
        
        NSString *subject = subject_text.text;
        
        NSString *query = query_text.text;

        NSDictionary *urlparam = @{
                                   @"email":email,
                                   @"subject":subject,
                                   @"query":query,
                                   @"send":@"Contact"
                                   };
        
        NSLog(@"%@",urlparam);
        
        [self.view addSubview:indicator];
        
        [contactUsCon startConnectionWithString:[NSString stringWithFormat:@"contact_us"] HttpMethodType:Post_Type HttpBodyType:urlparam Output:^(NSDictionary *receivedData)
         {
             [indicator removeFromSuperview];
             
             NSLog(@"%@",receivedData);
             
             if([contactUsCon responseCode]==1) {
                 
                 NSString *msg = [receivedData valueForKey:@"msg"];
                 
                 if([receivedData count]>1) {
                     
                     supportEmail_text.text = @"";
                     
                     subject_text.text = @"";
                     
                     query_text.text = @"";
                     
                     if ([msg isEqualToString:@"success"]) {
                         
                         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ContactUs" message:@"Sent Successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         
                         [alert show];
                         
                     }else{
                         
                         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ContactUs" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         
                         [alert show];
                     }
                    
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
    
    if (textField == supportEmail_text) {
        
        [subject_text becomeFirstResponder];
        
    }else if (textField == subject_text) {
        
        [query_text becomeFirstResponder];
        
        } else if (textField == query_text) {
        
        [textField resignFirstResponder];
        
        [self submitButton:self];
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}
- (IBAction)tapWebsite:(id)sender {
    
    
    if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://q4solutions.com"]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://q4solutions.com"]];
        
    } else
    {
        
        UIAlertView    *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Url can not be open!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
        
    }
}
- (IBAction)tapContact:(id)sender {
    
    NSString *phNo = @"(314) 725 7771";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"tel:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        
        [[UIApplication sharedApplication] openURL:phoneUrl];
        
    } else
    {
        UIAlertView    *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }

}


@end





