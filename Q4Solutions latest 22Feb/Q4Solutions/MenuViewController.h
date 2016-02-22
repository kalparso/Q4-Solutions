//
//  MenuViewController.h
//  Q4Solutions
//
//  Created by promatics on 11/26/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *menu_tableView;


@end
