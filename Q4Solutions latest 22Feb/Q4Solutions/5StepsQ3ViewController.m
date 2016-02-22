//
//  5StepsQ3ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "5StepsQ3ViewController.h"
#import "Indicator.h"
#import "WebServiceConnection.h"
#import "5StepsQ3TableViewCell.h"
#import "Sub1Q3ViewController.h"
#import "Sub2Q3ViewController.h"
#import "Sub3Q3ViewController.h"
#import "Sub4Q3ViewController.h"
#import "Sub5Q3ViewController.h"

@interface _StepsQ3ViewController (){
    
    WebServiceConnection *q1Conn;
    Indicator *indicator;
    NSArray *q1Array;
    NSString *Category_id;
    // NSString *Id;
    _StepsQ3TableViewCell *cell;
    Sub1Q3ViewController *SubV1;
    Sub2Q3ViewController *SubV2;
    Sub3Q3ViewController *SubV3;
    Sub4Q3ViewController *SubV4;
    Sub5Q3ViewController *SubV5;
    NSString *final_id;
    
}

@end

@implementation _StepsQ3ViewController
@synthesize workingWithQ3_tableView,Id,scroll_View;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    q1Conn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    workingWithQ3_tableView.tableFooterView =[[UIView alloc] initWithFrame:CGRectZero];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    workingWithQ3_tableView.tableFooterView =[[UIView alloc] initWithFrame:
                                              CGRectZero];
    
    
    [self fetchWorkingWithQ3data];
    
    Category_id=Id;
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)fetchWorkingWithQ3data{
    
    workingWithQ3_tableView.hidden= YES;
    
    NSDictionary *paramUrl = @{@"type":@"q3",@"categoryId":Id};
    
    [self.view addSubview:indicator];
    
    
    [q1Conn startConnectionWithString:@"sub_category" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([q1Conn responseCode]==1) {
            
            workingWithQ3_tableView.hidden = NO;
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                
                q1Array = [[receivedData valueForKey:@"data"]valueForKey:@"SubCategory"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Working With Q3" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
        }
        else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [workingWithQ3_tableView reloadData];
        
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
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"q3Cell" forIndexPath:indexPath];
    
    if ([q1Array count]>0) {
        
        workingWithQ3_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
         workingWithQ3_tableView.scrollEnabled=NO;
        
        
        if(indexPath.row == 0) {
            
            [cell.workingWithQ3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            [cell.workingWithQ3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.workingWithQ3_button addTarget:self action:@selector(tapSub1Q2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.workingWithQ3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ3_button.frame.size.width)/2;
            
            cell.workingWithQ3_button.frame=frame;
            
            cell.workingWithQ3_button.tag = indexPath.row;
            
            
        }else if (indexPath.row == 1){
            
            [cell.workingWithQ3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            [cell.workingWithQ3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            
            [cell.workingWithQ3_button addTarget:self action:@selector(tapSub2Q2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.workingWithQ3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ3_button.frame.size.width)/2;
            
            cell.workingWithQ3_button.frame=frame;
            
            
            cell.workingWithQ3_button.tag = indexPath.row;
            
        }else if (indexPath.row == 2){
            
            [cell.workingWithQ3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            [cell.workingWithQ3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.workingWithQ3_button addTarget:self action:@selector(tapSub3Q2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.workingWithQ3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ3_button.frame.size.width)/2;
            
            cell.workingWithQ3_button.frame=frame;
            
            
            cell.workingWithQ3_button.tag = indexPath.row;
            
        }else if (indexPath.row == 3){
            
            [cell.workingWithQ3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            [cell.workingWithQ3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.workingWithQ3_button addTarget:self action:@selector(tapSub4Q2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.workingWithQ3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ3_button.frame.size.width)/2;
            
            cell.workingWithQ3_button.frame=frame;
            
            
            cell.workingWithQ3_button.tag = indexPath.row;
            
        }else if (indexPath.row == 4){
            
            [cell.workingWithQ3_button setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateNormal];
            
            [cell.workingWithQ3_button setTitle:[[q1Array objectAtIndex:indexPath.row] valueForKey:@"name"] forState:UIControlStateNormal];
            
            [cell.workingWithQ3_button addTarget:self action:@selector(tapSub5Q2Btn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame=cell.workingWithQ3_button.frame;
            
            frame.origin.x = (self.view.frame.size.width-cell.workingWithQ3_button.frame.size.width)/2;
            
            cell.workingWithQ3_button.frame=frame;
            
            
            cell.workingWithQ3_button.tag = indexPath.row;
            
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

-(void)tapSub1Q2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"sub1Q3" sender:self];
    
}

-(void)tapSub2Q2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"sub2Q3" sender:self];
}

-(void)tapSub3Q2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"sub3Q3" sender:self];
}
-(void)tapSub4Q2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"sub4Q3" sender:self];
}
-(void)tapSub5Q2Btn:(UIButton *)sender{
    
    final_id   = [[q1Array objectAtIndex:sender.tag]valueForKey:@"id"];
    
    [self performSegueWithIdentifier:@"sub5Q3" sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier]isEqualToString:@"sub1Q3"]) {
        
        SubV1 = [segue destinationViewController];
        
        SubV1.Id =final_id;
        
        SubV1.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"sub2Q3"]) {
        
        SubV2 = [segue destinationViewController];
        
        SubV2.Id =final_id;
        
        SubV2.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"sub3Q3"]) {
        
        SubV3 = [segue destinationViewController];
        
        SubV3.Id =final_id;
        
        SubV3.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"sub4Q3"]) {
        
        SubV4 = [segue destinationViewController];
        
        SubV4.Id =final_id;
        
        SubV4.Category_id =Category_id;
        
    }else if ([[segue identifier]isEqualToString:@"sub5Q3"]) {
        
        SubV5 = [segue destinationViewController];
        
        SubV5.Id =final_id;
        
        SubV5.Category_id =Category_id;
    }
    
}

@end
