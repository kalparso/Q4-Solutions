//
//  PrivacyViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/4/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "PrivacyViewController.h"
#import "WebServiceConnection.h"
#import "Indicator.h"


@interface PrivacyViewController ()
{
    WebServiceConnection *policiesCon;
    Indicator *indicator;
}

@end

@implementation PrivacyViewController
@synthesize  scrollView,policies_lable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    policiesCon = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    [self getData];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    scrollView.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
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
-(void)getData{
    
    
    NSDictionary *urlparam;
    
    [self.view addSubview:indicator];
    
    [policiesCon startConnectionWithString:[NSString stringWithFormat:@"privacy_policy"] HttpMethodType:Post_Type HttpBodyType:urlparam Output:^(NSDictionary *receivedData)
     {
         [indicator removeFromSuperview];
         
         //   NSString *msg;
         
         NSLog(@"%@",receivedData);
         
         if([policiesCon responseCode]==1) {
             
             NSString *msg = [receivedData valueForKey:@"msg"];
             
             NSDictionary *data=[receivedData valueForKey:@"cms_data"];
             
             if([receivedData count]>1) {
                 
                 if ([msg isEqualToString:@"Success"]) {
                     
                   //  NSString *title=[[data valueForKey:@"Cmspage"] valueForKey:@"title"];
                     
                     NSString *description=[[data valueForKey:@"Cmspage"] valueForKey:@"description"];
                     
                      policies_lable.text=description;
                     
                    // self.title=title;
                     
                     policies_lable.numberOfLines = 0;
                     
                     [policies_lable sizeToFit];
                     
                     policies_lable.textAlignment=NSTextAlignmentLeft;
                     
                     //[policies_lable setTextAlignment:NSTextAlignmentJustified];
                     
                     scrollView.contentSize = CGSizeMake(self.view.frame.size.width,policies_lable.frame.origin.y + policies_lable.frame.size.height+50);
                 
                 }else{
                     
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Privacy & Policies" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     
                     [alert show];
                     
                 }
             }
         }else{
             
             [self.navigationController popViewControllerAnimated:YES];
         }
     }];
    
}

@end
