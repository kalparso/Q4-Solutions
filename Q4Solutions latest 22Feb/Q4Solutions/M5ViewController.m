//
//  M5ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/12/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "M5ViewController.h"
#import "M5TableViewCell.h"
#import "WebServiceConnection.h"
#import "Indicator.h"


@interface M5ViewController ()
{
    WebServiceConnection *listConn;
    Indicator *indicator;
    NSArray *listArray;
    M5TableViewCell *cell;
}


@end

@implementation M5ViewController
@synthesize  scroll_View,m5_tableView,Id,Category_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    listConn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    m5_tableView.tableFooterView =[[UIView alloc] initWithFrame:CGRectZero];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    [self meetingWithQ1List];
    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    

    // Do any additional setup after loading the view.
}
-(void)meetingWithQ1List{
    
    NSLog(@"%@",Id);
    
    NSDictionary *paramUrl = @{@"type":@"q1",@"subcategoryId":Id,@"categoryId":Category_id};
    
    [self.view addSubview:indicator];
    
    [listConn startConnectionWithString:@"further_steps" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([listConn responseCode]==1) {
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                listArray = [receivedData valueForKey:@"data"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sub Category5" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [m5_tableView reloadData];
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightr = cell.m5_lbl.frame.origin.y + cell.m5_lbl.frame.size.height+10;
    
    return heightr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [listArray count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"m5Q1Cell" forIndexPath:indexPath];
    
    m5_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.m5_lbl.text = [[[listArray objectAtIndex:indexPath.row] valueForKey:@"Point"]valueForKey:@"name"];
    
    CGRect frame = cell.m5_lbl.frame;
    
    frame.size.width = self.view.frame.size.width-50;
    
    cell.m5_lbl.frame = frame;
    
    cell.m5_lbl.numberOfLines = 0;
    
    cell.m5_lbl.lineBreakMode = NSLineBreakByWordWrapping;
    
    [cell.m5_lbl sizeToFit];
    
    frame= cell.m5_img.frame;
    
    frame.origin.y = cell.m5_lbl.frame.origin.y+3;
    
    cell.m5_img.frame = frame;

    
    return  cell;
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

@end
