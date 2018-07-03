//
//  Tweet.h
//  twitter
//
//  Created by Dorian Holmes on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "User.h"
#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *idStr; //Favoriting, retweeting & replying
@property (strong, nonatomic) NSString *text; //Text content of tweet
@property (nonatomic) int favoriteCount; //Update fav count label
@property (nonatomic) BOOL favorited; //Configure button
@property (nonatomic) int retweetCount; // Configure retweet button
@property (nonatomic) BOOL retweeted; //Configure button
@property (strong, nonatomic) User *user; //Name, screenname, etc. of tweet author
@property (strong, nonatomic) NSString *createdAtString; //Display
@property (strong,nonatomic) User *retweetedByUser; //User who retweetedif retweeted
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;
- (instancetype)initWithDictionary:(NSDictionary *) dictionary;
@end
