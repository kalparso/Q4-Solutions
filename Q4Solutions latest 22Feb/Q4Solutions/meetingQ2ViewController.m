//
//  meetingQ2ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "meetingQ2ViewController.h"
#import "WebServiceConnection.h"
#import "Indicator.h"
#import "meetingQ2TableViewCell.h"
#import "M1Q2ViewController.h"
#import "M2Q2ViewController.h"
#import "M3Q2ViewController.h"
#import "M4Q2ViewController.h"
#import "M5Q2ViewController.h"


@interface meetingQ2ViewController ()
{
    WebServiceConnection *m1q1Conn;
    Indicator *indicator;
    NSArray *q1Array;
    NSArray *SubCategories;
    NSString *final_id;
    NSString *category_id;
    meetingQ2TableViewCell *cell;
    M1Q2ViewController *M1V;
    M2Q2ViewController *M2V;
    M3Q2ViewController *M3V;
    M4Q2ViewController *M4V;
    M5Q2ViewController *M5V;
    
}

@end

@implementation meetingQ2ViewController
@synthesize Id,meetingWithQ2_tableView,scroll_View;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m1q1Conn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    meetingWithQ2_tableView.tableFooterView =[[UIView alloc] initWithFrame:CGRectZero];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    [self fetchMeetingWithQ1data];
    
    category_id=Id;
    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view.
}
-(void)fetchMeetingWithQ1data{
    
    meetingWithQ2_tableView.hidden= YES;
    
    NSDictionary *paramUrl = @{@"type":@"q2",@"categoryId":Id};
    
    [self.view addSubview:indicator];
    
    
    [m1q1Conn startConnectionWithString:@"sub_category" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([m1q1Conn responseCode]==1) {
            
            meetingWithQ2_tableView.hidden = NO;
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                
                q1Array = [[receivedData valueForKey:@"data"]valueForKey:@"SubCategory"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"5 Step Meeting With Q2" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [meetingWithQ2_tableView reloadData];
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
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"meeting2cell" forIndexPath:indexPath];
    
    meetingWithQ2_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([q1Array count]>0) {
        
        meetingWithQ2_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
         meetingWithQ2_tableView.scrollEnabled=NO;
        
        if(indexPath.row == 0) {
            
            [cell.meetingwithQ2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            NSString *btnTitle = [[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            NSArray *btnTittleArray = [btnTitle componentsSeparatedByString:@"<br>"];
            
            [cell.meetingwithQ2_button setTitle:[btnTittleArray componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
            
            //[cell.meetingwithQ2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.meetingwithQ2_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [cell.meetingwithQ2_button addTarget:self action:@selector(tapMeeting1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.meetingwithQ2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.meetingwithQ2_button.frame.size.width)/2;
            
            cell.meetingwithQ2_button.frame=frame;
            
            
            cell.meetingwithQ2_button.tag = indexPath.row;
            
            
        }else if (indexPath.row == 1){
            
            [cell.meetingwithQ2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            NSString *btnTitle = [[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            NSArray *btnTittleArray = [btnTitle componentsSeparatedByString:@"<br>"];
            
            [cell.meetingwithQ2_button setTitle:[btnTittleArray componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
            
            //[cell.meetingwithQ2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.meetingwithQ2_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            
            [cell.meetingwithQ2_button addTarget:self action:@selector(tapMeeting2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.meetingwithQ2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.meetingwithQ2_button.frame.size.width)/2;
            
            cell.meetingwithQ2_button.frame=frame;
            
            
            cell.meetingwithQ2_button.tag = indexPath.row;
            
        }else if (indexPath.row == 2){
            
            [cell.meetingwithQ2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            NSString *btnTitle = [[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            NSArray *btnTittleArray = [btnTitle componentsSeparatedByString:@"<br>"];
            
            [cell.meetingwithQ2_button setTitle:[btnTittleArray componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
            
           // [cell.meetingwithQ2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.meetingwithQ2_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [cell.meetingwithQ2_button addTarget:self action:@selector(tapMeeting3Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.meetingwithQ2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.meetingwithQ2_button.frame.size.width)/2;
            
            cell.meetingwithQ2_button.frame=frame;
            
            
            cell.meetingwithQ2_button.tag = indexPath.row;
            
        }else if (indexPath.row == 3){
            
            [cell.meetingwithQ2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            NSString *btnTitle = [[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            NSArray *btnTittleArray = [btnTitle componentsSeparatedByString:@"<br>"];
            
            [cell.meetingwithQ2_button setTitle:[btnTittleArray componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
            
            //[cell.meetingwithQ2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.meetingwithQ2_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [cell.meetingwithQ2_button addTarget:self action:@selector(tapMeeting4Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.meetingwithQ2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.meetingwithQ2_button.frame.size.width)/2;
            
            cell.meetingwithQ2_button.frame=frame;
            
            
            cell.meetingwithQ2_button.tag = indexPath.row;
            
        }else if (indexPath.row == 4){
            
            [cell.meetingwithQ2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            NSString *btnTitle = [[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            NSArray *btnTittleArray = [btnTitle componentsSeparatedByString:@"<br>"];
            
            [cell.meetingwithQ2_button setTitle:[btnTittleArray componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
            
           // [cell.meetingwithQ2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.meetingwithQ2_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [cell.meetingwithQ2_button addTarget:self action:@selector(tapMeeting5Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.meetingwithQ2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.meetingwithQ2_button.frame.size.width)/2;
            
            cell.meetingwithQ2_button.frame=frame;
            
            
            cell.meetingwithQ2_button.tag = indexPath.row;
            
        }
    }
    
    CGRect frame = meetingWithQ2_tableView.frame;
    
    frame.size.height = meetingWithQ2_tableView.contentSize.height;
    
    meetingWithQ2_tableView.frame = frame;
    
    [scroll_View setContentSize:CGSizeMake(self.view.frame.size.width, meetingWithQ2_tableView.frame.origin.y + meetingWithQ2_tableView.frame.size.height)];
    
    return cell;
}

-(void)tapMeeting1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting1Q2" sender:self];
    
}

-(void)tapMeeting2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting2Q2" sender:self];
}

-(void)tapMeeting3Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting3Q2" sender:self];
}
-(void)tapMeeting4Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting4Q2" sender:self];
}
-(void)tapMeeting5Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting5Q2" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"meeting1Q2"]) {
        
        M1V = [segue destinationViewController];
        
        M1V.Id =final_id;
        
        M1V.Category_id=category_id;
        
    }else if ([[segue identifier]isEqualToString:@"meeting2Q2"]) {
        
        M2V = [segue destinationViewController];
        
        M2V.Id =final_id;
        
        M2V.Category_id=category_id;
        
    }else if ([[segue identifier]isEqualToString:@"meeting3Q2"]) {
        
        M3V = [segue destinationViewController];
        
        M3V.Id =final_id;
        
        M3V.Category_id=category_id;
        
    }else if ([[segue identifier]isEqualToString:@"meeting4Q2"]) {
        
        M4V = [segue destinationViewController];
        
        M4V.Id =final_id;
        
        M4V.Category_id=category_id;
        
    }else if ([[segue identifier]isEqualToString:@"meeting5Q2"]) {
        
        M5V = [segue destinationViewController];
        
        M5V.Id =final_id;
        
        M5V.Category_id=category_id;
    }
}


@end
