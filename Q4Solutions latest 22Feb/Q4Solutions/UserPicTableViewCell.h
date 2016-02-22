//
//  UserPicTableViewCell.h
//  Q4Solutions
//
//  Created by promatics on 11/26/15.
//  Copyright (c) 2015 promatics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserPicTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userPic;
@property (strong, nonatomic) IBOutlet UIButton *name_btn;
@property (strong, nonatomic) IBOutlet UILabel *profile;


@end
