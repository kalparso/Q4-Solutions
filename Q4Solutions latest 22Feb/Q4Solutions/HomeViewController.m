//
//  HomeViewController.m
//  Q4Solutions
//
//  Created by promatics on 11/26/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "HomeViewController.h"
#import "WebServiceConnection.h"
#import "Google/Analytics.h"
#import "LoginViewController.h"


@interface HomeViewController ()
{
    NSString *accessibility_type;
    WebServiceConnection *homeConn;
    NSArray *userData,*homeArray;

}
@end

@implementation HomeViewController
@synthesize Q1Button,Q2Button,Q3Button,Q4Button,scroll_View;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //UIViewController *newViewController = [[UIViewController alloc]init];
    
   // [self presentViewController:newViewController animated:YES completion:nil];
    
   // newViewController.view.backgroundColor = [UIColor whiteColor];
    
    
    
    homeConn = [WebServiceConnection connectionManager];
   
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    userData =[[NSUserDefaults standardUserDefaults]valueForKey:@"user_Info"];
    
    accessibility_type =[userData valueForKey:@"accessibility_type"]
    ;
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    
    
    // [self fetchData];
    
    
    
//    UITabBarItem *barItem1 = [[self.tabBarController.tabBar items] objectAtIndex:0];
//  
//    barItem1.image = [[UIImage imageNamed:@"home_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UITabBarItem *barItem2 = [[self.tabBarController.tabBar items] objectAtIndex:1];
//    
//    barItem2.image = [[UIImage imageNamed:@"search_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UITabBarItem *barItem3 = [[self.tabBarController.tabBar items] objectAtIndex:2];
//    
//    barItem3.image = [[UIImage imageNamed:@"profile_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UITabBarItem *barItem4 = [[self.tabBarController.tabBar items] objectAtIndex:3];
//    
//    barItem4.image = [[UIImage imageNamed:@"more_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
      self.tabBarItem.selectedImage = [UIImage imageNamed:@"search_icon_white"];
    
      [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
      [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
        
      self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
      [self checkLogin];
    
       //scroll_View.hidden = NO;
    
    userData =[[NSUserDefaults standardUserDefaults]valueForKey:@"user_Info"];
    
    
    if (userData != nil) {
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    
    NSString *fname = [userData valueForKey:@"firstname"];
    
    NSString *lname = [userData valueForKey:@"lastname"];
    
    lname = [@" " stringByAppendingString:lname];
    
    NSString *name = [fname stringByAppendingString:lname];
    
    [tracker set:kGAIScreenName value:name];
    
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        
    
    // Start a new session with a screenView hit.
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
    [builder set:@"start" forKey:kGAISessionControl];
    [tracker set:kGAIScreenName value:@"My Screen"];
    [tracker send:[builder build]];
    // There should be no need to end a session explicitly.  However, if you do
    // need to indicate end of session with a hit, simply add the following line
    // of code to add the parameter to the builder:
    [builder set:@"end" forKey:kGAISessionControl];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Home Screen"];
    
    // Previous V3 SDK versions
    // [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    // New SDK versions
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    }
    
}

-(void)fetchData{
    
    NSDictionary *paramUrl = @{@"working_4":@"q1",@"type":@"Q1"};
    
    [homeConn startConnectionWithString:@"working_with_q1" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *recievedData){
        
        if ([homeConn responseCode]==1) {
            
           // NSLog(@"%@",recievedData);
            
           //[[NSUserDefaults standardUserDefaults] setObject:homeArray forKey:@"Home_info"];
            
            NSString *msg = [recievedData valueForKey:@"msg"];
            
        if([msg isEqual:@"success"]) {
            
            homeArray = [recievedData valueForKey:@"data"];
                
            [[NSUserDefaults standardUserDefaults] setObject:homeArray forKey:@"Home_info"];
            
        }else{
                
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Home" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            
        }
    }];
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

-(void)checkLogin {
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"login"] isEqualToString:@"1"]) {
   
    } else {
        
         //LoginViewController *vc2 = [[LoginViewController alloc] initWithNibName:@"loginpage" bundle:nil];

      // LoginViewController *navLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"loginpage"];
        
       //[self.navigationController pushViewController:vc2 animated:YES];
    
        
       // [[self navigationController] pushViewController:vc2 animated:YES];
        
       [self performSegueWithIdentifier:@"loginHomeSegue" sender:self];
        
    }
}


@end
