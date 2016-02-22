//
//  Q4ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.

#import "Q4ViewController.h"
#import "Q4TableViewCell.h"
#import "Indicator.h"
#import "WebServiceConnection.h"
#import "5StepsQ4ViewController.h"
#import "meetingQ4ViewController.h"

@interface Q4ViewController ()
{
    WebServiceConnection *q1Conn;
    Indicator *indicator;
    NSArray *q1Array,*homeArr;
    NSArray *SubCategories;
    NSString *Id;
    Q4TableViewCell *cell;
    _StepsQ4ViewController *Working;
    meetingQ4ViewController *meeting;
    NSString *final_id;
    
}

@end

@implementation Q4ViewController
@synthesize scroll_View,Q4_tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    q1Conn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    Q4_tableView.tableFooterView =[[UIView alloc] initWithFrame:
                                   CGRectZero];
    
    [self fetchQ3data];
    
    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    
}

-(void)fetchQ3data{
    
    Q4_tableView.hidden= YES;
    
    NSDictionary *paramUrl = @{@"working_4":@"q4",@"type":@"Q4"};
    
    [self.view addSubview:indicator];
    
    
    [q1Conn startConnectionWithString:@"working_with_q1" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([q1Conn responseCode]==1) {
            
            Q4_tableView.hidden = NO;
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                q1Array = [[receivedData valueForKey:@"data"]valueForKey:@"Category"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Q4" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            
        } else {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [Q4_tableView reloadData];
        
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
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"Q4cell" forIndexPath:indexPath];
    
    if ([q1Array count]>0) {
        
        Q4_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
         Q4_tableView.scrollEnabled=NO;
        
        if(indexPath.row == 0) {
            
            [cell.Q4_button setBackgroundImage:[UIImage imageNamed:@"yellow"] forState:UIControlStateNormal];
            
            [cell.Q4_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.Q4_button addTarget:self action:@selector(tapWorkingWitQ1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.Q4_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.Q4_button.frame.size.width)/2;
            
            cell.Q4_button.frame=frame;
            
            cell.Q4_button.tag = indexPath.row;
            
        }else if (indexPath.row == 1){
            
            [cell.Q4_button setBackgroundImage:[UIImage imageNamed:@"yellow"] forState:UIControlStateNormal];
            
            [cell.Q4_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            
            [cell.Q4_button addTarget:self action:@selector(tapMeetingWithQ1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.Q4_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.Q4_button.frame.size.width)/2;
            
            cell.Q4_button.frame=frame;
            
            cell.Q4_button.tag = indexPath.row;
            
        }
    }
    
    CGRect frame = Q4_tableView.frame;
    
    frame.size.height = Q4_tableView.contentSize.height;
    
    Q4_tableView.frame = frame;
    
    [scroll_View setContentSize:CGSizeMake(self.view.frame.size.width, Q4_tableView.frame.origin.y + Q4_tableView.frame.size.height)];
    
    return cell;
}


-(void)tapWorkingWitQ1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"workingwithQ4" sender:self];
    
}

-(void)tapMeetingWithQ1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"Q4meeting" sender:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"workingwithQ4"]) {
        
        Working = [segue destinationViewController];
        
        Working.Id =final_id;
        
    }else if ([[segue identifier]isEqualToString:@"Q4meeting"]) {
        
        meeting = [segue destinationViewController];
        
        meeting.Id = final_id;
    }
}


@end
