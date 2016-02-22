//
//  5StepsQ4ViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _StepsQ4ViewController : UIViewController<UITabBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_View;
@property (weak, nonatomic) IBOutlet NSString *Id;
@property (weak, nonatomic) IBOutlet UITableView *workingQ3_tableView;

@end
