//
//  ProfileCellTableViewCell.h
//  twitter
//
//  Created by Dorian Holmes on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *twitterName;

@property (weak, nonatomic) IBOutlet UILabel *timePosted;

@property (weak, nonatomic) IBOutlet UILabel *heartCount;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;

@property (weak, nonatomic) IBOutlet UILabel *textView;

@end
