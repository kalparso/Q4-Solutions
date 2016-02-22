//
//  CstmNavViewController.m
//  Q4Solutions
//
//  Created by Promatics on 11/27/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "CstmNavViewController.h"

@interface CstmNavViewController ()

@end

@implementation CstmNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [UITabBarItem.appearance setTitleTextAttributes:
//     
//     @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.424 green:0.29 blue:0.529 alpha:1]}
//     
//                                           forState:UIControlStateNormal];
//    
    // then if StateSelected should be different, you should add this code
    
      [UITabBarItem.appearance setTitleTextAttributes:
    
         @{NSForegroundColorAttributeName : [UIColor whiteColor]}
    
                                              forState:UIControlStateSelected];
      
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"search_icon_white"];
    
    //                                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
