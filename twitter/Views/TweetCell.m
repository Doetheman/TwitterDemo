//
//  TweetCell.m
//  twitter
//
//  Created by Dorian Holmes on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "User.h"
#import <UIIMageView+AFNetworking.h>
@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}- (void) setTweet:(Tweet *)tweet{
    _tweet = tweet;
   // self.celIImage;
    self.authorLabelCell.text = tweet.user.name;
    self.tweetTextLabelCell.text = tweet.text;
    self.replyLabelCell.text = tweet.idStr;
    [self.cellImage setImageWithURL: tweet.user.imageURL];
    
}


@end
