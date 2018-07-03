//
//  Tweet.m
//  twitter
//
//  Created by Dorian Holmes on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "User.h"
#import "Tweet.h"

@implementation Tweet
-(instancetype) initWithDictionary: (NSDictionary *)dictionary{
    self = [super init];
    if(self){
        //Is it a retweet
        NSDictionary *originalTweet = dictionary[@"retweet_status"];
        if (originalTweet != nil) {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            //Change tweet to original
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"]boolValue];
        self.favorited = [dictionary[@"favorited"]boolValue];
        self.retweetCount = [dictionary[@"retweeted_count"]boolValue];
        self.retweeted = [dictionary[@"retweeted"]boolValue];
        //intialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        //format date string
        NSString *createdAtOriginalString = dictionary [@"created_at"];
        NSDateFormatter * formatter= [[NSDateFormatter alloc]init];
        //Configure input formate to parse the date string
        formatter.dateFormat= @"E MMM d HH: mm:ss Z y";
        //Convert string to date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        //Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        //Convert Date to String
        self.createdAtString = [formatter stringFromDate:date];
        
    }
    return self;
}
+ (NSMutableArray *)tweetsWithArray: (NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for(NSDictionary *dictionary in dictionaries){
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];[tweets addObject:tweet];
    }
    return tweets;
}
@end
