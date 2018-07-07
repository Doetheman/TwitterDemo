//
//  ProfileViewController.h
//  twitter
//
//  Created by Dorian Holmes on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "User.h"
#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
//Tableview displays cells a tweets
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
