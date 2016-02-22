//
//  Sub1ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/12/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "Sub1ViewController.h"
#import "Sub1TableViewCell.h"
#import "Indicator.h"
#import "WebServiceConnection.h"

@interface Sub1ViewController (){
    
    WebServiceConnection *listConn;
    Indicator *indicator;
    NSArray *listArray,*subcatArray;
    Sub1TableViewCell *cell;
    
}

@end

@implementation Sub1ViewController

@synthesize  Id,WorkingQ1_tebleView,Category_id;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    listConn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
   
    WorkingQ1_tebleView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self ActionToAvoidList];

    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    }

-(void)ActionToAvoidList{
    
    NSLog(@"%@",Id);
    
    NSDictionary *paramUrl = @{@"type":@"q1",@"subcategoryId":Id,@"categoryId":Category_id
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
                
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sub Category1" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
        [alert show];
        }
            
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [WorkingQ1_tebleView reloadData];
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightr = cell.lbl_row.frame.origin.y + cell.lbl_row.frame.size.height+10;
    
    return heightr;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [listArray count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"sub1Cell" forIndexPath:indexPath];
    
   WorkingQ1_tebleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.lbl_row.text = [[[listArray objectAtIndex:indexPath.row] valueForKey:@"Point"]valueForKey:@"name"];
    
    CGRect frame = cell.lbl_row.frame;
    
    frame.size.width = self.view.frame.size.width-50;
    
    cell.lbl_row.frame = frame;
    
    cell.lbl_row.numberOfLines = 0;
    
    cell.lbl_row.lineBreakMode = NSLineBreakByWordWrapping;
    
    [cell.lbl_row sizeToFit];
    
    frame= cell.img_red.frame;
    
    frame.origin.y = cell.lbl_row.frame.origin.y+3;
    
    cell.img_red.frame = frame;

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
