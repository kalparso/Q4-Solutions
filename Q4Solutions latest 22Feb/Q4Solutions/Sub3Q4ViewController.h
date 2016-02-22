//
//  Sub3Q4ViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/12/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sub3Q4ViewController : UIViewController<UITabBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_View;
@property (weak, nonatomic) IBOutlet NSString *Id;
@property (weak, nonatomic) IBOutlet NSString *Category_id;
@property (weak, nonatomic) IBOutlet UITableView *sub3Q4_tableView;

@end
