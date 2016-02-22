//
//  M1Q4ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/12/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "M1Q4ViewController.h"
#import "M1Q4TableViewCell.h"
#import "WebServiceConnection.h"
#import "Indicator.h"

@interface M1Q4ViewController ()
{
    WebServiceConnection *listConn;
    Indicator *indicator;
    NSArray *listArray;
    M1Q4TableViewCell *cell;
}

@end

@implementation M1Q4ViewController
@synthesize scroll_View,Id,m1Q4_tableView,Category_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    listConn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    
    m1Q4_tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    
    [self meetingWithQ2List];
    
    CGRect frame = scroll_View.frame;
    
    frame.origin.y = self.view.frame.origin.y-67;
    
    scroll_View.frame = frame;
    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view.
}
-(void)meetingWithQ2List{
    
    NSLog(@"%@",Id);
    
    NSDictionary *paramUrl = @{@"type":@"q4",@"subcategoryId":Id,@"categoryId":Category_id};
    
    [self.view addSubview:indicator];
    
    [listConn startConnectionWithString:@"further_steps" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([listConn responseCode]==1) {
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                listArray = [receivedData valueForKey:@"data"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Meeting1 with Q4" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [m1Q4_tableView reloadData];
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightr = cell.m1Q4_lbl.frame.origin.y + cell.m1Q4_lbl.frame.size.height+10;
    
    return heightr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [listArray count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"m1Q4Cell" forIndexPath:indexPath];
    
    m1Q4_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.m1Q4_lbl.text = [[[listArray objectAtIndex:indexPath.row] valueForKey:@"Point"]valueForKey:@"name"];
    
    CGRect frame = cell.m1Q4_lbl.frame;
    
    frame.size.width = self.view.frame.size.width-50;
    
    cell.m1Q4_lbl.frame = frame;
    
    cell.m1Q4_lbl.numberOfLines = 0;
    
    cell.m1Q4_lbl.lineBreakMode = NSLineBreakByWordWrapping;
    
    [cell.m1Q4_lbl sizeToFit];
    
    frame= cell.m1Q4_img.frame;
    
    frame.origin.y = cell.m1Q4_lbl.frame.origin.y+3;
    
    cell.m1Q4_img.frame = frame;
    
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
