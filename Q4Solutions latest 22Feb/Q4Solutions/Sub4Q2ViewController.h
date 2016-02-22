//
//  Sub4Q2ViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/12/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sub4Q2ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_View;
@property (weak, nonatomic) IBOutlet NSString *Id;
@property (weak, nonatomic) IBOutlet NSString *Category_id;
@property (weak, nonatomic) IBOutlet UITableView *sub4Q2_tableView;

@end
