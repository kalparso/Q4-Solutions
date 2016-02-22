//
//  MenuViewController.m
//  Q4Solutions
//
//  Created by promatics on 11/26/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "UserPicTableViewCell.h"
#import "Google/Analytics.h"



@interface MenuViewController () {
    
    MenuTableViewCell *menuCell;
    UserPicTableViewCell *userPicCell;
    NSArray *menuArray;
    NSArray *userData;
    
}

@end

@implementation MenuViewController

@synthesize menu_tableView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    menu_tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [self setMenuData];
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    
    [self setMenuData];
    
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    userData =[[NSUserDefaults standardUserDefaults]valueForKey:@"user_Info"];
    
    
    
    NSString *fname = [userData valueForKey:@"firstname"];
    
    NSString *lname = [userData valueForKey:@"lastname"];
    
    lname = [@" " stringByAppendingString:lname];
    
    NSString *name = [fname stringByAppendingString:lname];
    [tracker set:kGAIScreenName value:name];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    
}

-(void)setMenuData {
    
    menuArray = @[
//                  @{
//                      @"title" : @"Share App",
//                      @"image" : @"share",
//                      @"action" :@"termConditions",
//                      @"items" : @[
//                              ]
//                      },
                  @{
                      @"title" : @"About Us",
                      @"image" : @"about us",
                      @"action" :@"AboutUs",
                      @"items" : @[
                              
                              
                              ]
                      },
                  @{
                      @"title" : @"Contact Us",
                      @"image" : @"contact us",
                      @"action" :@"ContactUs",
                      @"items" : @[
                              
                              ]
                      },
                  
                  @{
                      
                      @"title" : @"Privacy Policy",
                      @"image" : @"privacy",
                      @"action" :@"PrivacyPolicy",
                      @"items" : @[
                              ]
                      },
                  
                  @{
                      @"title" : @"Logout",
                      @"image" : @"logout",
                      @"action" :@"Logout",
                      @"items" : @[
                              
                              ]
                      }
                  ];
    
    [menu_tableView reloadData];
    
}



#pragma mark- UITableViewDataSources & Delegates

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    
    UILabel *label;
    
    UIImageView *image_view;
    
    UIView *line_view = [[UIView alloc] init];
    
    UIButton *action_btn = [[UIButton alloc] init];
    
    if (section == 0) {
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1.5)];
        
    }
    else {
        
        section = section-1 ;
        
        image_view = [[UIImageView alloc]init];
        UIView *lv;
        
        UIStoryboard *storyboard;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            storyboard = [UIStoryboard storyboardWithName:@"Main.ipad" bundle:nil];
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,60)];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(55,6,tableView.frame.size.width-60, 50)];
            
            image_view.frame = CGRectMake(20,18,25, 25);
            
            line_view.frame = CGRectMake(0, 58, self.view.frame.size.width, 2);
            
            [label setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:20.0f]];
            
            lv= [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 2)];
            
        } else {
            
            storyboard = [UIStoryboard storyboardWithName:@"Main.iphone" bundle:nil];
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.frame.size.width, 50)];
            
            label = [[UILabel alloc] initWithFrame:CGRectMake(35,5,tableView.frame.size.width-20, 40)];
            
            image_view.frame = CGRectMake(10,15,18, 18);
            
            line_view.frame = CGRectMake(0,48.5, self.view.frame.size.width, 1.5);
            
            [label setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:17.0f]];
            
            lv= [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 1.5)];
        }
        
        action_btn.frame = label.frame;
        action_btn.titleLabel.textColor = [UIColor clearColor];
    {
            
            [action_btn addTarget:self action:NSSelectorFromString([NSString stringWithFormat:@"%@",[[menuArray objectAtIndex:section] valueForKey:@"action"]]) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:action_btn];
        }
        // view.backgroundColor = UIColorFromRGB(tbl_greyColor);
        view.backgroundColor = [UIColor whiteColor];
        
        // line_view.backgroundColor = [UIColor whiteColor];
        
        line_view.backgroundColor = [UIColor darkGrayColor];
        
        lv.backgroundColor = [UIColor darkGrayColor];
        
        //label.textColor = [UIColor whiteColor];
        
        label.textColor = [UIColor redColor];
        
        
        [label setText:[[menuArray objectAtIndex:section] valueForKey:@"title"]];
        
        [image_view setImage:[UIImage imageNamed:[[menuArray objectAtIndex:section] valueForKey:@"image"]]];
        
        [view addSubview:image_view];
        
        if (section == 0) {
            
            [view addSubview:lv];
        }
    }
    
    // line_view.backgroundColor = [UIColor whiteColor];
    //    line_view.backgroundColor = [UIColor darkGrayColor];
    
    [view addSubview:line_view];
    
    [view addSubview:label];
    
    CALayer *layer = view.layer;
    
    //changed to zero for the new fancy shadow
    
    layer.shadowOffset = CGSizeZero;
    
    layer.shadowColor = [[UIColor whiteColor] CGColor];
    
    //changed for the fancy shadow
    
    layer.shadowRadius = 1.0f;
    
    layer.shadowOpacity = 0.30f;
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [menuArray count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height;
    
    if (indexPath.section == 0) {
        
        UIStoryboard *storyboard;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            storyboard = [UIStoryboard storyboardWithName:@"Main.ipad" bundle:nil];
            
            height = 107;
            
        } else {
            
            storyboard = [UIStoryboard storyboardWithName:@"Main.iphone" bundle:nil];
            
            height = 68;
        }
        
        return height;
        
    } else {
        
        UIStoryboard *storyboard;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            storyboard = [UIStoryboard storyboardWithName:@"Main.ipad" bundle:nil];
            
            height = 55;
            
        } else {
            
            storyboard = [UIStoryboard storyboardWithName:@"Main.iphone" bundle:nil];
            
            height = 45;
        }
        return height;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGFloat height;
    
    // int sec = (int)(navigationMenu.count -5);
    
    if (section == 0) {
        return 0;
    }
    
    //    if (section > sec) {
    //
    //        return 2;
    //    }
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main.ipad" bundle:nil];
        
        height = 60;
        
    } else {
        
        storyboard = [UIStoryboard storyboardWithName:@"Main.iphone" bundle:nil];
        
        height = 50;
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
        
    } else {
        
        section = section-1;
        
        return [[[menuArray objectAtIndex:section] valueForKey:@"items"]count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int sec = (int)(menuArray.count-5);
    
    if (indexPath.section == 0) {
        
        userPicCell = [tableView dequeueReusableCellWithIdentifier:@"userPicCell" forIndexPath:indexPath];
        
        userPicCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        userPicCell.userPic.layer.cornerRadius = userPicCell.userPic.frame.size.height/2;
        
        if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) {
            
            userPicCell.userPic.layer.borderWidth = 5.0f;
            
        } else {
            
            userPicCell.userPic.layer.borderWidth = 3.0f;
        }
        userPicCell.userPic.layer.borderColor = [UIColor whiteColor].CGColor;
        
        userPicCell.backgroundColor = [UIColor whiteColor];
        
        
        
        return userPicCell;
        
    }
    else if (indexPath.section > sec) {
        
        menuCell = (MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"menuCell" forIndexPath:indexPath];
        
        if(menuCell == nil) {
            
            menuCell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menuCell"];
        }
        
        menuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        menuCell.lbl.text = [[[[menuArray objectAtIndex:indexPath.section-1] valueForKey:@"items"] objectAtIndex:indexPath.row] valueForKey:@"title"];
        
        
        
        menuCell.backgroundColor = [UIColor whiteColor];
        
        UIImageView *image_view = [[UIImageView alloc] init];
        
        image_view.frame = CGRectMake(10,0,18, 18);
        
        UIStoryboard *storyboard;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            storyboard = [UIStoryboard storyboardWithName:@"Main.ipad" bundle:nil];
            
            image_view.frame = CGRectMake(20,18,25, 25);
            
            CGRect frame = menuCell.lbl.frame;
            frame.origin.x = 55;
            frame.origin.y = 15;
            menuCell.lbl.frame = frame;
            
            // [cell.lbl setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:20.0f]];
            
        } else {
            
            storyboard = [UIStoryboard storyboardWithName:@"Main.iphone" bundle:nil];
            
            image_view.frame = CGRectMake(10,15,18, 18);
            
            CGRect frame = menuCell.lbl.frame;
            frame.origin.x = 35;
            frame.origin.y = 15;
            menuCell.lbl.frame = frame;
            
                    }
        
        
        
        return menuCell;
        
    } else {
        
        menuCell = (MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"menuCell" forIndexPath:indexPath];
        
        if(menuCell == nil) {
            
            menuCell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menuCell"];
        }
        
        menuCell.lbl.text = [[[[menuArray objectAtIndex:indexPath.section-1] valueForKey:@"items"] objectAtIndex:indexPath.row] valueForKey:@"title"];
        
        // cell.backgroundColor = UIColorFromRGB(tbl_greyColor);
        
        menuCell.backgroundColor = [UIColor whiteColor];
        
        
        
        menuCell.lbl.textColor = [UIColor redColor];
        
        
        menuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return menuCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.section);
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        NSLog(@"dfgdfg");
        
    } else {
        
      
        
     
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    }
    
}

-(void)termConditions{
    
    NSArray *activityItems = [NSArray arrayWithObjects: @"share_text.text", @"share_image.image" , nil];
    
    //    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    //    [self presentViewController:activityController animated:YES completion:nil];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:controller animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

-(void)AboutUs{
    [self performSegueWithIdentifier:@"about_us" sender:self];
}

-(void)ContactUs{
    
    
    // BOOL canOpenURL =  [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://q4solutions.com"]];
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://q4solutions.com"]];
    
    [self performSegueWithIdentifier:@"contect_us" sender:self];
    
}

-(void)PrivacyPolicy{
    
    [self performSegueWithIdentifier:@"privacy_and_plicies" sender:self];
}
-(void)Logout{
    
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"login"];
    [self performSegueWithIdentifier:@"logoutSague" sender:self];
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
