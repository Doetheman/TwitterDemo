//
//  TimelineViewController.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "Tweet.h"
#import <UIKit/UIKit.h>

@interface TimelineViewController : UIViewController
//Tableview to show cells
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet Tweet *tweet;

@end
