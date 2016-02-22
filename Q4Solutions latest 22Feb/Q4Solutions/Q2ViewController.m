//
//  Q2ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "Q2ViewController.h"
#import "Q2TableViewCell.h"
#import "Indicator.h"
#import "WebServiceConnection.h"
#import "5StepsQ2ViewController.h"
#import "meetingQ2ViewController.h"

@interface Q2ViewController ()
{
    WebServiceConnection *q1Conn;
    Indicator *indicator;
    NSArray *q1Array,*homeArr;
    NSArray *SubCategories;
    NSString *Id;
    Q2TableViewCell *cell;
    _StepsQ2ViewController *Working;
    meetingQ2ViewController *meeting;
    NSString *final_id;
    
}

@end

@implementation Q2ViewController
@synthesize scroll_View,Q2_tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    q1Conn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    Q2_tableView.tableFooterView =[[UIView alloc] initWithFrame:
                                   CGRectZero];
    
    [self fetchQ2data];
    
    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    
}

-(void)fetchQ2data{
    
    Q2_tableView.hidden= YES;
    
    NSDictionary *paramUrl = @{@"working_4":@"q2",@"type":@"Q2"};
    
    [self.view addSubview:indicator];
    
    
    [q1Conn startConnectionWithString:@"working_with_q1" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([q1Conn responseCode]==1) {
            
            Q2_tableView.hidden = NO;
            
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
        
        [Q2_tableView reloadData];
        
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
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"Q2cell" forIndexPath:indexPath];
    
    if ([q1Array count]>0) {
        
        Q2_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        Q2_tableView.scrollEnabled=NO;

        
        if(indexPath.row == 0) {
            
            [cell.Q2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            [cell.Q2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.Q2_button addTarget:self action:@selector(tapWorkingWitQ1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.Q2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.Q2_button.frame.size.width)/2;
            
            cell.Q2_button.frame=frame;
            
            cell.Q2_button.tag = indexPath.row;
            
        }else if (indexPath.row == 1){
            
            [cell.Q2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            [cell.Q2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            
            [cell.Q2_button addTarget:self action:@selector(tapMeetingWithQ1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.Q2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.Q2_button.frame.size.width)/2;
            
            cell.Q2_button.frame=frame;
            
            cell.Q2_button.tag = indexPath.row;
            
        }
    }
    return cell;
}


-(void)tapWorkingWitQ1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"workingwithQ2" sender:self];
    
}

-(void)tapMeetingWithQ1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"Q2meeting" sender:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"workingwithQ2"]) {
        
        Working = [segue destinationViewController];
        
        Working.Id =final_id;
        
    }else if ([[segue identifier]isEqualToString:@"Q2meeting"]) {
        
        meeting = [segue destinationViewController];
        
        meeting.Id = final_id;
    }
}


@end
