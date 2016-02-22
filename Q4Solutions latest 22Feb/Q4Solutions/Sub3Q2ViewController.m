//
//  Sub3Q2ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/12/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "Sub3Q2ViewController.h"
#import "Sub3Q2TableViewCell.h"
#import "Indicator.h"
#import "WebServiceConnection.h"

@interface Sub3Q2ViewController (){
    
    WebServiceConnection *listConn;
    Indicator *indicator;
    NSArray *listArray,*subcatArray;
    Sub3Q2TableViewCell *cell;
    
}

@end

@implementation Sub3Q2ViewController

@synthesize  Id,sub3Q2_tableView,Category_id;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    listConn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    sub3Q2_tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self SubCategory2List];
    
    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)SubCategory2List{
    
    NSLog(@"%@",Id);
    
    NSDictionary *paramUrl = @{@"type":@"q2",@"subcategoryId":Id,@"categoryId":Category_id
                               };
    
    [self.view addSubview:indicator];
    
    [listConn startConnectionWithString:@"further_steps" HttpMethodType:Post_Type HttpBodyType:paramUrl Output:^(NSDictionary *receivedData){
        
        [indicator removeFromSuperview];
        
        if ([listConn responseCode]==1) {
            
            NSLog(@"%@",receivedData);
            
            NSString *msg = [receivedData valueForKey:@"msg"];
            
            if([msg isEqual:@"success"]) {
                
                listArray = [receivedData valueForKey:@"data"];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Q2Sub Category3" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [sub3Q2_tableView reloadData];
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightr = cell.sub3Q2_lbl.frame.origin.y + cell.sub3Q2_lbl.frame.size.height+10;
    
    return heightr;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [listArray count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"sub3Q2Cell" forIndexPath:indexPath];
    
    sub3Q2_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.sub3Q2_lbl.text = [[[listArray objectAtIndex:indexPath.row] valueForKey:@"Point"]valueForKey:@"name"];
    
    CGRect frame = cell.sub3Q2_lbl.frame;
    
    frame.size.width = self.view.frame.size.width-50;
    
    cell.sub3Q2_lbl.frame = frame;
    
    cell.sub3Q2_lbl.numberOfLines = 0;
    
    cell.sub3Q2_lbl.lineBreakMode = NSLineBreakByWordWrapping;
    
    [cell.sub3Q2_lbl sizeToFit];
    
    frame= cell.sub3Q2_img.frame;
    
    frame.origin.y = cell.sub3Q2_lbl.frame.origin.y+3;
    
    cell.sub3Q2_img.frame = frame;
    
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
