//
//  TweetCellDelegate.h
//  twitter
//
//  Created by Dorian Holmes on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TweetCellDelegate <NSObject>
//Required method for tap gesture 
-(void)tweetCell:(tweetCell*) TweetCell didTap: (User *) user;

@end
