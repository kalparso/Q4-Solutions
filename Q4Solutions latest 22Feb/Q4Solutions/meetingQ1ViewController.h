//
//  meetingQ1ViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/11/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface meetingQ1ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_View;

@property (weak, nonatomic) IBOutlet NSString *Id;
@property (weak, nonatomic) IBOutlet UITableView *meetingQ1_tableView;

@end
