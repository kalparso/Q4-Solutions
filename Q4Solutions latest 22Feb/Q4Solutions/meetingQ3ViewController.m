//
//  meetingQ3ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "meetingQ3ViewController.h"
#import "WebServiceConnection.h"
#import "Indicator.h"
#import "meetingQ3TableViewCell.h"
#import "M1Q3ViewController.h"
#import "M2Q3ViewController.h"
#import "M3Q3ViewController.h"
#import "M4Q3ViewController.h"
#import "M5Q3ViewController.h"


@interface meetingQ3ViewController ()
{
    WebServiceConnection *m1q1Conn;
    Indicator *indicator;
    NSArray *q1Array;
    NSArray *SubCategories;
    NSString *final_id;
    NSString *category_id;
    meetingQ3TableViewCell *cell;
    M1Q3ViewController *M1V;
    M2Q3ViewController *M2V;
    M3Q3ViewController *M3V;
    M4Q3ViewController *M4V;
    M5Q3ViewController *M5V;
    
}

@end

@implementation meetingQ3ViewController
@synthesize Id,Q3_tableView,scroll_View;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m1q1Conn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    Q3_tableView.tableFooterView =[[UIView alloc] initWithFrame:CGRectZero];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    [self fetchMeetingWithQ1data];
    
    category_id=Id;
    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view.
}
-(void)fetchMeetingWithQ1data{
    
    Q3_tableView.hidden= YES;
    
    NSDictionary *paramUrl = @{@"type":@"q3",@"categoryId":Id};
    
    [self.view addSubview:indicator];
    
    
    [m1q1Conn startConnectionWithString:@"sub_category" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([m1q1Conn responseCode]==1) {
            
            Q3_tableView.hidden = NO;
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                
                q1Array = [[receivedData valueForKey:@"data"]valueForKey:@"SubCategory"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"5 Step Meeting With Q3" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
        }else{
            
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
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"meeting3cell" forIndexPath:indexPath];
    
    
    if ([q1Array count]>0) {
        
        Q3_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
         Q3_tableView.scrollEnabled=NO;
        
        
        if(indexPath.row == 0) {
            
            [cell.meetingQ3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            NSString *btnTitle = [[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            NSArray *btnTittleArray = [btnTitle componentsSeparatedByString:@"<br>"];
            
            [cell.meetingQ3_button setTitle:[btnTittleArray componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
            
           // [cell.meetingQ3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.meetingQ3_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [cell.meetingQ3_button addTarget:self action:@selector(tapMeeting1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            CGRect frame=cell.meetingQ3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.meetingQ3_button.frame.size.width)/2;
            
            cell.meetingQ3_button.frame=frame;
            
            
            cell.meetingQ3_button.tag = indexPath.row;
            
            
        }else if (indexPath.row == 1){
            
            [cell.meetingQ3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            NSString *btnTitle = [[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            NSArray *btnTittleArray = [btnTitle componentsSeparatedByString:@"<br>"];
            
            [cell.meetingQ3_button setTitle:[btnTittleArray componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
            
            //[cell.meetingQ3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.meetingQ3_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [cell.meetingQ3_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            
            [cell.meetingQ3_button addTarget:self action:@selector(tapMeeting2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.meetingQ3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.meetingQ3_button.frame.size.width)/2;
            
            cell.meetingQ3_button.frame=frame;
            
            cell.meetingQ3_button.tag = indexPath.row;
            
        }else if (indexPath.row == 2){
            
            [cell.meetingQ3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            NSString *btnTitle = [[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            NSArray *btnTittleArray = [btnTitle componentsSeparatedByString:@"<br>"];
            
            [cell.meetingQ3_button setTitle:[btnTittleArray componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
            
            //[cell.meetingQ3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.meetingQ3_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
                        
            [cell.meetingQ3_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [cell.meetingQ3_button addTarget:self action:@selector(tapMeeting3Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.meetingQ3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.meetingQ3_button.frame.size.width)/2;
            
            cell.meetingQ3_button.frame=frame;
            
            cell.meetingQ3_button.tag = indexPath.row;
            
        }else if (indexPath.row == 3){
            
            [cell.meetingQ3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            NSString *btnTitle = [[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            NSArray *btnTittleArray = [btnTitle componentsSeparatedByString:@"<br>"];
            
            [cell.meetingQ3_button setTitle:[btnTittleArray componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
            
           // [cell.meetingQ3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.meetingQ3_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [cell.meetingQ3_button addTarget:self action:@selector(tapMeeting4Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.meetingQ3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.meetingQ3_button.frame.size.width)/2;
            
            cell.meetingQ3_button.frame=frame;
            
            cell.meetingQ3_button.tag = indexPath.row;
            
        }else if (indexPath.row == 4){
            
            [cell.meetingQ3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            NSString *btnTitle = [[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"];
            
            NSArray *btnTittleArray = [btnTitle componentsSeparatedByString:@"<br>"];
            
            [cell.meetingQ3_button setTitle:[btnTittleArray componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
            
            //[cell.meetingQ3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.meetingQ3_button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [cell.meetingQ3_button addTarget:self action:@selector(tapMeeting5Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.meetingQ3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.meetingQ3_button.frame.size.width)/2;
            
            cell.meetingQ3_button.frame=frame;
            
            cell.meetingQ3_button.tag = indexPath.row;
            
        }
    }
    
    CGRect frame = Q3_tableView.frame;
    
    frame.size.height = Q3_tableView.contentSize.height;
    
    Q3_tableView.frame = frame;
    
    [scroll_View setContentSize:CGSizeMake(self.view.frame.size.width, Q3_tableView.frame.origin.y + Q3_tableView.frame.size.height)];
    
    return cell;
}

-(void)tapMeeting1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting1Q3" sender:self];
    
}

-(void)tapMeeting2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting2Q3" sender:self];
}

-(void)tapMeeting3Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting3Q3" sender:self];
}
-(void)tapMeeting4Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting4Q3" sender:self];
}
-(void)tapMeeting5Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"meeting5Q3" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"meeting1Q3"]) {
        
        M1V = [segue destinationViewController];
        
        M1V.Id =final_id;
        
        M1V.Category_id=category_id;
        
    }else if ([[segue identifier]isEqualToString:@"meeting2Q3"]) {
        
        M2V = [segue destinationViewController];
        
        M2V.Id =final_id;
        
        M2V.Category_id=category_id;
        
    }else if ([[segue identifier]isEqualToString:@"meeting3Q3"]) {
        
        M3V = [segue destinationViewController];
        
        M3V.Id =final_id;
        
        M3V.Category_id=category_id;
        
    }else if ([[segue identifier]isEqualToString:@"meeting4Q3"]) {
        
        M4V = [segue destinationViewController];
        
        M4V.Id =final_id;
        
        M4V.Category_id=category_id;
        
    }else if ([[segue identifier]isEqualToString:@"meeting5Q3"]) {
        
        M5V = [segue destinationViewController];
        
        M5V.Id =final_id;
        
        M5V.Category_id=category_id;
    }
}


@end
