//
//  User.m
//  twitter
//
//  Created by Dorian Holmes on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "Tweet.h"
#import "User.h"

@implementation User
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.imageURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
    }
    return self;
}


@end
