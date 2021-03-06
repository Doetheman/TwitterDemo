//
//  ComposeViewController.m
//  twitter
//
//  Created by Dorian Holmes on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//
#import "APIManager.h"
#import "Tweet.h"
#import "ComposeViewController.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// closes view
- (IBAction)Close:(UIBarButtonItem *)sender {
     [self dismissViewControllerAnimated:true completion:nil];

}

- (IBAction)Tweet:(UIBarButtonItem*)sender {
    [[APIManager shared]postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
                 [self dismissViewControllerAnimated:true completion:nil];
            
        }
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
