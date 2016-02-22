//
//  Sub1ViewController.h
//  Q4Solutions
//
//  Created by Promatics on 12/12/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sub1ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSString *Id;

@property (weak, nonatomic) IBOutlet NSString *Category_id;

@property (weak, nonatomic) IBOutlet UITableView *WorkingQ1_tebleView;


@end
