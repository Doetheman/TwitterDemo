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

- (instancetype)initWithDictionary:(NSDictionary *) dictionary;

@end
