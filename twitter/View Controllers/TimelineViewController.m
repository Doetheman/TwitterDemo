//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
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

@interface TimelineViewController ()  <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate>

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
    //Size of tableview
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
//Segue from one view controller to another
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    //Check for different segues
    if ([segue.identifier isEqualToString: @"compose"]) {
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    
    }else if([segue.identifier isEqualToString:@"profileViewController"]){
        ProfileViewController *profileViewController = (ProfileViewController*)[segue destinationViewController];
        //index for specific cell
        profileViewController.user = sender;
        
    } else{
        //Creating controller object for segue
        TweetDetailViewController *tweetDetail = (TweetDetailViewController*)[segue destinationViewController];
        //Selected cell
        UITableViewCell *tappedCell = sender;
        //index for specific cell
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        //Index for tweet array
        Tweet *selectedTweet = self.tweetsArray[indexPath.row];
        //Setting tweet to selected view controler
        tweetDetail.selectedTweetDetails = selectedTweet;
    }
 
    
    
}


//Puts tweets in cell
- (UITableViewCell *)tableView:( UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Tweet *tweet = self.tweetsArray[indexPath.row];
    cell.tweet = tweet;
    cell.delegate = self;
    return cell;
    
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Displays amount of tweets in console
    NSLog(@"%@", [NSString stringWithFormat:@"there are this many tweets %lu", self.tweetsArray.count]);
    //Create number of rows based on tweets
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
//Logout user
- (IBAction)logOut:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

//Transfers user information to profileViewController to dispay selected cell profile
- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user {
    
    [self performSegueWithIdentifier:@"profileViewController" sender:user];

}



@end
    
