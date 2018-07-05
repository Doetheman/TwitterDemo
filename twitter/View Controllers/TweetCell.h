//
//  TweetCell.h
//  twitter
//
//  Created by Dorian Holmes on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "Tweet.h"
#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@property (weak, nonatomic) IBOutlet UILabel *screenName;

@property (weak, nonatomic) IBOutlet UILabel *replyLabelCell;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabelCell;


@property (weak, nonatomic) IBOutlet UILabel *heartLabelCell;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabelCell;
@property (weak, nonatomic) IBOutlet UILabel *authorLabelCell;


@property (weak, nonatomic) IBOutlet UILabel *dateLabelCell;
@property (strong, nonatomic) Tweet *tweet;


@end
