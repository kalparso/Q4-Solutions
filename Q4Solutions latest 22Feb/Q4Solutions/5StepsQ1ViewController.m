//
//  5StepsQ1ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "5StepsQ1ViewController.h"
#import "Indicator.h"
#import "WebServiceConnection.h"
#import "5StepsQ1TableViewCell.h"
#import "Sub1ViewController.h"
#import "Sub2ViewController.h"
#import "Sub3ViewController.h"
#import "Sub4ViewController.h"
#import "Sub5ViewController.h"

@interface _StepsQ1ViewController (){
    
    WebServiceConnection *q1Conn;
    Indicator *indicator;
    NSArray *q1Array;
    NSString *Category_id;
    // NSString *Id;
    _StepsQ1TableViewCell *cell;
    Sub1ViewController *SubV1;
    Sub2ViewController *SubV2;
    Sub3ViewController *SubV3;
    Sub4ViewController *SubV4;
    Sub5ViewController *SubV5;
    NSString *final_id;
    
}

@end

@implementation _StepsQ1ViewController
@synthesize q1_tableView,Id,scroll_View;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    q1Conn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    q1_tableView.tableFooterView =[[UIView alloc] initWithFrame:
                                   CGRectZero];
    
    [self fetchWorkingWithQ1data];
    
    Category_id=Id;
    
    // Do any additional setup after loading the view.
}

-(void)fetchWorkingWithQ1data{
    
    q1_tableView.hidden= YES;
    
    NSDictionary *paramUrl = @{@"type":@"q1",@"categoryId":Id};
    
    [self.view addSubview:indicator];
    
    
    [q1Conn startConnectionWithString:@"sub_category" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([q1Conn responseCode]==1) {
            
            q1_tableView.hidden = NO;
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                
                q1Array = [[receivedData valueForKey:@"data"]valueForKey:@"SubCategory"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Working With Q1" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
        }
        else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [q1_tableView reloadData];
        
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
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"q1Cell" forIndexPath:indexPath];
    
    if ([q1Array count]>0) {
        
        q1_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        q1_tableView.scrollEnabled=NO;

        
        
        if(indexPath.row == 0) {
            
            [cell.actionToAvoid_btn setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
            
            [cell.actionToAvoid_btn setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.actionToAvoid_btn addTarget:self action:@selector(tapSub1Q1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.actionToAvoid_btn.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.actionToAvoid_btn.frame.size.width)/2;
            
            cell.actionToAvoid_btn.frame=frame;
            
            cell.actionToAvoid_btn.tag = indexPath.row;
            
            
        }else if (indexPath.row == 1){
            
            [cell.actionToAvoid_btn setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
            
            [cell.actionToAvoid_btn setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.actionToAvoid_btn addTarget:self action:@selector(tapSub2Q1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.actionToAvoid_btn.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.actionToAvoid_btn.frame.size.width)/2;
            
            cell.actionToAvoid_btn.frame=frame;
            
            cell.actionToAvoid_btn.tag = indexPath.row;
            
        }else if (indexPath.row == 2){
            
            [cell.actionToAvoid_btn setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
            [cell.actionToAvoid_btn setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.actionToAvoid_btn addTarget:self action:@selector(tapSub3Q1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.actionToAvoid_btn.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.actionToAvoid_btn.frame.size.width)/2;
            
            cell.actionToAvoid_btn.frame=frame;
            
            cell.actionToAvoid_btn.tag = indexPath.row;
            
        }else if (indexPath.row == 3){
            
            [cell.actionToAvoid_btn setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
            
            [cell.actionToAvoid_btn setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.actionToAvoid_btn addTarget:self action:@selector(tapSub4Q1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.actionToAvoid_btn.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.actionToAvoid_btn.frame.size.width)/2;
            
            cell.actionToAvoid_btn.frame=frame;
            
            cell.actionToAvoid_btn.tag = indexPath.row;
            
        }else if (indexPath.row == 4){
            
            [cell.actionToAvoid_btn setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
            
            [cell.actionToAvoid_btn setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.actionToAvoid_btn addTarget:self action:@selector(tapSub5Q1Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.actionToAvoid_btn.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.actionToAvoid_btn.frame.size.width)/2;
            
            cell.actionToAvoid_btn.frame=frame;
            
            cell.actionToAvoid_btn.tag = indexPath.row;
            
        }
    }
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

-(void)tapSub1Q1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"Action" sender:self];
    
}

-(void)tapSub2Q1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"Approach" sender:self];
}

-(void)tapSub3Q1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"Barriers" sender:self];
}
-(void)tapSub4Q1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"Needs" sender:self];
}
-(void)tapSub5Q1Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"Probes" sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"Action"]) {
        
        SubV1 = [segue destinationViewController];
        
        SubV1.Id =final_id;
        
        SubV1.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"Approach"]) {
        
        SubV2 = [segue destinationViewController];
        
        SubV2.Id =final_id;
        
        SubV2.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"Barriers"]) {
        
        SubV3 = [segue destinationViewController];
        
        SubV3.Id =final_id;
        
        SubV3.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"Needs"]) {
        
        SubV4 = [segue destinationViewController];
        
        SubV4.Id =final_id;
        
        SubV4.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"Probes"]) {
        
        SubV5 = [segue destinationViewController];
        
        SubV5.Id =final_id;
        
        SubV5.Category_id =Category_id;
    }
    
    
}

@end
