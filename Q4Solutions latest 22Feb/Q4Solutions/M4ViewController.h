//
//  M4ViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/12/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M4ViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSString *Id;

@property (weak, nonatomic) IBOutlet NSString *Category_id;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll_View;

@property (strong, nonatomic) IBOutlet UITableView *m4_tableView;

@end
