//
//  5StepsQ1ViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _StepsQ1ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSString *Id;
@property (strong, nonatomic) IBOutlet UITableView *q1_tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_View;


@end
