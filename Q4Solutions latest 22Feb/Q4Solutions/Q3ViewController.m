//
//  Q3ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//
#import "Q3ViewController.h"
#import "Q3TableViewCell.h"
#import "Indicator.h"
#import "WebServiceConnection.h"
#import "5StepsQ3ViewController.h"
#import "meetingQ3ViewController.h"

@interface Q3ViewController ()
{
    WebServiceConnection *q1Conn;
    Indicator *indicator;
    NSArray *q1Array,*homeArr;
    NSArray *SubCategories;
    NSString *Id;
    Q3TableViewCell *cell;
    _StepsQ3ViewController *Working;
    meetingQ3ViewController *meeting;
    NSString *final_id;
    
}

@end

@implementation Q3ViewController
@synthesize scroll_View,Q3_tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    q1Conn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    Q3_tableView.tableFooterView =[[UIView alloc] initWithFrame:
                                   CGRectZero];
    
    [self fetchQ3data];
    
    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    
}

-(void)fetchQ3data{
    
    Q3_tableView.hidden= YES;
    
    NSDictionary *paramUrl = @{@"working_4":@"q3",@"type":@"Q3"};
    
    [self.view addSubview:indicator];
    
    
    [q1Conn startConnectionWithString:@"working_with_q1" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([q1Conn responseCode]==1) {
            
            Q3_tableView.hidden = NO;
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                q1Array = [[receivedData valueForKey:@"data"]valueForKey:@"Category"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Q3" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            
        }
        else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [Q3_tableView reloadData];
        
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
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"Q3cell" forIndexPath:indexPath];
    
    if ([q1Array count]>0) {
        
        Q3_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
         Q3_tableView.scrollEnabled=NO;
        
        if(indexPath.row == 0) {
            
            [cell.Q3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            [cell.Q3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.Q3_button addTarget:self action:@selector(tapWorkingWitQ1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.Q3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.Q3_button.frame.size.width)/2;
            
            cell.Q3_button.frame=frame;
            
            cell.Q3_button.tag = indexPath.row;
            
        }else if (indexPath.row == 1){
            
            [cell.Q3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            [cell.Q3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            
            [cell.Q3_button addTarget:self action:@selector(tapMeetingWithQ1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.Q3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.Q3_button.frame.size.width)/2;
            
            cell.Q3_button.frame=frame;
            
            cell.Q3_button.tag = indexPath.row;
            
        }
    }
    return cell;
}


-(void)tapWorkingWitQ1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"workingwithQ3" sender:self];
    
}

-(void)tapMeetingWithQ1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"Q3meeting" sender:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"workingwithQ3"]) {
        
        Working = [segue destinationViewController];
        
        Working.Id =final_id;
        
    }else if ([[segue identifier]isEqualToString:@"Q3meeting"]) {
        
        meeting = [segue destinationViewController];
        
        meeting.Id = final_id;
    }
}


@end
