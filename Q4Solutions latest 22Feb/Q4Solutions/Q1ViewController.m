//
//  Q1ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "Q1ViewController.h"
#import "Q1TableViewCell.h"
#import "Indicator.h"
#import "WebServiceConnection.h"
#import "5StepsQ1ViewController.h"
#import "meetingQ1ViewController.h"

@interface Q1ViewController ()
{
    WebServiceConnection *q1Conn;
    Indicator *indicator;
    NSArray *q1Array,*homeArr;
    NSArray *SubCategories;
    NSString *Id;
    Q1TableViewCell *cell;
    _StepsQ1ViewController *subV1;
    meetingQ1ViewController *meeting;
    NSString *final_id;
    
}

@end

@implementation Q1ViewController
@synthesize scroll_View,Q1_tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    q1Conn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    Q1_tableView.tableFooterView =[[UIView alloc] initWithFrame:
                                   CGRectZero];
    
    [self fetchWorkingWithQ1data];
    
    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    
}

-(void)fetchWorkingWithQ1data{
    
    Q1_tableView.hidden= YES;
    
    NSDictionary *paramUrl = @{@"working_4":@"q1",@"type":@"Q1"};
    
    [self.view addSubview:indicator];
    
    
    [q1Conn startConnectionWithString:@"working_with_q1" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([q1Conn responseCode]==1) {
            
            Q1_tableView.hidden = NO;
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                q1Array = [[receivedData valueForKey:@"data"]valueForKey:@"Category"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Q1" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            
        }
        else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [Q1_tableView reloadData];
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [q1Array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //static NSString *CellIdentifier = @"Cell";
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"Q1cell" forIndexPath:indexPath];
    
    if ([q1Array count]>0) {
        
        Q1_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        Q1_tableView.scrollEnabled=NO;
        
        if(indexPath.row == 0) {
            
            [cell.workingWithQ1_button setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
            
            [cell.workingWithQ1_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.workingWithQ1_button addTarget:self action:@selector(tapWorkingWitQ1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.workingWithQ1_button.tag = indexPath.row;
            
            CGRect frame=cell.workingWithQ1_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ1_button.frame.size.width)/2;
            
            cell.workingWithQ1_button.frame=frame;
            
        }else if (indexPath.row == 1){
            
            [cell.workingWithQ1_button setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
            
            [cell.workingWithQ1_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            
            [cell.workingWithQ1_button addTarget:self action:@selector(tapMeetingWithQ1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.workingWithQ1_button.tag = indexPath.row;
            
            cell.workingWithQ1_button.tag = indexPath.row;
            
            CGRect frame=cell.workingWithQ1_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ1_button.frame.size.width)/2;
            
            cell.workingWithQ1_button.frame=frame;
        }
    }
    return cell;
}

-(void)tapWorkingWitQ1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"working" sender:self];
    
}

-(void)tapMeetingWithQ1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting" sender:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"working"]) {
        
        subV1 = [segue destinationViewController];
        
        subV1.Id =final_id;
        
    }else if ([[segue identifier]isEqualToString:@"meeting"]) {
        
        meeting = [segue destinationViewController];
        
        meeting.Id = final_id;
    }
}


@end
