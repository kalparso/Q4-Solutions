//
//  M5ViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/12/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M5ViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSString *Id;

@property (weak, nonatomic) IBOutlet NSString *Category_id;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll_View;

@property (strong, nonatomic) IBOutlet UITableView *m5_tableView;

@end
