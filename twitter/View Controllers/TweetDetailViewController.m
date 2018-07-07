//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Dorian Holmes on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "ComposeViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import <UIIMageView+AFNetworking.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetDetailViewController.h"

@interface TweetDetailViewController () 
@property (weak, nonatomic) IBOutlet TweetCell *tweetCell;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateCell];
}

-(void) updateCell{
    self.tweetCell.tweet = self.selectedTweetDetails;
    
}

- (void) fetchTweet{
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            

            
            
            
        } else{
            
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            
        }
        
    }];

    
    
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
