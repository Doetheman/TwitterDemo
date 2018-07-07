//
//  User.h
//  twitter
//
//  Created by Dorian Holmes on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
//All publlic properties and methods are added to .h file
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong,nonatomic) NSString *descriptionOfProfile;
@property (strong,nonatomic) NSURL *banner;
@property (nonatomic) int followers;
@property (nonatomic) int friends;
@property (strong, nonatomic) NSString *iD;
@property (strong, nonatomic) NSURL *profileImage;
- (instancetype)initWithDictionary:(NSDictionary *) dictionary;

@end
