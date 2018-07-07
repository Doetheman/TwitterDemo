//
//  ProfileCellTableViewCell.m
//  twitter
//
//  Created by Dorian Holmes on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileCellTableViewCell.h"
#import "User.h"
#import "Tweet.h"
#import <UIIMageView+AFNetworking.h>
#import "APIManager.h"
@implementation ProfileCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void) setTweet:(Tweet*) tweet{
    tweet = tweet;
    self.profileName.text = tweet.user.screenName;
    self.twitterName.text = tweet.user.name;
    self.heartCount.text = [NSString stringWithFormat:@"%i",self.tweet.favoriteCount];
    [self.retweetCount.text = NSString stringWithFormat:@"%i", self.retweetCount ];
 
    self.timePosted.text = tweet.timeStamp;
     [self.profileImage setImageWithURL: tweet.user.imageURL];
    self.profileImage.layer.cornerRadius = 45;
    self.profileImage.clipsToBounds = true;
    

    
    @property (weak, nonatomic) IBOutlet UILabel *textView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
