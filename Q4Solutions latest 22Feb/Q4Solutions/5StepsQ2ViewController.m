//
//  5StepsQ2ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "5StepsQ2ViewController.h"
#import "Indicator.h"
#import "WebServiceConnection.h"
#import "5StepsQ2TableViewCell.h"
#import "Sub1Q2ViewController.h"
#import "Sub2Q2ViewController.h"
#import "Sub3Q2ViewController.h"
#import "Sub4Q2ViewController.h"
#import "Sub5Q2ViewController.h"

@interface _StepsQ2ViewController (){
    
    WebServiceConnection *q1Conn;
    Indicator *indicator;
    NSArray *q1Array;
    NSString *Category_id;
    // NSString *Id;
    _StepsQ2TableViewCell *cell;
    Sub1Q2ViewController *SubV1;
    Sub2Q2ViewController *SubV2;
    Sub3Q2ViewController *SubV3;
    Sub4Q2ViewController *SubV4;
    Sub5Q2ViewController *SubV5;
    NSString *final_id;
    
}

@end

@implementation _StepsQ2ViewController
@synthesize meetinWithQ2_tableView,Id,scroll_View;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    q1Conn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    meetinWithQ2_tableView.tableFooterView =[[UIView alloc] initWithFrame:CGRectZero];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    meetinWithQ2_tableView.tableFooterView =[[UIView alloc] initWithFrame:
                                             CGRectZero];
    
    
    [self fetchWorkingWithQ2data];
    
    Category_id=Id;
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)fetchWorkingWithQ2data{
    
    meetinWithQ2_tableView.hidden= YES;
    
    NSDictionary *paramUrl = @{@"type":@"q2",@"categoryId":Id};
    
    [self.view addSubview:indicator];
    
    
    [q1Conn startConnectionWithString:@"sub_category" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([q1Conn responseCode]==1) {
            
            meetinWithQ2_tableView.hidden = NO;
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                
                q1Array = [[receivedData valueForKey:@"data"]valueForKey:@"SubCategory"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Working With Q2" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
        }
        else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [meetinWithQ2_tableView reloadData];
        
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
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"q2Cell" forIndexPath:indexPath];
    
   

    
    if ([q1Array count]>0) {
        
        meetinWithQ2_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        meetinWithQ2_tableView.scrollEnabled=NO;
        
        if(indexPath.row == 0) {
            
            [cell.workingWithQ2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            [cell.workingWithQ2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.workingWithQ2_button addTarget:self action:@selector(tapSub1Q2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.workingWithQ2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ2_button.frame.size.width)/2;
            
            cell.workingWithQ2_button.frame=frame;
            
            cell.workingWithQ2_button.tag = indexPath.row;
            
            
        }else if (indexPath.row == 1){
            
            [cell.workingWithQ2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            [cell.workingWithQ2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            
            [cell.workingWithQ2_button addTarget:self action:@selector(tapSub2Q2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.workingWithQ2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ2_button.frame.size.width)/2;
            
            cell.workingWithQ2_button.frame=frame;
            
            
            cell.workingWithQ2_button.tag = indexPath.row;
            
        }else if (indexPath.row == 2){
            
            [cell.workingWithQ2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            [cell.workingWithQ2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.workingWithQ2_button addTarget:self action:@selector(tapSub3Q2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.workingWithQ2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ2_button.frame.size.width)/2;
            
            cell.workingWithQ2_button.frame=frame;
            
            
            cell.workingWithQ2_button.tag = indexPath.row;
            
        }else if (indexPath.row == 3){
            
            [cell.workingWithQ2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            [cell.workingWithQ2_button addTarget:self action:@selector(tapSub4Q2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.workingWithQ2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            CGRect frame=cell.workingWithQ2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ2_button.frame.size.width)/2;
            
            cell.workingWithQ2_button.frame=frame;
            
            
            cell.workingWithQ2_button.tag = indexPath.row;
            
        }else if (indexPath.row == 4){
            
            [cell.workingWithQ2_button setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
            
            [cell.workingWithQ2_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.workingWithQ2_button addTarget:self action:@selector(tapSub5Q2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.workingWithQ2_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ2_button.frame.size.width)/2;
            
            cell.workingWithQ2_button.frame=frame;
            
            
            cell.workingWithQ2_button.tag = indexPath.row;
            
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

-(void)tapSub1Q2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"sub1Q2" sender:self];
    
}

-(void)tapSub2Q2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"sub2Q2" sender:self];
}

-(void)tapSub3Q2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"sub3Q2" sender:self];
}
-(void)tapSub4Q2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"sub4Q2" sender:self];
}
-(void)tapSub5Q2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"sub5Q2" sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"sub1Q2"]) {
        
        SubV1 = [segue destinationViewController];
        
        SubV1.Id =final_id;
        
        SubV1.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"sub2Q2"]) {
        
        SubV2 = [segue destinationViewController];
        
        SubV2.Id =final_id;
        
        SubV2.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"sub3Q2"]) {
        
        SubV3 = [segue destinationViewController];
        
        SubV3.Id =final_id;
        
        SubV3.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"sub4Q2"]) {
        
        SubV4 = [segue destinationViewController];
        
        SubV4.Id =final_id;
        
        SubV4.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"sub5Q2"]) {
        
        SubV5 = [segue destinationViewController];
        
        SubV5.Id =final_id;
        
        SubV5.Category_id =Category_id;
    }
    
}

@end
