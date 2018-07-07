//
//  TweetCell.h
//  twitter
//
//  Created by Dorian Holmes on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "Tweet.h"
#import "User.h"
#import <UIKit/UIKit.h>


@protocol TweetCellDelegate;

@interface TweetCell : UITableViewCell

@property (nonatomic, weak) id<TweetCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@property (weak, nonatomic) IBOutlet UILabel *screenName;


@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *heartLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) Tweet *tweet;



@end

@protocol TweetCellDelegate
-(void) tweetCell:(TweetCell *)tweetCell didTap:(User *) user;

@end
