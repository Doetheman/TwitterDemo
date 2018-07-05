//
//  TweetCell.m
//  twitter
//
//  Created by Dorian Holmes on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "User.h"
#import "Tweet.h"
#import <UIIMageView+AFNetworking.h>
#import "APIManager.h"
@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}
- (void) setTweet:(Tweet *)tweet{
    _tweet = tweet;
   // self.celIImage;
    self.authorLabelCell.text = tweet.user.name;
    self.tweetTextLabelCell.text = tweet.text;
    self.replyLabelCell.text = tweet.idStr;
    self.screenName.text = tweet.user.screenName;
    self.dateLabelCell.text = tweet.createdAtString;
    self.retweetLabelCell.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.heartLabelCell.text =[NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    [self.cellImage setImageWithURL: tweet.user.imageURL];
     self.cellImage.layer.cornerRadius = 50;
    self.cellImage.clipsToBounds = true;

    
    
}
- (IBAction)didRetweet:(id)sender {
    // TODO: Update the local tweet model
    if (self.tweet.retweeted) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    } else {
            self.tweet.retweeted = YES;
            self.tweet.retweetCount += 1;
            
            [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if(error){
                    NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                }
                else{
                    NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                }
            }];
    }
 
}

- (IBAction)didTapFavorite:(UIButton *)sender {
    if (self.tweet.favorited ) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
       
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
   
}

- (void)refreshData:(Tweet*)tweet{
    _tweet = tweet;
    // self.celIImage;
    self.authorLabelCell.text = tweet.user.name;
    self.tweetTextLabelCell.text = tweet.text;
    self.replyLabelCell.text = tweet.idStr;
    self.screenName.text = tweet.user.screenName;
    self.dateLabelCell.text = tweet.createdAtString;
    self.retweetLabelCell.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.heartLabelCell.text =[NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    [self.cellImage setImageWithURL: tweet.user.imageURL];
    self.cellImage.layer.cornerRadius = self.cellImage.frame.size.width / 2;

}


@end
