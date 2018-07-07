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
    UITapGestureRecognizer *userProfileTapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action: @selector(userTapOnProfile:)];
    [self.cellImage addGestureRecognizer:userProfileTapAction];
    [self.cellImage setUserInteractionEnabled:YES];
}
// Configure the view for the selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
- (void) userTapOnProfile: (UIGestureRecognizer *)sender{
    [self.delegate tweetCell:self didTap:self.tweet.user];

}

//Set tweet objects from API resource
- (void) setTweet:(Tweet *)tweet{
    _tweet = tweet;
   // self.celIImage;
    self.authorLabel.text = tweet.user.name;
    self.tweetTextLabel.text = tweet.text;
    //self.replyLabel.text = tweet.idStr;
    self.screenName.text = tweet.user.screenName;
    self.dateLabel.text = tweet.createdAtString;
    self.retweetLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.heartLabel.text =[NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.timeLabel.text = tweet.timeStamp;
    [self.cellImage setImageWithURL: tweet.user.imageURL];
//Make image round
     self.cellImage.layer.cornerRadius = 45;
    self.cellImage.clipsToBounds = true;

    
    
}
//Action of retweet button
- (IBAction)didRetweet:(id)sender {
    if (self.tweet.retweeted) {
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.tweet.retweeted = NO;
                self.tweet.retweetCount -= 1;
                [self refreshData:self.tweet];
            }
        }];
    } else {

            
            [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if(error){
                    NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                }
                else{
                    NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                    self.tweet.retweeted = YES;
                    self.tweet.retweetCount += 1;
                    [self refreshData:self.tweet];
                }
            }];
    }
 
}
//Action of heart button
- (IBAction)didTapFavorite:(UIButton *)sender {
    if (self.tweet.favorited ) {
       
       
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.tweet.favorited = NO;
                self.tweet.favoriteCount -= 1;
                [self refreshData:self.tweet];
            }
        }];
    } else {
      
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.tweet.favorited = YES;
                self.tweet.favoriteCount += 1;
                [self refreshData:self.tweet];
            }
        }];
    }
   
}
// TODO: Update the local tweet model
- (void)refreshData:(Tweet*)tweet{
    _tweet = tweet;
    // self.celIImage;
    self.authorLabel.text = tweet.user.name;
    self.tweetTextLabel.text = tweet.text;
    //self.replyLabelCell.text = tweet.idStr;
    self.screenName.text = tweet.user.screenName;
    self.dateLabel.text = tweet.createdAtString;
    self.retweetLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.heartLabel.text =[NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    [self.cellImage setImageWithURL: tweet.user.imageURL];
    self.cellImage.layer.cornerRadius = self.cellImage.frame.size.width / 2;

}


@end
