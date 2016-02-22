//
//  Q2ViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Q2ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scroll_View;
@property (weak, nonatomic) IBOutlet UITableView *Q2_tableView;

@end
