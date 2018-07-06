//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "ComposeViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetDetailViewController.h"
#import <UIIMageView+AFNetworking.h>
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface TimelineViewController ()  <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *tweetsArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation TimelineViewController

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
    // Get timeline
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    //Check for different segues
    if ([segue.identifier isEqualToString: @"compose"]) {
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    
    } else {
        //Creating controller object for segue
        TweetDetailViewController *tweetDetail = (TweetDetailViewController*)[segue destinationViewController];
        //Selected cell
        UITableViewCell *tappedCell = sender;
        //index for specific cell
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        //Index for tweet array
        Tweet *selectedTweet = self.tweetsArray[indexPath.row];
        //Setting tweet to selected view controler
        tweetDetail.tweetDetail = selectedTweet;
    }
 
    
    
}



- (UITableViewCell *)tableView:( UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Tweet *tweet = self.tweetsArray[indexPath.row];
    cell.tweet = tweet;
    
    return cell;
    
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%@", [NSString stringWithFormat:@"there are this many tweets %lu", self.tweetsArray.count]);
        return self.tweetsArray.count;
}
//checks if tweet was successful
- (void)didTweet:(Tweet *)tweet {
    [[APIManager shared]postStatusWithText:@"This is my tweet 😀" completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
        
            NSLog(@"Compose Tweet Success!");
        }
    }];
}
- (IBAction)logOut:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

@end
    
