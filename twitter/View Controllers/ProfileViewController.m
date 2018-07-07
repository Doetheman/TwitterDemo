//
//  ProfileViewController.m
//  twitter
//
//  Created by Dorian Holmes on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "ProfileViewController.h"
#import "ComposeViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetDetailViewController.h"
#import <UIIMageView+AFNetworking.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"

@interface ProfileViewController ()<UITableViewDataSource, UITableViewDelegate,  TweetCellDelegate>
@property (strong, nonatomic) NSMutableArray *tweetsArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIView *name;
@property (weak, nonatomic) IBOutlet UILabel *twitterName;
@property (weak, nonatomic) IBOutlet UILabel *profileDescription;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tweetsArray = [NSMutableArray array];
    
    //Pull down refresh tweets
    [self fetchTweets];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    //Size of tableview
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

-(void)setupLabels: (User *) user{
    [self.backGroundImage setImageWithURL: user.banner];
    [self.profilePic setImageWithURL: user.profileImage];
    self.profileDescription.text = user.descriptionOfProfile;
    self.twitterName.text = user.iD;
    self.followerCount.text= [NSString stringWithFormat:@"%i",user.followers];
    self.followingCount.text = [NSString stringWithFormat:@"%i",user.friends];

    
}

//Generate tweets
- (void)fetchTweets {
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            
            self.tweetsArray = [NSMutableArray arrayWithArray:tweets];
            [self.tableView reloadData];
            
            
            
        } else{
            
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            
        }
        
    }];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    
    
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell" forIndexPath:indexPath];
    Tweet *tweet = self.tweetsArray[indexPath.row];
    cell.tweet = tweet;
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return self.tweetsArray.count;
}



- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user {
    [self performSegueWithIdentifier:@"profileViewController" sender:user];
}



@end
