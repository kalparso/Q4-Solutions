//
//  Sub4Q4ViewController.m
//  Q4Solutions
//
//  Created by Promatics on 12/12/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "Sub4Q4ViewController.h"
#import "Sub4Q4TableViewCell.h"
#import "Indicator.h"
#import "WebServiceConnection.h"

@interface Sub4Q4ViewController (){
    
    WebServiceConnection *listConn;
    Indicator *indicator;
    NSArray *listArray,*subcatArray;
    Sub4Q4TableViewCell *cell;
    
}

@end

@implementation Sub4Q4ViewController

@synthesize  Id,sub4Q4_tableView,Category_id;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    listConn = [WebServiceConnection connectionManager];
    
    indicator = [[Indicator alloc] initWithFrame:self.view.frame];
    
    sub4Q4_tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self SubCategory1List];
    
    
    //scroll_View.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)SubCategory1List{
    
    NSLog(@"%@",Id);
    
    NSDictionary *paramUrl = @{@"type":@"q4",@"subcategoryId":Id,@"categoryId":Category_id
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
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Q4Sub Category4" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
            }
            
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [sub4Q4_tableView reloadData];
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightr = cell.sub4Q4_lbl.frame.origin.y + cell.sub4Q4_lbl.frame.size.height+10;
    
    return heightr;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [listArray count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"sub4Q4Cell" forIndexPath:indexPath];
    
    sub4Q4_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.sub4Q4_lbl.text = [[[listArray objectAtIndex:indexPath.row] valueForKey:@"Point"]valueForKey:@"name"];
    
    CGRect frame = cell.sub4Q4_lbl.frame;
    
    frame.size.width = self.view.frame.size.width-50;
    
    cell.sub4Q4_lbl.frame = frame;
    
    cell.sub4Q4_lbl.numberOfLines = 0;
    
    cell.sub4Q4_lbl.lineBreakMode = NSLineBreakByWordWrapping;
    
    [cell.sub4Q4_lbl sizeToFit];
    
    frame= cell.sub4Q4_img.frame;
    
    frame.origin.y = cell.sub4Q4_lbl.frame.origin.y+3;
    
    cell.sub4Q4_img.frame = frame;
    
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
